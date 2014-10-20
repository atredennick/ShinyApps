
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(markdown)

shinyUI(navbarPage("Chesson Tutorial",
                   tabPanel("Simple population growth",
                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                              sidebarPanel(
                                helpText(h4("First we create some data for analysis:")),
                                sliderInput("Lam",
                                            "Mean Lambda:",
                                            min = .95,
                                            max = 1.05,
                                            value = 1.01),
                                
                                sliderInput("sdLam",
                                            "Std. Dev. of Lambda:",
                                            min = 0,
                                            max = .01,
                                            value = .002),
                                
                                helpText("The slope of the log(N) line, 
               especially at t<30, gives the approximate 
               long-term low density growth rate")
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("popGrow")
                              )
                            )),
                   
                   tabPanel("Summary",
                            verbatimTextOutput("summary")
                   )))
