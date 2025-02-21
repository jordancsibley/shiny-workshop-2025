# Define server 
server <- function(input, output) {
  
  # filter lake data ----
  filtered_lakes_df <- reactive({
    
    lake_data |> 
    filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) |> 
    filter(AvgDepth >= input$avg_depth_input[1] & AvgDepth <= input$avg_depth_input[2]) |> 
    filter(AvgTemp >= input$avg_temp_input[1] & AvgTemp <= input$avg_temp_input[2])
    
  })
  
  
  # build leaflet map ----
  output$lake_map_output <- renderLeaflet({
    
    leaflet() |> 
      # Base map 
      addProviderTiles(providers$Esri.WorldImagery) |> 
      # Set inital map bounds 
      setView(lng = -152.048, 
              lat = 70.249, 
              zoom = 7) |> 
      # Reference map 
      addMiniMap(toggleDisplay = TRUE, 
                 minimized = FALSE) |> 
      # Add site markers 
      addMarkers(data = filtered_lakes_df(),
                 lng = filtered_lakes_df()$Longitude,
                 lat = filtered_lakes_df()$Latitude, 
                 popup = paste0("Site Name: ", filtered_lakes_df()$Site, "<br>",
                                "Elevation: ", filtered_lakes_df()$Elevation, " meters above SL", "<br>",
                                "Avg Depth: ", filtered_lakes_df()$AvgDepth, " meters", "<br>",
                                "Avg Lake Bed Temp: ", filtered_lakes_df()$AvgTemp, "°C"))
  }) # END renderLeaflet
  
  
}