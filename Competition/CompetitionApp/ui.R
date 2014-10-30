
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(markdown)

shinyUI(navbarPage("Competition Coef Tutorial",
                   
                   tabPanel("Current Model",
                            helpText("** At first the application will take time to load. This process may take longer with more users. If the app screen dims, the computer is working on the change you made. If the app freezes, you may need to fiddle with it to get it working again."),
                            #column(4, 
                              sidebarPanel(
                                h4("Current model"),
                                
                                helpText("C = size(j)*exp(alpha*dist^2)"),

                                
                                sliderInput("N1",
                                            label=c("choose N"),
                                            min = 0,
                                            max = 10.0,
                                            value = 5, step=1),
                                br(),
                                
                                sliderInput("alpha1",
                                            label=c("Choose alpha"),
                                            min = 0,
                                            max = 1.0,
                                            value = .1, step=0.01),
                                br(),
                                
                                
                                sliderInput("meanSize1",
                                            label=c("Mean Size"),
                                            min = .1,
                                            max = 1,
                                            value = .8, step=.01),
                                br(),
                                
                                sliderInput("meanDist1",
                                            label=c("Mean Distance"),
                                            min = 0,
                                            max = 3.0,
                                            value = 1, step=.1),
                                br(),
                                
                                sliderInput("Seed1",
                                            label=c("choose seed"),
                                            min = 1,
                                            max = 100.0,
                                            value = 1, step=1),
                                br()
                                
                              #)
                            ),
                              
                              # Show a plot of the generated distribution
                            #column(6, 
                              mainPanel(
                                plotOutput("trad"),
                                br(),
                                helpText("text.")
                
                              #)
                            )),
                            
                            tabPanel("Gravity Model",
                                     helpText("** At first the application will take time to load. This process may take longer with more users. If the app screen dims, the computer is working on the change you made. If the app freezes, you may need to fiddle with it to get it working again."),
                                     
                                     sidebarPanel(
                                              h4("Text"),
                                              
                                              helpText("C = size(i)*size(j)/alpha*dist"),
                                              
                                              sliderInput("sizei",
                                                          label=c("Size i"),
                                                          min = 0,
                                                          max = 1.0,
                                                          value = .1, step=.1),
                                              
                                              br(),

                                              
                                              sliderInput("alpha2",
                                                          label=c("Choose alpha"),
                                                          min = 5,
                                                          max = 15,
                                                          value = 10, step=0.1),
                                              br(),
                                              
                                              sliderInput("N2",
                                                          label=c("choose N"),
                                                          min = 1,
                                                          max = 10.0,
                                                          value = 5, step=1),
                                              br(),
                                              

                                              
                                              sliderInput("meanSize2",
                                                          label=c("Mean Size"),
                                                          min = 0,
                                                          max = 1,
                                                          value = .8, step=.01),
                                              br(),
                                              
                                              sliderInput("meanDist2",
                                                          label=c("Mean Distance"),
                                                          min = 0.1,
                                                          max = 3.0,
                                                          value = 1, step=.1),
                                              
                                              br(),
                                              sliderInput("Seed2",
                                                          label=c("choose seed"),
                                                          min = 1,
                                                          max = 100.0,
                                                          value = 1, step=1),
                                              br()
                                            ),
                                     
                                     # Show a plot of the generated distribution
                                    
                                            mainPanel(
                                              plotOutput("grav"),
                                              br(),
                                              helpText("text.")
                                              
                                            ))
                          
                          ))
                   
                   