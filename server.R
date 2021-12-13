function(input, output, session) {
  values <- reactiveValues( file1 = NULL )
  observe({
    values$file1 <- input$file1
    if(!is.null(input$file1)){
      if(input$file1$name != 'cash-expences.xls') {
        values$file1 <- NULL
        mess <- 'error: wrong file. Expects cash-expences.xls'
        print(mess)
        showNotification(mess)
        return(NULL)
      }
      result <- tryCatch({
        dframe <<- read_excel(
          values$file1$datapath,
          sheet = "Operational_Report")
        listOfSheets <<- excel_sheets(values$file1$datapath)
        input$sel_sheet <- renderUI({
          selectInput(
            inputId = 'sel_sheet', 
            label = 'select excel sheet',
            choices = listOfSheets, 
            selected = 1)
        })        
        }
      )
      }
  })
  observe({
    #if(!is.null(input$sel_sheet))
      {
      result <- tryCatch({
        dframe <<- read_excel(values$file1$datapath, sheet = 'Operational_Report')
      })
    }
  })
  
  output$plot1 <- renderPlot({
     if(!is.null(values$file1)){
       plot(
        dframe$bonus_cashback_included,
        dframe$rounding_amount,
        xlab = "Data of operation",
        ylab ="Rub",
        xlim = c(min(dframe$bonus_cashback_included, na.rm = TRUE), 
                 max(dframe$bonus_cashback_included, na.rm = TRUE)),
        ylim = c(min(dframe$rounding_amount, na.rm = TRUE),
                 max(dframe$rounding_amount, na.rm = TRUE)),
        main = "test 1",
        pch = 19, 
        col = "gray",
        frame = FALSE
        )
      lines(lowess(
        dframe$bonus_cashback_included, 
        dframe$rounding_amount),
        col = "blue")
    }
  })
  # observeEvent(input$chk1 | (input$n | as.numeric(input$sel1)),{
  #   if(!is.null(values$file1)){
  #     if(input$chk1) output$table1 <- renderTable({
  #       filter <- dframe[,as.numeric(input$sel1)] == input$n
  #       df <<- dframe[filter,]
  #     }) 
  #     else output$table1 <- renderTable(dframe)
  #   }
  # })
}
