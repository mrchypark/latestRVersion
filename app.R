if(!requireNamespace("jug")){
  install.packages("jug")
}
if(!requireNamespace("httr")){
  install.packages("httr")
}
library(httr)
library(jug)

tar<-"https://cloud.r-project.org/doc/manuals/r-release/NEWS.html"

getVersions<-function(tar){
  cont<-content(GET(tar),"text")
  cont<-strsplit(cont," ")[[1]]
  cont<-cont[grep("h3",cont)]
  cont<-cont[grep("^[0-9]",cont)]
  cont<-strsplit(cont,"</")
  cont<-unlist(lapply(cont, function(x) x[1]))
  return(cont)
}

jug() %>%
  get("/", function(req, res, err){
    versions<-getVersions(tar)
    res$json(versions)
  }) %>%
  get("/latest", function(req, res, err){
    versions<-getVersions(tar)
    return(versions[1])
  }) %>% 
  simple_error_handler_json() %>%
  # serve_it()
  serve_it(host="0.0.0.0", port=80)
