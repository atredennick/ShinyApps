# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Build for annual plant model with storage effect operating #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

####
#### Load libraries
####
library(mvtnorm)

####
#### Model parameters
####
# s = survival of seeds in seedbanl
# g = germination rate
# N = abundance of seeds
# lambda = per capita fecundity
# alpha = competition coefficients
# rho = correlation between species' germination rates
# sigE = environmental variance (for germination rates)

####
#### Model function
####
annPlantStorage <- function(params, N1, N2){
  s1 <- params$s1
  s2 <- params$s2
  g1 <- params$g1
  g2 <- params$g2
  lambda1 <- params$lambda1
  lambda2 <- params$lambda2
  alpha11 <- params$alpha11
  alpha12 <- params$alpha12
  alpha22 <- params$alpha22
  alpha21 <- params$alpha21
  
  newN1 <- s1*(1-g1)*N1 + ((lambda1*g1*N1) / (1 + alpha11*g1*N1 + alpha12*g2*N2))
  newN2 <- s2*(1-g2)*N2 + ((lambda2*g2*N2) / (1 + alpha21*g1*N1 + alpha22*g2*N2))
  
  newNs <- c(newN1, newN2)
  return(newNs)
}

####
#### Germination rate time series function
####
getG <- function(sigE, rho, nTime){
  varcov <- matrix(c(sigE, rho*sigE, rho*sigE, sigE), 2, 2)
  e <- rmvnorm(n = nTime, mean = c(0,0), sigma = varcov)
  g <- exp(e) / (1+exp(e))
  return(g)
}

