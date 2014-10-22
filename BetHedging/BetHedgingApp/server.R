
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  output$popGrow <- renderPlot({
    
    # generate data based on mean lam and sd in input
    
    time<-seq(1,100, by=1)
    N<-10 #the number of seeds each student starts with
    g<-input$germ #the percent of seeds germinating every year (indifferent to conditions)
    
    Constant<-rlnorm(meanlog=log(1), sdlog=log(1), n=100)
        
    set.seed(1)
    Variable<-rnbinom(n=100, mu=1, size=1)
    Highly.Variable<-rnbinom(n=100, mu=1, size=3)
        
    set.seed(2)
    Variable2<-rnbinom(n=100, mu=1, size=1)
    Highly.Variable2<-rnbinom(n=100, mu=1, size=3)
    
    L<-eval(parse(text = input$mix))
    
    s<-input$surv

    for (i in 1:99) {N[i+1]<-round(s*(1-g)*N[i]+L[i]*g*N[i],1)}

    maxN<-max(N)
    maxF<-max(L)  
    # draw plots
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Fecundity", xlab="Year", lwd=2, ylim=c(0,maxF))
    plot(N~time, type="l", ylab="Population Size", xlab="Year", ylim=c(0,maxN), 
         col="#E69F00", lwd=2)
    
    })
 
  output$popGrow2 <- renderPlot({
    
    # generate data based on mean lam and sd in input
    
    time<-seq(1,100, by=1)
    N1<-10 #the number of seeds each student starts with
    N2<-10 #the number of seeds each student starts with
    #g=.1
    g1<-input$germ1 #the percent of seeds germinating every year (indifferent to conditions)
    g2<-input$germ2

    Constant<-rlnorm(meanlog=log(1), sdlog=log(1), n=100)
    
    set.seed(1)
    Variable<-rnbinom(n=100, mu=1, size=1)
    Highly.Variable<-rnbinom(n=100, mu=1, size=3)
    
    set.seed(2)
    Variable2<-rnbinom(n=100, mu=1, size=1)
    Highly.Variable2<-rnbinom(n=100, mu=1, size=3)
    
    L<-eval(parse(text = input$mix2))
    
    s<-input$surv
    
    for (i in 1:99) {N1[i+1]<-round(s*(1-g1)*N1[i]+L[i]*g1*N1[i],1)
                     N2[i+1]<-round(s*(1-g2)*N2[i]+L[i]*g2*N2[i],1)}
    
    # draw plots
      
    maxy<-max(N1,N2)
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Fecundity", xlab="Year", lwd=2)
    plot(N1~time, type="l", ylab="Population Size", xlab="Year", 
         col="#E69F00", lwd=2, ylim=c(0, maxy))
    lines(N2~time, col="#56B4E9", lwd=2)
  
})  
  
})