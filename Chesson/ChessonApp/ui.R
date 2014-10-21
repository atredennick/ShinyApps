
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
?expression
library(shiny)
library(markdown)

shinyUI(navbarPage("Chesson Tutorial",
                   tabPanel("Simple population growth",
                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                              sidebarPanel(
                                helpText("First we imagine a species with a growth rate:"),
                                sliderInput("Lam",
                                            label=div(HTML("Choose &lambda;:")),
                                            min = .95,
                                            max = 1.05,
                                            value = 1.01),
                                
                              
                                helpText("The slope of the log(N) line, 
               especially at t<30, gives the approximate 
               long-term low density growth rate"),
                                br(),
                                
                                radioButtons("sd", "Is there stochastic variation in your population?:",
                                             c("No" = "no",
                                               "Yes"= "yes")),
                                br(),
                                
                                sliderInput("sdLam",
                                            label=c("The Std. Dev of Lambda"),
                                            min = .01,
                                            max = .05,
                                            value = .01)
                                
                                ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("popGrow"),
                                br(),
                                helpText("Below is the equation of the orange line, which is a linear model for timesteps 1-30"),
                                verbatimTextOutput("summary")
                              )
                            )),
                   
                   tabPanel("Lotka-Volterra Competition"),
                   
                   tabPanel("Relative Nonlinearity"),

                   tabPanel("The Storage Effect")
                   ))
