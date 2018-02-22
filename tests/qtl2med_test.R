# Test code.
library(devtools)
setwd("C:/Users/dgatti/Documents/Packages/qtl2med/")
load_all()

build = 90
chr = 13
pos = 112.205823
cc_dbfile = "C:/Users/dgatti/Documents/Sanger/cc_variants.sqlite"

ensembl = get_ensembl_genes(chr = chr, build = build)
gp = get_allele_probs(chr = chr, pos = pos, genoprobs = genoprobs, map = map)

med = mediate(pheno = pheno,
              chr = chr,
              pos = pos,
              type = "haplo",
              expr = expr,
              ensembl = ensembl,
              genoprobs = genoprobs,
              addcovar = addcovar)

plot_med(med = med, threshold = 6)

query_fxn = qtl2::create_variant_query_func(cc_dbfile, filter = "type=='snp'")
sp = get_snp_probs(chr = chr, pos = pos, genoprobs = genoprobs,
                   map = map, query_fxn = query_fxn)
med = mediate(pheno = pheno,
              chr = chr,
              pos = pos,
              type = "snp",
              expr = expr,
              ensembl = ensembl,
              genoprobs = genoprobs,
              addcovar = addcovar,
              cc_dbfile = cc_dbfile)

plot_med(med = med, threshold = 6)
