# Load packages ---- 
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)
library(bslib)

# Create user interface ----
ui <- fluidPage(
  
  # Set theme ----
  #theme = bs_theme(bootswatch = "solar") # how to select preset theme 
  theme = bs_theme(
    bg = "#A36F6F", # background color
    fg = "#FDF7F7", # foreground color
    primary = "#483132", # primary accent color
    base_font = font_google("Pacifico")),
  
  # App title ---- 
  tags$h1("My App Title"), # h1, level one header 
  
  # App subtitle ---- 
  tags$h4(tags$strong("Exploring Antarctic Penguin Data")), # level 4 header, nested tags  

  # Body mass slider input ---- 
  sliderInput(inputId = "body_mass_input", # maintain similar syntax throughout app 
              label = "Select a range of body masses (g)", # what shows up on UI 
              min = 2700, max = 6300, # range of body mass 
              value = c(3000, 4000) # starting values 
              ),
  # Body mass plot output placeholder ----
  plotOutput(outputId = "body_mass_scatterplot_output"),

  
  # Year check box input ----
  checkboxGroupInput(inputId = "penguin_dt_input",
                     label = "Select year()",
                     choices = c(2007, 2008, 2009),  # also works: unique(penguins$year) 
                     selected = c(2007, 2008)
                     ),
  
  
  # Year check box output ---- 
  DT::dataTableOutput(outputId = "penguin_dt_output")
  
)



# Server ----
server <- function(input, output){
  
  # Filter body masses ----
  body_mass_df <- reactive({ # reactive allows for user imputed values ie slider
    
    penguins |> 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
   
  })
  
  # Render penguin scatter plot ---- 
  # output$idname = location where it shows up in UI 
  output$body_mass_scatterplot_output <- renderPlot({ 
    
    # code to generate plot
    ggplot(na.omit(body_mass_df()), # need () following reactive data frame 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
  }) 
  
  
  # Year selection filter ----
  penguin_year <- reactive({ 
    penguins |> 
      filter(year %in% c(input$penguin_dt_input))
    })
  # Render output table ----
  output$penguin_dt_output <- DT::renderDataTable({penguin_year()})
}

# combine our UI and server into an app ----
shinyApp(ui = ui, server = server)