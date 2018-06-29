
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Deep learning for text categorization"),
  
  mainPanel(
    plotOutput("cat_plot"),
    textInput("text_input", label = "Enter review text...", width = "100%"),
    submitButton("submit"),
    br(),
    h3("Example text..."),
    p("I couldn't put it down!"),
    p("The plot was really confusing!")
  )
))