
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output, session) {
  
 
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
    
# This is noted to be incorrect because K and aii serve the same purpose. Perhaps modify to change K w/o and aii or ajj?
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
  
  
  
})
