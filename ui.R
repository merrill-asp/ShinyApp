library(shiny)
library(ggplot2)
library(markdown)
data(mtcars)

# Define UI for application that draws a customizable plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring Mtcars Data"),
  
  # Sidebar with a radio button inputs
  sidebarLayout(
    sidebarPanel(
       radioButtons("xchoice", "x", choices = names(mtcars), selected = "cyl", inline=TRUE),
       radioButtons("ychoice", "y", choices = c(names(mtcars), "none"), selected = "mpg", inline=TRUE),
       radioButtons("colchoice", "color", choices = c(names(mtcars), "none"), selected = "none", inline=TRUE),
       radioButtons("facchoice", "facet", choices = c("cyl","vs","am","gear","none"), selected = "none", inline=TRUE)
    ),
    
    # Show a plot of the generated distribution, including documentation
    mainPanel(
      plotOutput("distPlot"),
      wellPanel(style="overflow-y: scroll; max-height: 300px",
        includeMarkdown("documentation.md")
      )
    )
  )
))
