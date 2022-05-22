lib = c("tidyverse","networkD3", "htmlwidgets", "htmltools")
lapply(lib, require, character.only = TRUE) 

links = read.csv("HD.csv", header = T)

nodes = data.frame(name = c(as.character(links$source),
                            as.character(links$target))
                   %>% unique(),
                   stringsAsFactors = FALSE)


links$IDsource <- match(links$source, nodes$name)-1

links$IDtarget <- match(links$target, nodes$name)-1


p <- sankeyNetwork(Links = as.data.frame(links), Nodes = as.data.frame(nodes),
                   
                   Source = "IDsource", Target = "IDtarget",
                   
                   Value = "value", NodeID = "name", height=800, width=1500,
                   
                   sinksRight=FALSE,  fontSize=14, fontFamily="Arial", nodeWidth = 50, nodePadding=10, iterations = 0)

p <- htmlwidgets::prependContent(p, htmltools::tags$h2("Human Displacement 2020" , style = "font-family: Arial"))
p <- htmlwidgets::prependContent(p, htmltools::tags$h4("In 2020, there were 18.9 million refugees under UNHCR's mandate.  Three quarters of these refugees were come from Syrian, Afghanistan, South Sudan, Myanmar, Somalia, and DR of Congo due to wars.  Most often, refugees were hosted by neighbouring or nearby countries." , style = "font-family: Arial"))
p <- htmlwidgets::appendContent(p, htmltools::tags$p("Source: UNHCR Refugee Data Finder https://www.unhcr.org/refugee-statistics/download/?url=5I6XeJ", style = "font-family: Arial"))

p

## The following section will create a shiny tool
# ui = shinyUI(fluidPage(
  
#   h3("Human Displacement 2020", style="text-align:left"),
#   h4("In 2020, there were 18.9 million refugees under UNHCR's mandate.  Three quarters of these refugees were come from Syrian, Afghanistan, South Sudan, Myanmar, Somalia, and DR of Congo due to wars.  Most often, refugees were hosted by neighbouring or nearby countriies.    "),
#   h5("Source: UNHCR Refugee Data Finder https://www.unhcr.org/refugee-statistics/download/?url=5I6XeJ", style="text-align:left"),
  
#   sankeyNetworkOutput('sankey')
# ))

# server = function(input, output) {
#   output$sankey <- renderSankeyNetwork(p)
# }

# shinyApp(ui = ui, server = server)

