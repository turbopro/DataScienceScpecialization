library(shiny)


# Rely on the 3 dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # By declaring datasetInput as a reactive expression we ensure 
  # that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers 
  #    (it only executes a single time)
  #
    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    })
  
  # output the summary of the data
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset[,1:2])
  })
    
  output$scatterplot <- renderPlot({
    # Render a scatterplot
    dataset <- datasetInput()
    plot(dataset[,1],dataset[,2], 
            main = paste(names(dataset)[1],"Vs",names(dataset)[2]),
            ylab= names(dataset)[2],
            xlab= names(dataset)[1])
  })
})
