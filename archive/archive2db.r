## load the library that allows R to connect to PostgreSQL database
library("RPostgres") 
## set the password, load the driver required for connection to PostgreSQL database
pw <- {"vdis/phdl"}
## Establish connection to the database
con <- dbConnect(RPostgres::Postgres(), dbname = "postgres", host = "localhost", port = 5432, user = "postgres", password = pw)

list_filenames <- list.files(path="./csv_files", pattern=NULL, all.files=FALSE, full.names=TRUE)

filenames <- data.frame(x = list_filenames)

for(j in 1:nrow(filenames)) {
  
  ## Read the data file
  print(list_filenames[j])
  #skip_lines <- grep("Date", readLines(list_filenames[j]))
  #main_data <- data.frame(read.csv(file = list_filenames[j], skip = skip_lines, header = FALSE, sep = ","))
  main_data <- data.frame(read.csv(file = list_filenames[j], header = TRUE, sep = ","))
  main_data <- data.frame(main_data, row.names = NULL) 
  main_data[is.na(main_data)] <- 0
  
  colnames(main_data) <- c( 'booking_date', 'execution_date', 'action', 
                            'withdrawal', 'deposit', 'comment', 'amount',
                            'after_transaction' ) 
  
  main_data <- data.frame(main_data, row.names = NULL) 
  main_data[is.na(main_data)] <- 0
  
  print(main_data)
  
  for(i in 1:nrow(main_data)) {
    
  db_query    <- "  insert into python_tech_task  (
                        booking_date,
                        execution_date,
                        action,
                        withdrawal,
                        deposit,
                        comment,
                        amount,
                        after_transaction  )
                    values  (                 
                        'BOOKDATE',
                        'EXECDATE',
                        'ACTN',
                        'WTHDRWL',
                        'DPST', 
                        'CMMNT',
                        'AMNT', 
                        'AFTR_TRNS'  ) "
  
  
  db_comment <- main_data[i,"comment"]
  db_action <- main_data[i,"action"]
  db_withdrawal <- main_data[i,"withdrawal"]
  db_deposit <- main_data[i,"deposit"]
  db_amount <- main_data[i,"amount"]
  db_after_transaction <- main_data[i,"after_transaction"]
  
  db_comment <- sub("'", "", db_comment)
  db_action <- sub("'", "", db_action)
  db_withdrawal <- sub("", 0, db_withdrawal)
  db_deposit <- sub("", 0, db_deposit)
  db_amount <- sub("", 0, db_amount)
  db_after_transaction <- sub("", 0, db_after_transaction)
  
  db_withdrawal <- sub(",", ".", db_withdrawal)
  db_deposit <- sub(",", ".", db_deposit)
  db_amount <- sub(",", ".", db_amount)
  db_after_transaction <- sub(",", ".", db_after_transaction)
  
  db_query    <- sub("BOOKDATE", main_data[i,"booking_date"], db_query)
  db_query    <- sub("EXECDATE", main_data[i,"execution_date"], db_query)
  db_query    <- sub("ACTN", db_action, db_query)
  db_query    <- sub("WTHDRWL", db_withdrawal, db_query)
  db_query    <- sub("DPST", db_deposit, db_query)
  db_query    <- sub("CMMNT", db_comment, db_query)
  db_query    <- sub("AMNT", db_amount, db_query)
  db_query    <- sub("AFTR_TRNS", db_after_transaction, db_query)
  
  #print(db_query)
    
    ## insert data for campaign into database table  
    ##x  <- dbGetQuery(con, db_query)
    
  }
  
  
}