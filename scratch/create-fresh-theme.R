library(fresh)

create_theme(
  
  adminlte_color( # update color for header
    light_blue = "darkblue"
  ),
  
  adminlte_global( # update color for body styling 
    content_bg = "lightpink"
  ),
  
  adminlte_sidebar( # update side bar colors
    dark_bg = "lightblue",
    dark_hover_bg = "magenta",
    dark_color = "red",
    width = "400px" # match title width 
  ),
  
 output_file = "shinydashboard/www/dashboard-fresh-theme.css" 
)