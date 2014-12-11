# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# Code for running annual plant model with storage effect operating #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

####
#### Load libraries
####
library(mvtnorm)
library(ggplot2)

####
#### Get model functions from source
####
source("annualPlantStorage_Functions.R")


####
#### Set model parameters
####
# s = survival of seeds in seedbanl
# N = abundance of seeds
# lambda = per capita fecundity
# alpha = competition coefficients
# rho = correlation between species' germination rates
# sigE = environmental variance (for germination rates)
s1 <- 0.5
s2 <- 0.5
lambda1 <- 100
lambda2 <- 100
alpha11 <- 1
alpha12 <- 1
alpha21 <- 1
alpha22 <- 1
sigE <- 2
rho <- 0
timeSim <- 100
initialN <- 100


####
#### Get germination vectors
####
gVec <- getG(sigE = sigE, rho = rho, nTime = timeSim)
gVec1 <- gVec[,1]
gVec2 <- gVec[,2]


####
#### Run model
####
Nsave <- matrix(nrow=timeSim, ncol=2)
Nsave[1,] <- initialN

for(t in 2:timeSim){
  N1 <- Nsave[t-1,1]
  N2 <- Nsave[t-1,2]
  params <- list(s1 = 0.5,
                 s2 = 0.5,
                 lambda1 = 100,
                 lambda2 = 100,
                 alpha11 = 1,
                 alpha12 = 1,
                 alpha21 = 1,
                 alpha22 = 1,
                 g1 = gVec1[t],
                 g2 = gVec2[t])
  
  newN <- annPlantStorage(params = params, N1 = N1, N2 = N2)
  Nsave[t,1] <- newN[1]
  Nsave[t,2] <- newN[2]
}

####
#### Plot results
####
plotD <- data.frame(Abundance = c(Nsave[,1], Nsave[,2]),
                    Species = c(rep("A",timeSim), rep("B", timeSim)),
                    Time = seq(1,timeSim,1))

ggplot(plotD, aes(x=Time, y=Abundance, color=Species))+
  geom_line(size=2)+
  scale_color_manual(values=c("grey25", "darkorange"))+
  ylab("Seed Abundance")+
  theme_bw()





