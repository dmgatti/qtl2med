context("mediate genoprobs")

test_that("can mediate with genoprobs", {
  
  chr = 13
  pos = 112.205823
  
  ensembl = get_ensembl_genes(chr = chr, build = build)
  
  med = mediate(pheno = pheno,
                chr = chr,
                pos = pos,
                type = "haplo",
                expr = expr,
                ensembl = ensembl,
                genoprobs = genoprobs,
                addcovar = addcovar)
  
  expect_equal(nrow(med), 774)
  expect_equal(ncol(med), 5)
  expect_equal(colnames(med), c("ensembl", "lod", "symbol", "chr", "start"))
  expect_equivalent(med$symbol[which.min(med$lod)], "Il6st")
  
})
