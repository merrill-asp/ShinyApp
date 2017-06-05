#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data(mtcars)

# define server logic for rendering plot
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({

    xcolumn <- mtcars[[input$xchoice]]
    
    if(input$ychoice == "none") { # make a histogram

      # check for color choice
      if(input$colchoice == "none") {
        g <- ggplot(data.frame(x=xcolumn), aes(x=x))
      } else {
        colcolumn <- mtcars[[input$colchoice]]
        df <- data.frame(x=xcolumn, col=colcolumn)
        g <- ggplot(df, aes(x=x, color=col))
        g <- g + labs(color = input$colchoice)
      }

      g <- g + geom_histogram()

    } else { # make an x-y scatterplot
      
      ycolumn <- mtcars[[input$ychoice]]

      # check for color choice
      if(input$colchoice == "none") {
        df <- data.frame(x=xcolumn, y=ycolumn)
        g <- ggplot(df, aes(x=x, y=y))
      } else {
        colcolumn <- mtcars[[input$colchoice]]
        df <- data.frame(x=xcolumn, y=ycolumn, col=colcolumn)
        g <- ggplot(df, aes(x=x, y=y, color=col))
        g <- g + labs(color = input$colchoice)
      }

      g <- g + ylab(input$ychoice)
      g <- g + geom_point(size=3)

    }

    # create facets, if chosen
    if(input$facchoice != "none") {
      g <- g + facet_grid(. ~ mtcars[[input$facchoice]])
    }

    g + xlab(input$xchoice)
    
  })
  
})
