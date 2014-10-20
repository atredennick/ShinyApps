
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
    sdLam<-input$sdLam
    Li<-rnorm(100, mean=Lam, sd=sdLam)
    N<-3
    for (i in 1:99){N[i+1]<-N[i]*Li[i]}
    
    # draw plots
    par(mfrow=c(1,2))
    plot(N~time)
    plot(log(N)~time, sub="Orange line is a linear model for timesteps 1-30")
    fit<-lm(log(N)[1:30]~time[1:30])
    abline(fit, col="orange")
    lm_coef <- signif(coef(fit), 5) # extract coefficients
    mtext(bquote(y == .(lm_coef[2])*x + .(lm_coef[1])),
          adj=1, padj=0) # display equation
    
  })
  
  output$summary <- renderPrint({
    summary(fit)
  })
  
  
})
