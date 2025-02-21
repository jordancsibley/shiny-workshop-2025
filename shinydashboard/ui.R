# Dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Mointoring",
  titleWidth = 400
)


# Dashboard siderbar ----
sidebar <- dashboardSidebar(
  
  # sidebar menu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
  ) # END sidebarMenu
) # END dashboardSidebar


# Dashboard body ----
body <- dashboardBody(
  
  # set theme ----
  use_theme("dashboard-fresh-theme.css"),
  
  
  # tabItems ----
  tabItems(
    # welcome tab 
    tabItem(tabName = "welcome",
            
            # left-hand column ----
            column(width = 6, 
                   
                   # background info box ----
                   box(width = NULL, # takes on width of the column 
                       
                       title = tagList(icon("water"), strong("About")) ,
                       
                       includeMarkdown("text/intro.md"), 
                       
                       # add image 
                       tags$img(src = "FishCreekWatershed.jpg",
                                alt = "A map of northern Alaska showing Fish Creek Watershed.",
                                style = "max-width: 100%;"), # take up 100% of the width within box 
                       tags$h6("Map source:", tags$a(href = "http://www.fishcreekwatershed.org",
                                                     "FCWO"), 
                               style = "text-align: center;")
                       
                   ) # END info background box 
            ), # END column 
            # right-hand column ----
            column(width = 6, 
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL, 
                         
                         title = tagList(icon("table"), strong("Data Source")),
                         
                         includeMarkdown("text/citation.md")
                         
                     ) # END citation box 
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         title = tagList(icon("triangle-exclamation"), strong("Disclaimer")),
                         
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box 
                     
                   ) # END second fluidRow 
                   
            ) # END right-hand column 
            
    ), # END welcome tabItem
    
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4, 
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # sliderInputs elevation ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above sea level)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation), 
                                        max(lake_data$Elevation))), # END sliderInput elevation 
                  # sliderInput depth ----
                  sliderInput(inputId = "avg_depth_input",
                              label = "Average lake depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth), 
                                        max(lake_data$AvgDepth))), # END sliderInput depth 
                  # sliderInput temp ----
                  sliderInput(inputId = "avg_temp_input",
                              label = "Average lake bed temperature (°C) ",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp))) # END sliderInput temp 
                  
              ), # END input box 
              
              # leaflet box ---- 
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  leafletOutput(outputId = "lake_map_output") |> 
                    withSpinner(type = 1, color = "blue")
                  
              ) # END leaflet box 
              
            ) # END fluidRow 
            
            
    ) # END dashboard tabItem
    
  ) # END tabItems
  
  
) # END dashboardBody


# Combine all into dashboard page 
dashboardPage(header, sidebar, body)