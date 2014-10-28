
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  
  output$trad<- renderPlot({

    seed<-input$Seed1
    Dseed<-seed
    Sseed<-seed+10
    
    alpha<-input$alpha1 # competiion over distance
    N<-input$N1 #the number of neighbors
    Nseq<-seq(1,N, by=1)

    par(mfrow=c(2,2),mar=c(4,4,1,1))

    set.seed(Dseed)
    meanDist<-input$meanDist1
    sdDist<-meanDist/2
    distN<-rnorm(n=N, mean=meanDist, sd=sdDist)
    plot(distN~Nseq, ylim=c(0,max(distN)))
 
    set.seed(Sseed)
    meanSize<-input$meanSize1
    sdSize<-meanSize/2
    sizeN<-rnorm(n=N, mean=meanSize, sd=sdSize)
    plot(sizeN~Nseq, ylim=c(0,max(sizeN)))
    
    f<-(360/N)         #Distribution of angles
    xvec<-NA
    yvec<-NA

for(i in seq(1,N,1)){
    xvec[i]<-distN[i]*cos(f*(i-1)/(360/(2*pi)))            #X location of seeds with respect to center (0,0)
    yvec[i]<-distN[i]*sin(f*(i-1)/(360/(2*pi)))            #Y location of seeds with respect to center (0,0)
        }
    sizeNp<-sizeN/2
    maxc<-max(distN)+max(sizeNp)/2
    symbols(yvec~xvec, circles=sizeNp,inches=sizeNp, ylim=c(-maxc,maxc), xlim=c(-maxc,maxc))
    text(yvec~xvec, labels = Nseq)
    
    abline(h=0)
    abline(v=0)

    Cvec<-sizeN*exp(-alpha*distN^2)
    C<-round(sum(Cvec),3)
    mtext(bquote(C==.(C)), adj=1, padj=0)

    distSim<- seq(0, max(distN+1), by=.1)
    Csim<-mean(sizeN)*exp(-alpha*distSim^2)
    plot(Csim~distSim, type="l")
    text(Cvec~distN, labels = Nseq)


        })

output$grav<- renderPlot({
  
  seed<-input$Seed2
  Dseed<-seed
  Sseed<-seed+10
  
  sizei<-input$sizei
  
  alpha<-input$alpha2 # competiion over distance
  N<-input$N2 #the number of neighbors
  Nseq<-seq(1,N, by=1)
  
  par(mfrow=c(2,2),mar=c(4,4,1,1))
  
  set.seed(Dseed)
  meanDist<-input$meanDist2
  sdDist<-meanDist/2
  distN<-rnorm(n=N, mean=meanDist, sd=sdDist)
  plot(distN~Nseq, ylim=c(0,max(distN)))
  
  set.seed(Sseed)
  meanSize<-input$meanSize2
  sdSize<-meanSize/2
  sizeN<-rnorm(n=N, mean=meanSize, sd=sdSize)
  plot(sizeN~Nseq, ylim=c(0,max(sizeN)))
  
  f<-(360/N)         #Distribution of angles
  xvec<-NA
  yvec<-NA
  
  for(i in seq(1,N,1)){
    xvec[i]<-distN[i]*cos(f*(i-1)/(360/(2*pi)))            #X location of seeds with respect to center (0,0)
    yvec[i]<-distN[i]*sin(f*(i-1)/(360/(2*pi)))            #Y location of seeds with respect to center (0,0)
  }
  sizeNp<-sizeN/2
  maxc<-max(distN)+max(sizeNp)/2
  symbols(yvec~xvec, circles=sizeNp,inches=sizeNp, ylim=c(-maxc,maxc), xlim=c(-maxc,maxc))
  sizeip<-sizei/2
  symbols(0,0,circles=sizeip, inches=sizeip, bg="black", add=T)
  text(yvec~xvec, labels = Nseq)
  
  abline(h=0)
  abline(v=0)

  Cvec<-sizeN*sizei*alpha/distN
  C<-round(sum(Cvec),3)
  mtext(bquote(C==.(C)), adj=1, padj=0)
  
  distSim<- seq(0, max(distN+1), by=.1)
  Csim<-mean(sizeN)*sizei*alpha/distSim
  plot(Csim~distSim, type="l")
  text(Cvec~distN, labels = Nseq)
  
  C<-round(sum(alpha*sizei*sizeN/distN),3)
  mtext(bquote(C==.(C)), adj=1, padj=0)
  
  
})
 
})