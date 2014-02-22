cMonetDB <- function (foldx,dbx,portx=50000) {
  #
  path1 <- getwd()
  #file.remove(fold1,recursive=TRUE)
  #file.path(getwd(),foldx)
  startscript <- monetdb.server.setup0(file.path(getwd(),foldx),"/usr/local/Cellar/monetdb/11.15.19/bin/", dbx, portx)
  #/usr/local/Cellar/monetdb/11.15.19/bin/
  pid <- monetdb.server.start(startscript)
  #
  return(pid)
}
#
closedb <- function (connx,pidx,portx) {
  #
  dbDisconnect(connx,portx)
  monetdb.server.stop(pidx)
}
#
readCSV <- function (connx,filex,tablex,nrowx) {
  #
  fnamed <- file.path(getwd(),"data",filex)
  fname <- file.path(getwd(),filex)
  shalookup <- read.csv(fnamed, header=T)
  write.table(filex, fname, sep=",")
  monetdb.read.csv(connx,fname,nrows=nrowx,header=TRUE,tablename=tablex,delim=",")
  file.remove(fname)
  remove(filex)
  tablex <- monet.frame(connx,tablex)
  return(tablex)
}
##
monetdb.server.setup0 <- function (database.directory, monetdb.program.path, dbname = "demo", 
          dbport = 50000) 
{
  monetdb.program.path <- normalizePath(monetdb.program.path, 
                                        mustWork = FALSE)
  database.directory <- normalizePath(database.directory, mustWork = FALSE)
  if (!file.exists(database.directory)) {
    dir.create(database.directory)
    message(paste(database.directory, "did not exist.  now it does"))
  }
  else {
    if (length(list.files(database.directory, include.dirs = TRUE)) > 
          0) 
      stop(paste(database.directory, "must be empty.  either delete its contents or choose a different directory to store your database"))
  }
  bfl <- normalizePath(file.path(database.directory, dbname), 
                       mustWork = FALSE)
  dbfl <- normalizePath(file.path(database.directory, dbname), 
                        mustWork = FALSE)
  dir.create(dbfl)
  if (.Platform$OS.type == "windows") {
    bfl <- paste0(bfl, ".bat")
    mcl <- file.path(monetdb.program.path, "bin")
    if (!file.exists(mcl)) 
      stop(paste(mcl, "does not exist.  are you sure monetdb.program.path has been specified correctly?"))
    bat.contents <- c("@echo off", "setlocal", "rem figure out the folder name", 
                      paste0("set MONETDB=", monetdb.program.path), "rem extend the search path with our EXE and DLL folders", 
                      "rem we depend on pthreadVC2.dll having been copied to the lib folder", 
                      "set PATH=%MONETDB%\\bin;%MONETDB%\\lib;%MONETDB%\\lib\\MonetDB5;%PATH%", 
                      "rem prepare the arguments to mserver5 to tell it where to put the dbfarm", 
                      "if \"%APPDATA%\" == \"\" goto usevar", "rem if the APPDATA variable does exist, put the database there", 
                      paste0("set MONETDBDIR=", database.directory, "\\"), 
                      paste0("set MONETDBFARM=\"--dbpath=", dbfl, "\""), 
                      "goto skipusevar", ":usevar", "rem if the APPDATA variable does not exist, put the database in the", 
                      "rem installation folder (i.e. default location, so no command line argument)", 
                      "set MONETDBDIR=%MONETDB%\\var\\MonetDB5", "set MONETDBFARM=", 
                      ":skipusevar", "rem the SQL log directory used to be in %MONETDBDIR%, but we now", 
                      "rem prefer it inside the dbfarm, so move it there", 
                      "if not exist \"%MONETDBDIR%\\sql_logs\" goto skipmove", 
                      paste0("for /d %%i in (\"%MONETDBDIR%\"\\sql_logs\\*) do move \"%%i\" \"%MONETDBDIR%\\", 
                             dbname, "\"\\%%~ni\\sql_logs"), "rmdir \"%MONETDBDIR%\\sql_logs\"", 
                      ":skipmove", "rem start the real server", paste0("\"%MONETDB%\\bin\\mserver5.exe\" --set \"prefix=%MONETDB%\" --set \"exec_prefix=%MONETDB%\" %MONETDBFARM% %* --set mapi_port=", 
                                                                       dbport), "if ERRORLEVEL 1 pause", "endlocal")
  }
  if (.Platform$OS.type == "unix") {
    bfl <- paste0(bfl, ".sh")
    bat.contents <- c("#!/bin/sh", paste0(monetdb.program.path, 
                                          "/mserver5 --set prefix=", monetdb.program.path, " --set exec_prefix=", 
                                          monetdb.program.path, " --dbpath ", paste0(database.directory, 
                                                                                     "/", dbname), " --set mapi_port=", dbport, " --daemon yes > /dev/null &"), 
                      paste0("echo $! > ", database.directory, "/mserver5.started.from.R.pid"))
  }
  writeLines(bat.contents, bfl)
  if (.Platform$OS.type == "unix") {
    Sys.chmod(bfl, mode = "755")
  }
  bfl
}
##normalizePath("/usr/local/Cellar/monetdb/11.15.19/bin/",mustWork=FALSE)
