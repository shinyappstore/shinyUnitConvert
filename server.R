# application Server function

server <- function(input, output, session) {
  lapply(convcats, function(i) {
    divdi <- paste0("conv_", i)
    convs <- measurements::conv_unit_options[[i]]
    tailconvs <- tail(convs, 1)
    observeEvent(input[[divdi]],
      {
        # set initial values when clicked
        impHolderA$elms <- c()
        impHolderA$currentVal <- 1
        if (not.null(impHolderA$currentUnit)) {
          if (impHolderA$currentUnit != convs[1]) {
            impHolderA$currentUnit <- convs[1]
            impHolderA$calculate <- FALSE
          }
        }


        # clear current boxes
        runjs("$('#conversionitemcontainer').html('')")

        # add new conversion boxes
        lapply(convs, function(ill0) {
          numid <- paste0(number(n = 1, max.digits = 6),"__")  #simulate 1 number
          ill <- paste0(numid,ill0)
          tailconvs <- paste0(numid,tailconvs)
          newid2 <- paste0("conV_c_", ill)
          insertUI("#conversionitemcontainer",
            where = "afterBegin",
            textInput(newid2, HTML(gsub("2", "<sup>2</sup>", gsub("_per_", "/", ill0))),
              size = "l", 0, style = "clean"
            )
          )

          impHolderA$elms <- c(impHolderA$elms, ill)

          observeEvent(input[[newid2]],
            {
              if ((as.numeric(Sys.time()) - impHolderA$currentSetTime) > 1) {
                impHolderA$currentSetTime <- as.numeric(Sys.time())
                impHolderA$currentVal <- input[[newid2]]
                impHolderA$currentUnit <- ill
                # activate at the end
                #if (ill == tailconvs) {
                  impHolderA$calculate <- TRUE
                #}
              }
            },
            ignoreInit = T
          )
        })

        # print("lion")
      },
      ignoreInit = T
    )
  })


  # observe any change in currentVal
  observe({
    if (not.null(impHolderA$currentUnit)) {
      if (impHolderA$calculate & length(impHolderA$elms)) {
        lapply(impHolderA$elms, function(ill) {
          newid <- paste0("conV_c_", ill)

          tryCatch({
            val0 <- round(measurements::conv_unit(as.numeric(impHolderA$currentVal), strsplit(impHolderA$currentUnit,"__")[[1]][2], strsplit(ill,"__")[[1]][2]), 3)
            updateTextInput(
              inputId = newid, value = ifelse(is.na(val0),0,val0)
              )
          }, error = function(e) e, finally = {})
        })
        # hault calculation when its finished
        impHolderA$calculate <- FALSE
      }
    }
  })

  # insert at the bottom  !!!IMPORTANT
  appid <- "unitschecker1"
  setupStorage(appId = appid, inputs = TRUE)
}
