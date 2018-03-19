 library(shiny) 
 library(shinythemes)
 
 # Define UI for dataset viewer application 
 shinyUI(fluidPage(theme = shinytheme("yeti"),
    
     # Application title. 
     titlePanel("NLP with the next Word Prediction",windowTitle = "Word Prediction"), 
    
       
     sidebarPanel( 
         
         textInput("obs", "Please enter your statement:"),  
         helpText("The Shiny App will analyze your statement based on the exisiting language database and predict the next most likely word.", style = "color:blue"),
         helpText("After entering your statement, press the 'Predict the Next Word' Button'.", style = "color:blue"),
         submitButton("Predict the Next Word")),
        
        mainPanel(
          tabsetPanel(type="tabs",
                      tabPanel(title = 'Prediciton',
           h5("You have entered the following statement:", style = "color:blue"),
           h4(textOutput("Original")), 
           br(), 
           br(), 
           h5("The Most Likely Next Word is:", style = "color:green"), 
           h4(textOutput("BestGuess")),
           br(), 
           br(),
           h4("The Shiny App predicted the next word could be the following:", style = "color:green"), 
           tableOutput("view")),
           tabPanel(title = 'Word Cloud',
           h3("The word cloud based on predicitons:"),
           plotOutput('plot')),
           tabPanel(title = 'Prediciton Model',
                    h3("Model:"),
                    p("The App follows the n-gram method to make a prediction, 
                       3,2,1-gram tables are generated and stored from the subset of corpora, This app 
                       loads n-gram tables and does a fast look up to predict the next word"),
                    h3("Methodology:"),
                    p("1. Clean the input string (remove digits,puctuations and extra white space)"),
                    p("1.1 Convert the input string to lowercase"),
                    p("2. Get the last two words and look for it in the 3 gram table"),
                    p("3. If a match is found display the results else"),
                    p("4. Look for the last word in the 2 gram table"),
                    p("5. If a match is found display the results else"),
                    p("6. Look for the last word in the 1 gram table"),
                    p("7. Display the next higher freq word"),
                    p("8. When there is no match in any of the tables, display the highest frequency word"))
   ) 
   ) 
   )
   )
