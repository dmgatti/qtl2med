context("ensembl")

test_that("can get ensembl genes", {
  
  ensembl = get_ensembl_genes(chr = "13", build = 90)
  
  expect_equal(nrow(ensembl), 2500)
  expect_equal(ncol(ensembl), 7)
  expect_equal(colnames(ensembl), c("ensembl", "symbol", "chr", "start", "end", "strand", "biotype"))
  expect_equal(as.character(unique(ensembl$chr)), "13")
  
})