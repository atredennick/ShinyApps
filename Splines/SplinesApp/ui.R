library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Splines!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Fit growth function with linear model (orange) and spline (blue)."),
      
      helpText(h4("Set parameters for fake data:")),
      sliderInput("N",
                  "Number of points:",
                  min = 10,
                  max = 150,
                  value = 81),
      
      sliderInput("rainfall",
                  "Disproportionate rainfall benefit:",
                  min = 1,
                  max = 3.5,
                  value = 1.5),
      
      helpText(h4("Elements of Spline Analysis")),
      helpText(h5("Blue Line: smooth.spline."),
               h6("Alter the number of knots")),
      
      sliderInput("knots",
                  "Knots:",
                  min = 4,
                  max = 9,
                  value = 6)),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      helpText(h5("True function: size2<-2+3*size+size^rain+random^rain")),
      plotOutput("distPlot"),
      helpText("Splines fit low dimensional polynomials over different regions of x. More knots mean more regions."),
      helpText("More compex fitting processes (kernel smoothing, and lowess) use locally weighted averages of x, or x and y."),     
      helpText("GAMs add smoothing (as in splines) to models with multiple predictors additvely (interactions are difficult to manage).")
      
    )
  )
))
