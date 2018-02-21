# Test code.
data.dir = "D:/Attie_DO_Islet_RNASeq/data/"

# Load in the Attie data.
load(paste0(data.dir, "Attie_DO378_eQTL_viewer_v6.Rdata"))

build = 90
chr = 5
pos = 147.3
cc_dbfile = "C:/Users/dgatti/Documents/Sanger/cc_variants.sqlite"

ensembl = get_ensembl_genes(chr = chr, build = build)
gp = get_allele_probs(chr = chr, pos = pos, genoprobs = genoprobs, map = map)

query_fxn = qtl2::create_variant_query_func(cc_dbfile, filter = "type=='snp'")

sp = get_snp_probs(chr = chr, pos = pos, genoprobs = genoprobs,
                   map = map, query_fxn = query_fxn)

ds = dataset.islet.hotspots
addcovar = ds$covar

med = mediate(pheno = ds$pheno[,"chr5", drop = FALSE],
              chr = chr,
              pos = pos,
              type = "haplo",
              expr = dataset.islet.rnaseq$expr,
              ensembl = ensembl,
              genoprobs = genoprobs,
              addcovar = addcovar,
              cc_dbfile = cc_dbfile)

