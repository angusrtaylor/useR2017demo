library(shiny)

shinyServer(function(input, output) {
  
  library(mxnet)
  library(ggplot2)
  source("../crepe_score.R")
  
  output$cat_plot <- renderPlot({
    
    test_line <- input$text_input
    
    predictions <- crepe_score(test_line)
    
    categories <- c("Books",
                    "Sports & Outdoors",
                    "Electronics",
                    "Clothing, Shoes & Jewellery",
                    "Home & Kitchen",
                    "Health & Personal Care",
                    "Movies & TV")
    category_probs <- data.frame(Category = categories, Probability = predictions)
    
    ggplot(category_probs, aes(x = Category, y = Probability, fill = Category)) + 
      geom_bar(stat = "Identity") +
      theme(
        axis.text.x = element_text(
        angle = 45,
        hjust = 1,
        size = 12
        ),
        axis.title = element_text(size = 14),
        panel.grid.minor = element_blank(),
        legend.position = "none"
      ) +
      scale_y_continuous(limits = c(0, 1))
    
  })

  
})