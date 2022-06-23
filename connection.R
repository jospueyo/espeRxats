library(tidyverse)

.password <- Sys.getenv("ESPERXATS_DB")

if(.password == "") .password <- readline("Contrassenya a la base de dades: ")

db <- DBI::dbConnect(RMySQL::MySQL(),
                      host = "lhcp2008.webapps.net",
                      user = "xj2y7bq5_pueyo",
                      password = .password,
                      dbname = "xj2y7bq5_wp375",
                      port=3306)

 
tables <- c("castells", "colles", "diades", "diades_castells", "diades_colles", "resultats")

get_table <- function(.table, .db = db){
  if (!DBI::dbIsValid(.db)) .db
  
  tbl(.db, .table) %>% 
    as_tibble()
}

DBI::dbIsValid(db)
