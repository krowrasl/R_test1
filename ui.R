fluidPage(
  titlePanel("Test1"),
  tags$style(".shiny-file-input-progress {display: none}"),
  tags$img(height = 121, width = 307,
    alt = "Service Logo",
    src = "service_logo.jpg"
  ),
  tags$br(),
  tags$br(),
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      fileInput( 'file1', 'Choose file', accept = c(".xls") ),
      checkboxInput(inputId = 'chk1', 
        label = 'filter ON', 
        value = FALSE
      ),
      selectInput(
         inputId ="sel1",
         label = "filter column",
         choices = c(
           'cashback'=7,
           'bonus (cashback included)'=10,
           'rounding amount'=11), 
         selected = 10
      ),
      numericInput(inputId = "n", "filter value", value = 1)
    ),
    # Show main panel
    mainPanel(
      plotOutput(outputId = "plot1"),
      tableOutput(outputId = "table1")      
    )
  )
)
