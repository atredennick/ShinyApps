
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("Bet Hedging Tutorial",
                   tabPanel("One species",
                            sidebarLayout(
                              sidebarPanel(
                                helpText("This annual species starts with 10 seeds"),
                                
                                sliderInput("germ",
                                            label=c("Choose the germination rate (g)"),
                                            min = 0,
                                            max = 1.0,
                                            value = 0.1, step=0.1),
                                                              
                                br(),
                                
                                radioButtons("surv","Do seeds always survive in the seed bank?:",
                                             c("Yes" = "yes",
                                              "No"= "no")),
                                
                                helpText(h6("*The bar below doesn't work if you have selected 'Yes' above")),
                                
                                sliderInput("survive",
                                            label=c("Percent of seeds that survive (s)"),
                                            min = 0,
                                            max = .9,
                                            value = .9, step=0.1)
                                
                                ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("popGrow"),
                                br(),
                                helpText("You can write explanatory text here")
                
                              ))),
                   
                   tabPanel("Two species comparison",
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Both annual species start with 10 seeds"),
                                
                                h3("Species 1 (orange):"),
                                
                                sliderInput("germ1",
                                            label=c("Choose Species 1's germination rate (g1)"),
                                            min = 0,
                                            max = 1,
                                            value = 0.5, step=0.1),
                                
                                br(),
                                
                                radioButtons("surv1","Do seeds always survive in the seed bank?:",
                                             c("Yes" = "yes",
                                               "No"= "no")),
                                br(),
                                
                                sliderInput("survive1",
                                            label=c("Percent of seeds that survive (s1)"),
                                            min = 0,
                                            max = .9,
                                            value = .9, step=0.1),
                                br(),
                                h3("Species 2 (blue):"),
                                
                                sliderInput("germ2",
                                            label=c("Choose Species 2's germination rate (g2)"),
                                            min = 0,
                                            max = 1.0,
                                            value = 0.1, step=0.1),
                                
                                br(),
                                
                                radioButtons("surv2","Do seeds always survive in the seed bank?:",
                                             c("Yes" = "yes",
                                               "No"= "no")),
                                br(),
                                
                                sliderInput("survive2",
                                            label=c("Percent of seeds that survive (s2)"),
                                            min = 0,
                                            max = .9,
                                            value = .9, step=0.1)
                                
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("popGrow2"),
                                br(),
                                helpText("You can write explanatory text here")
                                
                              )))))
