library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  mean<-5
  sdsize<-2
  intercept<-2
  slope<-3
  
  output$distPlot <- renderPlot({
    set.seed(123) 
    size<-rnorm(n=input$N, mean=mean,sd=sdsize)
    rain<-input$rainfall
    size<-size[size>0]
    
    #set.seed(124)
    random<-rnorm(n=length(size), mean=mean, sd=sdsize)
    size2<-intercept+slope*size+size^rain+random^rain
    
    par(mfrow=c(1,2))
    plot(size,size2, xlim=c(min(size),max(size)), ylim=c(min(size2),max(size2)), pch=16, cex=.5)
    new.x = seq(min(size),max(size), length.out=length(size))
    
    ## Linear Model
    fit = lm(size2 ~ size)
    abline(fit, col="orange")
    
    ## Smoothing Spline
    fit.sp = smooth.spline(size2 ~ size, nknots=input$knots)
    lines(fit.sp, col="blue", lty=6)
    
    plot(residuals(fit.sp) ~ fitted(fit.sp), col="blue")
    points(residuals(fit) ~ fitted(fit), col="orange")
    abline(h = 0, col = "gray")
    
  })
})
