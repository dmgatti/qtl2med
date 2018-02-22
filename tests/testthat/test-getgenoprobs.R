context("genoprobs")

test_that("can get genoprobs", {
  
  chr = 13
  pos = 112.205823
  gp = get_allele_probs(chr = chr, pos = pos, genoprobs = genoprobs, map = map)
  
  expect_equal(nrow(gp), 500)
  expect_equal(ncol(gp), 8)
  expect_equal(colnames(gp), LETTERS[1:8])
  expect_equivalent(rowSums(gp), rep(1, 500))
  
})