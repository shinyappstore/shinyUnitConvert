# prepare environment
quickcode::clean()
quickcode::libraryAll(
  shiny,
  nextGenShinyApps,
  shinyjs,
  shinyStorePlus,
  dplyr,
  magrittr,
  measurements,
  clear = TRUE)



#app version
vers <- 0.8


#conversion categories
convcats <- names(measurements::conv_unit_options)

#reactive holder
impHolderA <- reactiveValues()
impHolderA$currentVal <- 1
impHolderA$currentUnit <- NULL
impHolderA$currentSetTime <- as.numeric(Sys.time())
impHolderA$calculate <- FALSE
impHolderA$starttrigger <- FALSE
impHolderA$elms <-c()
