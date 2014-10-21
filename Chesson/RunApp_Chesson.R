#Set your working drive here so that the folder of your app is in the directory
setwd("C:/Users/A02077138/Documents/GitHub/ShinyApps/Chesson/ShinyApps/Chesson")

#If you don't have devtools or shinyapps:
#install.packages('devtools')
#devtools::install_github('rstudio/shinyapps')

library(shiny)
library(devtools)
library(shinyapps)

#Run app locally
runApp("ChessonApp")
runApp("ChessonApp", display.mode = "showcase")

#Deploy app; 

#**Make sure you have your account and computer linked via a token and secret(see shinyapps.io)
#shinyapps::setAccountInfo(
#  name="yourname", 
#  token="token", 
#  secret="secret")

deployApp("Chesson")
