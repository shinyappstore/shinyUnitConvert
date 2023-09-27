# application UI object
ui <- fluidPage(
  # Theme: Select color style from 1-13
  style = "5",

  # add custom background
  # custom.bg.color = "brown",

  # use shiny js
  shinyjs::useShinyjs(),

  # add scripts
  tags$head(
    tags$script(src = "script.js"),
    tags$link(rel = "stylesheet", href = "style.css")
  ),

  # Header: Insert header content using titlePanel ------------
  header = titlePanel(left = paste0("Multi-Unit Converter v",vers), right = "@rpkg.net"),
  useShinyjs(), #use shiny js
  initStore(), #use shinyStorePlus
  row(
    altPanel(
      card(
        title = "Conversion type",
        id = "conversationleft",
        lapply(convcats,function(i) actionButton(paste0('conv_',i),gsub("_"," ",i), style='pill', bg.type="warning",size='l'))
      )
    ),
    mainPanel(
      div(
        id = "conversationcnt",
        class = "bg-white p-4",
        div(id = "conversionitemcontainer",
            div(class="initial-statment",
                tags$h2("Welcome to the R shiny interactive unit converter."),br(),
                tags$h3("This dashboard allows you to convert across multiple units at a time. Simply begin by selecting the conversion type from the left panel.
                        When the conversion type is selected, this panel will be automatically populated with the available conversion fields.
                        Find a conversion simply by changing the value of the fields, and the rest will automatically be re-calculated.
                        "),
                tags$h4("NOTE: This dashboard is built primarily with the 'nextGenShinyApps' and 'measurements' R package."),
                br(),tags$h4("Enjoy using the dashboard!")


                )),
        h2(tableOutput("names")),
        shiny::tags$span(id="converted")
      )
    )
  )
)
