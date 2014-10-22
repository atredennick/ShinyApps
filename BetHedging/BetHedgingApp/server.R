
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
    #g=.1
    g<-input$germ #the percent of seeds germinating every year (indifferent to conditions)
    set.seed(1)
    L<-rpois(lambda=1, n=100)
    #s<-1
    s<- switch(input$surv,
                   yes = 1,
                   no = input$survive)  #Choose SD based on User input; "breaks" if no is selected and people move the bar.
    
    for (i in 1:99) {N[i+1]<-s*(1-g)*N[i]+L[i]*g*N[i]}

    # draw plots
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Envrionment", xlab="Year", lwd=2)
    plot(N~time, type="l", ylab="Population Size", xlab="Year", col="#E69F00", lwd=2)
    
    })
 
  output$popGrow2 <- renderPlot({
    
    # generate data based on mean lam and sd in input
    
    time<-seq(1,100, by=1)
    N1<-10 #the number of seeds each student starts with
    N2<-10 #the number of seeds each student starts with
    #g=.1
    g1<-input$germ1 #the percent of seeds germinating every year (indifferent to conditions)
    g2<-input$germ2
    set.seed(2)
    L<-rpois(lambda=1, n=100)
    #s<-1
    s1<- switch(input$surv1,
               yes = 1,
               no = input$survive1)  #Choose SD based on User input; "breaks" if no is selected and people move the bar.
    
    s2<- switch(input$surv2,
               yes = 1,
               no = input$survive2)
    
    for (i in 1:99) {N1[i+1]<-s1*(1-g1)*N1[i]+L[i]*g1*N1[i]
                     N2[i+1]<-s2*(1-g2)*N2[i]+L[i]*g2*N2[i]}
    
    maxy<-max(N1,N2)
    # draw plots
    par(mfrow=c(2,1), mar=c(4,4,1,1))
    plot(L~time, type="l", ylab="Environment", xlab="Year", lwd=2)
    plot(N1~time, type="l", ylab="Population Size", xlab="Year", 
         col="#E69F00", lwd=2, ylim=c(0, maxy))
    lines(N2~time, col="#56B4E9", lwd=2)
  
})  
  
})