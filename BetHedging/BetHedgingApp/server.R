
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
    
    Constant<-rnorm(mean=1.1, sd=0, n=100)  #Setting for constant envitonmental conditions (slightly above replacement)
     
    set.seed(1)  #Set seed to ensure similar results among students, create dropdown menu to create feel of re-initializing
    Variable<-rnorm(mean=1.1, sd=.5, n=100)  #Generate fecundity according to a random distribution
    Variable[Variable<0.2]<-0
    Highly.Variable<-rnorm(mean=1.1, sd=1, n=100)
    Highly.Variable[Highly.Variable<0.2]<-0
    
    set.seed(2)  #Another set of same-variable values, but different randomization
    Variable2<-rnorm(mean=1.1, sd=.5, n=100)
    Variable2[Variable2<0.2]<-0
    Highly.Variable2<-rnorm(mean=1.1, sd=1, n=100)
    Highly.Variable2[Highly.Variable2<0.2]<-0
    
    L<-eval(parse(text = input$mix)) #Take selection and turn it from words into an object
    
    s<-input$surv #Let the user define survival in the seedbank

    for (i in 1:99) {N[i+1]<-round(s*(1-g)*N[i]+L[i]*g*N[i],1)} #Run discrete model

    maxN<-min(max(N),100) #Figure out what is greater: the max of N or 100 (for plots)
    maxF<-max(L) #For ylim in plots

    # draw plots
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Fecundity", xlab="Year", lwd=2, ylim=c(0,maxF))
    legend(x=60,y=maxF-.1*maxF,"Mean Fecundity", lty=2)
    abline(a=mean(L), b=0, lty=2)
    plot(N[N>0]~time[1:length(N[N>0])], type="l", ylab="Population Size", xlab="Year", ylim=c(0,maxN), 
         col="#E69F00", lwd=2, xlim=c(0,100))
    
    })
 
  output$popGrow2 <- renderPlot({
    
    # generate data based on mean lam and sd in input
    
    time<-seq(1,100, by=1)
    N1<-10 #the number of seeds each student starts with
    N2<-10 #the number of seeds each student starts with
    
    g1<-input$germ1 #let students decide germination rate
    g2<-input$germ2

    Constant<-rnorm(mean=1.1, sd=0, n=100)
    
    set.seed(1)
    Variable<-rnorm(mean=1.1, sd=.5, n=100)
    Variable[Variable<0.2]<-0
    Highly.Variable<-rnorm(mean=1.1, sd=1, n=100)
    Highly.Variable[Highly.Variable<0.2]<-0
    
    set.seed(2)
    Variable2<-rnorm(mean=1.1, sd=.5, n=100)
    Variable2[Variable2<0.2]<-0
    Highly.Variable2<-rnorm(mean=1.1, sd=1, n=100)
    Highly.Variable2[Highly.Variable2<0.2]<-0
    
    L<-eval(parse(text = input$mix2))
    
    s<-input$surv1
    
    for (i in 1:99) {N1[i+1]<-round(s*(1-g1)*N1[i]+L[i]*g1*N1[i],1)
                     N2[i+1]<-round(s*(1-g2)*N2[i]+L[i]*g2*N2[i],1)}
    
    # draw plots
    
    maxF<-max(L) 
    
    maxy<-min(max(N1,N2),100)
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Fecundity", xlab="Year", lwd=2)
    legend(x=60,y=maxF-.1*maxF,"Mean Fecundity", lty=2)
    abline(a=mean(L), b=0, lty=2)
    
    plot(N1[N1>0]~time[1:length(N1[N1>0])], type="l", ylab="Population Size", xlab="Year", 
         col="#E69F00", lwd=2, ylim=c(0, maxy), xlim=c(0,100))
    lines(N2[N2>0]~time[1:length(N2[N2>0])], col="#56B4E9", lwd=2, xlim=c(0,100))
  
})  
  
})