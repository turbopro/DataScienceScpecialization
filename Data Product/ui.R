library(shiny)

# Rely on three dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Summary and Histogram"),
    
    # Generate a row with a sidebar
    sidebarLayout(  
      sidebarPanel(
       # Define the sidebar with two input
        selectInput("dataset", "Choose a dataset:", 
                    choices=c("rock","pressure","cars")),
        submitButton("Ok")

      ),
      
      # Create a spot for the summary and the plot
      mainPanel(
        verbatimTextOutput("summary"),
        plotOutput("scatterplot")  
      )
      
    )
  )
)


