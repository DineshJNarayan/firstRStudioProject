library(RMariaDB)
library(DBI)
conRMariaDB <- dbConnect(   drv = RMariaDB::MariaDB(), 
                            username = 'root',
                            password = 'Vmcp2020Gain', 
                            host = '127.0.0.1', 
                            port = 3306, db = "Sourcepoint"  )

dbListTables(conRMariaDB)
dbListFields(conRMariaDB, "choice_behavior_req_rep")
dbDisconnect(conRMariaDB)

library(RMySQL)
library(DBI)
conRMySQL <- dbConnect(     RMySQL::MySQL(), 
                            username = 'root',
                            password = 'Vmcp2020Gain', 
                            host = '127.0.0.1', 
                            port = 3306, db = "Sourcepoint" )

dbListTables(conRMySQL)
dbListFields(conRMySQL, "messages_gdpr_performance_original")
dbDisconnect(conRMySQL)
