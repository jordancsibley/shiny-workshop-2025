# User interface ---- 

# navbarPage = container function 
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) Intro tabpanel ----
  tabPanel(title = "About this app",
           
           "Background info will go here"
           
           ), # END (Page 1) Intro tabpanel 
  
  # (Page 2) data viz tabPanel ---- 
  tabPanel(title = "Explore the data",
           
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerInput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel types(s)",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"), # default selection
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxGroupButtons ---- 
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = c("Clear Cut" = "clear cut forest",
                                                           "Old Growth" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE, # Expand box to full width
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"), 
                                                 no = icon("xmark") )) # Default is font awesome 
                                              
                          
                        ), # END trout sidebar panel
                       
                         # trout mainPanel ---- 
                        mainPanel(
                          
                          # trout scatter plot output 
                          plotOutput(outputId = "trout_scatterplot_output")
                          
                        ) # END trout mainPanel
                        
                      ) #END trout sidebarLayout
                      
                      
                      
                      ), # END trout tabPanel
             tabPanel(title = "Penguins",
                      
                      # pneguin sidebarLayout --- 
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        
                        sidebarPanel(
                          # island picker input 
                          pickerInput(inputId = "island_picker",
                                      label = "Select an island(s)",
                                      choices = c(unique(penguins$island)),
                                      selected = c("Dream"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # bin width input 
                          sliderInput(inputId = "binwidth_slider",
                                      label = "Select number of bins",
                                      min = 2, max = 50, 
                                      value = 25 )
                                      
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ---- 
                        mainPanel(
                          
                          plotOutput(outputId = "penguin_histogram_output")
                          
                          
                        ) # END penguin mainPanel
                      ) #END penguin sidebarLayout 
                      
                      
                      
                 
                      
                      ) # END penguin tabPanel
           ) # END tabsetPanel
           
           ) # END (Page 2) data viz tabPanel
)