
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  
  output$popGrow <- renderPlot({
    
    # generate data based on mean lam and sd in input
    time<-seq(1,100,by=1)
    set.seed(13)
    Lam<-input$Lam
    sdYN <- switch(input$sd,
                     no = 0,
                     yes = input$sdLam)  #Choose SD based on User input; "breaks" if no is selected and people move the bar.
      
    Li<-rnorm(100, mean=Lam, sd=sdYN)
    N<-3
    for (i in 1:99){N[i+1]<-N[i]*Li[i]}
    
    # draw plots
    par(mfrow=c(1,2))
    plot(N~time, xlab="Time (t)", ylab="Number of individuals (N)", main="Raw data",type="l", lwd=2, col="black")
    plot(log(N)~time, xlab="Time (t)", main="Log-transformed data", type="l", lwd=2, col="black")
    fit<-lm(log(N)[1:30]~time[1:30])
    abline(fit, col="#E69F00") #Using colorblind-friendly colors
    lm_coef <- signif(coef(fit), 5) # extract coefficients
    mtext(bquote(r==.(lm_coef[2])),
          adj=1, padj=0) # display equation


    output$summary <- renderPrint({
    summary(fit)
    })
    })
  
  output$LVComp <- renderPlot({
  
    time<-seq(1,100,by=1)
    set.seed(13)
    Sp1N<-.01
    Sp2N<-.01
    Sp1R<-input$Sp1R
    Sp2R<-input$Sp2R

    K <- switch(input$setK,
                  no = 10*exp(100),
                  yes = 100) 
    
    a11 <- switch(input$incAlpha1,
                  no = 0,
                  yes = input$a11) 
    
    a22 <- switch(input$incAlpha1,
                  no = 0,
                  yes = input$a22)
    
    a21 <- switch(input$incAlpha2,
                  no = 0,
                  yes = input$a21)
    
    a12 <- switch(input$incAlpha2,
                  no = 0,
                  yes = input$a12) 
    

    for (i in 1:99){Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*((K-Sp1N[i]-Sp1N[i]*a11-Sp2N[i]*a21)/K)
                    Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*((K-Sp2N[i]-Sp2N[i]*a22-Sp1N[i]*a12)/K)}
    
    diffSp1<-NA
    diffSp2<-NA
    
    for (i in 1:99){diffSp1[i+1]<-Sp1N[i+1]-Sp1N[i]
                     diffSp2[i+1]<-Sp2N[i+1]-Sp2N[i]}
    
    layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
    plot(Sp1N~time, xlab="Time (t)", 
         ylab="Population size (N)", type="l", 
         col="#E69F00", ylim=c(0,100), lwd=2)
    points(Sp2N~time, col="#56B4E9", type="l", lwd=2)
    
    plot(diffSp1~time, xlab="Time (t)", ylab="Change (dN/dt)",type="l", 
         col="#E69F00", lwd=2)
    points(diffSp2~time, col="#56B4E9", type="l", lwd=2)

    plot(Sp2N~Sp1N, xlab= "Species 1 (Sp1N)", ylab= "Species 2 (Sp2N)", 
         type="l", col="#009E73", lwd=2, xlim=c(0,100), ylim=c(0,100), sub="still needs isoclines")
    
    })
  
  
  output$Chess <- renderPlot({
    
    time<-seq(1,100,by=1)
    set.seed(13)
    Sp1N<-.01
    Sp2N<-.01
    Sp1R<-input$CSp1R
    Sp2R<-input$CSp2R
    
    K <- switch(input$CsetK,
                no = 10*exp(100),
                yes = 100) 
    
    a11 <- switch(input$CincAlpha1,
                  no = 0,
                  yes = input$Ca11) 

    a22 <- switch(input$CincAlpha1,
                  no = 0,
                  yes = input$Ca22)
    
    a21 <- switch(input$CincAlpha2,
                  no = 0,
                  yes = input$Ca21)
    
    a12 <- switch(input$CincAlpha2,
                  no = 0,
                  yes = input$Ca12) 
    
    a<-switch(input$CincNL,
              no = 0,
              yes = input$Sp1a)#.5
    
    a2<-switch(input$CincNL,
               no = 0,
               yes = input$Sp2a)#.35
    
    b<-switch(input$CincNL,
              no = 1,
              yes = input$Sp1b)#.7
    
    b2<-switch(input$CincNL,
               no = 1,
               yes = input$Sp2b)#.9

    c<-switch(input$CincNL,
              no = 0,
              yes = 1)#.7
    
    layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE))
    x<-seq(1,7, by=.1)
    y1<-c*log(x)/(a+b*log(x))
    y2<-c*log(x)/(a2+b2*log(x))
    
    plot(y1~x, ylim=c(0,1.1), type="l", col="#E69F00", xlab="Resource", ylab="Percent of GR", lwd=2)
    points(y2~x, ylim=c(0,1.1), type="l", col="#56B4E9", xlab="Resource", ylab="Percent of GR", lwd=2)
    
    set.seed(15)
    x<-rlnorm(n=100, meanlog=log(3), sdlog=log(1.3))

    resp1<-NA
    resp2<-NA
    comp1<-NA
    comp2<-NA

    for (i in 1:99){
      resp1[i]<-(c*log(x[i]))/(a+b*log(x[i]))
      resp2[i]<-(c*log(x[i]))/(a2+b2*log(x[i]))
      comp1[i]<-((K-Sp1N[i]-Sp1N[i]*a11-Sp2N[i]*a21)/K)
      comp2[i]<-((K-Sp2N[i]-Sp2N[i]*a22-Sp1N[i]*a12)/K)
      Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*(comp1[i]+resp1[i])
      Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*(comp2[i]+resp2[i])}

    plot(x~seq(1:100), type="l", xlab="time", ylab="Resource Availability", lwd=2)
    
    maxy<-min(max(Sp1N,Sp2N),100)
    plot(Sp1N~seq(1:100), ylim=c(0,maxy), type="l", col="#E69F00", xlab="time", ylab="Population Size (N)", lwd=2)
    points(Sp2N~seq(1:100), type="l", col="#56B4E9", lwd=2)
    
  
  })
  
  
})
