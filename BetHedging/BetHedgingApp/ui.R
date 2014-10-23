
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)
?column
shinyUI(navbarPage("Bet Hedging Tutorial",
                   tabPanel("One species",
                          column(4, 
                              wellPanel(
                                h4("Environmental Effects on Fecundity"),
                                
                                selectInput("mix", label="Environment:", 
                                            list("Constant", "Variable", "Highly.Variable", "Variable2", "Highly.Variable2"),
                                            selected="Constant"),
                                hr(),
                                
                                h4("Species Germination Rates"),
                                
                                helpText("This annual species starts with 10 seeds"),
                                
                                sliderInput("germ",
                                            label=c("Choose the germination rate (g)"),
                                            min = 0,
                                            max = 1.0,
                                            value = 0.1, step=0.1),
                                hr(),
                                
                                h4("Seed Bank Dynamics"),
                                
                                helpText("*Seeds probably don't survive forever in the seedbank"),
                                
                                sliderInput("surv",
                                            label=c("The proportion of seeds surviving in the seed bank:"),
                                            min = .9,
                                            max = 1.0,
                                            value = 1, step=0.01),
                                
                                helpText("*This wasn't a part of the clasroom acitvity")
                                
                                )),
                              
                              # Show a plot of the generated distribution
                            column(8, 
                              wellPanel(
                                plotOutput("popGrow"),
                                br(),
                                helpText("If the line seems to reach zero but pops up again, it is because the population got very close to zero but not exactly. The line will disappear when it actually equals zero.")
                
                              ))),
                   
                   tabPanel("Two species comparison",
                            column(4, 
                              wellPanel(
                                h4("Environmental Effects on Fecundity"),
                                
                                selectInput("mix2", "Environment:", 
                                            choices=c("Constant", "Variable", "Highly.Variable", "Variable2", "Highly.Variable2")),
                                hr(),
                                
                                h4("Species Germination Rates"),
                                
                                helpText("Both annual species start with 10 seeds"),
                                
                                h4("Species 1 (orange):"),
                                
                                sliderInput("germ1",
                                            label=c("Choose Species 1's germination rate (g1)"),
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.1),
                                

                                hr(),
                                h4("Species 2 (blue):"),
                                
                                sliderInput("germ2",
                                            label=c("Choose Species 2's germination rate (g2)"),
                                            min = 0,
                                            max = 1.0,
                                            value = 0.1, step=0.1),
                                hr(),
                                
                                h4("Seed Bank Dynamics"),
                                
                                helpText("*Seeds probably don't survive forever in the seedbank"),
                                
                                sliderInput("surv1",
                                            label=c("The proportion of seeds surviving in the seed bank:"),
                                            min = .9,
                                            max = 1.0,
                                            value = 1, step=0.01) ,
                                
                                helpText("*This wasn't a part of the clasroom acitvity")
                                
                               
                              )),
                              
                              # Show a plot of the generated distribution
                              column(8, 
                                wellPanel(
                                plotOutput("popGrow2"),
                                br(),
                                helpText("If the line seems to reach zero 
                                         but pops up again, it is because 
                                         the population got very close to 
                                         zero but not exactly. The line will 
                                         disappear when it actually equals 
                                         zero.")
                                
                              ))
                            )))
