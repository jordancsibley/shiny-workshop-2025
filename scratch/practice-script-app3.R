# load packages ----
library(tidyverse)
library(leaflet)

# read in data 
lake_data <- read_csv(here::here("shinydashboard", "data", "lake_data_processed.csv"))


# Practice filtering data ----
filtered_lakes <- lake_data |> 
  filter(Elevation >= 8 & Elevation <= 20) |> 
  filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
  filter(AvgTemp >= 2 & AvgTemp <= 10)




# leaflet map ---- 
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
  addMarkers(data = lake_data,
             lng = lake_data$Longitude,
             lat = lake_data$Latitude, 
             popup = paste0("Site Name: ", lake_data$Site, "<br>",
                            "Elevation: ", lake_data$Elevation, " meters above SL", "<br>",
                            "Avg Depth: ", lake_data$AvgDepth, " meters", "<br>",
                            "Avg Lake Bed Temp: ", lake_data$AvgTemp, "°C"))


