
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
                  
                   tabPanel("Lotka-Volterra Competition",
                    sidebarLayout(
                     sidebarPanel(
                       sliderInput("Sp1R",
                                   label="Species 1 per capita rate of increase",
                                   min = -.2,
                                   max = .5,
                                   value = .1, step=.1),
                       sliderInput("Sp2R",
                                   label="Species 2 per capita rate of increase",
                                   min = -.2,
                                   max = .5,
                                   value = .2, step=.1),
                       br(),
                       radioButtons("setK", "Is there a Carrying Capacity (K)?",
                                    c("No" = "no",
                                      "Yes"= "yes")),
                       
                       br(),
                       radioButtons("incAlpha1", "Do these species negatively affect themselves?:",
                                    c("No" = "no",
                                      "Yes"= "yes")),
                       
                       sliderInput("a11",
                                   label=c("The effect of species 1 on species 1"),
                                   min = .1,
                                   max = .5,
                                   value = .1, step=.05),
                       
                       sliderInput("a22",
                                   label=c("The effect of species 2 on species 2"),
                                   min = .1,
                                   max = .5,
                                   value = .1, step=.05),
                       br(),
                       
                       radioButtons("incAlpha2", "Do these species interact?:",
                                    c("No" = "no",
                                      "Yes"= "yes")),
          
                       sliderInput("a21",
                                   label=c("The effect of species 2 on species 1"),
                                   min = .1,
                                   max = .5,
                                   value = .1, step=0.05),
                       
                       sliderInput("a12",
                                   label=c("The effect of species 1 on species 2"),
                                   min = .1,
                                   max = .5,
                                   value = .1, step=0.05)
                                              
                       
                     ),
                                        
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                       helpText("Orange line is Species 1, Blue is Species 2"),
                       plotOutput("LVComp"))                                            )
                   ),
                   
                   tabPanel("Relative Nonlinearity"),

                   tabPanel("The Storage Effect")
                   ))
