#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Text Prediction"),
  
  # Sidebar with a text input 
  sidebarLayout(
    sidebarPanel(
      h2("Enter any text with two or more words"),
       textInput("phrase", "Enter Text"),
       submitButton("Submit"),
       hr(),
       helpText("Text Predction Application", br(), 
                "This application will attempt to predict what the next text you will type given any text input that has two or more words.", br(),
                "1. Type in your phrase or sentence in the input ",br(),
                "2. Click the 'Submit' button",br(),
                "3. If the prediction server was successful, you should see 1 to 4 different text predictions"
               )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("predict1"),
       textOutput("predict2"),
       textOutput("predict3")
    )
  )
))
