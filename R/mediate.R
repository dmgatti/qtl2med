#' Regress one phenotype on the given genes at a single marker.
#'
#' @param pheno: numeric matrix with one column. Sample IDs must be in rownames and must match rownames in genoprobs.
#' @param chr: character containing a single chromosome ID.
#' @param pos: numeric value indicating the position in Mb at which to mediate.
#' @param type: character value that is either 'haplo' or 'snp', indicating which type of genotype values to mediate upon.
#' @param expr: numeric matrix containing the gene expression values. Sample names in rownames and Ensembl IDs in colnames.
#' @param ensembl: data.frame containing gene annotation as obtained from \code{get_ensembl_gene}.
#' @param genoprobs: list containing 3-dimensional arrays of allele probs, one for each chromosome. In qtl2 format. Samples in rows, 8 founders in columns, markers in slices.
#' @param addcovar: numeric matrix of additive covariates *without* the intercept. Sample IDs must be in rownames. Typically creates using model.matrix(~covar1 + covar2, data = data).
#' @param cc_dbfile: full path to the CC_SNP database file created by Karl Broman.
#' @return data.frame containing the mediation results.
mediate = function(pheno, chr, pos, type = c("haplo", "snp"), expr, ensembl,
          genoprobs, addcovar, cc_dbfile) {

  type = match.arg(type)

  query_fxn = create_variant_query_func(cc_dbfile, filter = "type=='snp'")

  # Get the genotype (Q).
  # NOTE: we remove the first column of genoprobs in the haplo probs case.
  Q = switch(type,
         haplo = get_allele_probs(chr = chr, pos = pos, genoprobs = genoprobs,
                 map = map)[,-1],
         snp = get_snp_probs(chr = chr, pos = pos, genoprobs = genoprobs,
                   map = map, query_fxn = query_fxn))

  Q = data.frame(mouse = rownames(Q), Q)

  # Set up two models to compare.
  # NOTE: We are computing the sum of squares of the residuals here.
  # Full model reressing phenotype on covariates, gene expression and genotype.
  full_mod = function(df) { sum(residuals(lm(pheno ~ ., data = df))^2) }
  # Reduced model reressing phenotype on covariates and gene expression.
  red_mod  = function(df) { sum(residuals(lm(pheno ~ ., data = select(df, -Q)))^2) }
  if(type == "haplo") {
    red_mod  = function(df) { sum(residuals(lm(pheno ~ ., data = select(df, -(B:H))))^2) }
  }
  
  pheno.df = data.frame(mouse = rownames(pheno), pheno = pheno[,1])
  common.genes = intersect(colnames(expr), ensembl$ensembl)
  expr = expr[,common.genes]
  ensembl = ensembl[match(common.genes, ensembl$ensembl),]
  stopifnot(all(colnames(expr) == ensembl$ensembl))
  expr.df  = data.frame(mouse = rownames(expr), expr)
  addcovar.df = data.frame(mouse = rownames(addcovar), addcovar)

  df = left_join(pheno.df, Q,  by = "mouse") %>%
           left_join(y = addcovar.df, by = "mouse") %>%
           left_join(y = expr.df, by = "mouse") %>%
           select(-mouse) %>%
           gather_("ensembl", "expr", colnames(.)[grep("^ENSMUSG", colnames(.))]) %>%
           group_by(ensembl) %>%
           nest()

  # NOTE: We compute the LOD as 0.5 * -num_samples * log10(full_ss / red_ss).
  num_samp = nrow(df$data[[1]])
  df = df %>% 
    mutate(full_ss = map_dbl(data, full_mod),
           red_ss  = map_dbl(data, red_mod)) %>%
    select(ensembl, full_ss, red_ss) %>%
    mutate(lod = 0.5 * -num_samp * log10(full_ss / red_ss)) %>%
    select(-full_ss, -red_ss)
  
  df = left_join(df, select(ensembl, ensembl:start), by = "ensembl") %>%
       mutate(start = start * 1e-6)

  return(df)

} # mediate()

