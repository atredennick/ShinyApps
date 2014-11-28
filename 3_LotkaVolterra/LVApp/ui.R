
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("Lotka Volterra Tutorial",
                   
                   tabPanel("Lotka-Volterra Competition",
                    sidebarLayout(
                     sidebarPanel(
                       sliderInput("Sp1R",
                                   label="Species 1 per capita rate of increase",
                                   min = 0,
                                   max = 1.2,
                                   value = .3, step=.1),
                       sliderInput("Sp2R",
                                   label="Species 2 per capita rate of increase",
                                   min = 0,
                                   max = 1.2,
                                   value = .4, step=.1),
                       br(),
                       radioButtons("setK", "Is there a Carrying Capacity (K)?",
                                    c("No" = "no",
                                      "Yes"= "yes")),
                       
                       br(),
                       radioButtons("incAlpha1", "Do these species negatively affect themselves (density dependence)?:",
                                    c("No" = "no",
                                      "Yes"= "yes")),
                       
                       sliderInput("a11",
                                   label=c("The effect of species 1 on species 1"),
                                   min = .1,
                                   max = 1.2,
                                   value = .2, step=.1),
                       
                       sliderInput("a22",
                                   label=c("The effect of species 2 on species 2"),
                                   min = .1,
                                   max =1.2,
                                   value = .8, step=.1),
                       br(),
                       
                       radioButtons("incAlpha2", "Do these species interact?:",
                                    c("No" = "no",
                                      "Yes"= "yes")),
          
                       sliderInput("a21",
                                   label=c("The effect of species 2 on species 1"),
                                   min = .1,
                                   max = 1.2,
                                   value = .2, step=0.1),
                       
                       sliderInput("a12",
                                   label=c("The effect of species 1 on species 2"),
                                   min = .1,
                                   max = 1.2,
                                   value = 1.1, step=0.1)
                                              
                       
                     ),
                                        
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                       helpText("Orange line is Species 1, Blue is Species 2"),
                       plotOutput("LVComp"),
                       helpText("Species can exist when a species 
                                is more limited by other members of 
                                its own species, than by members of 
                                other species; aii>aij or aij/ajj<1"))                                            )
                   )
                   ))
