if(!requireNamespace("jug")){
  install.packages("jug")
}
if(!requireNamespace("rvest")){
  install.packages("rvest")
}
library(rvest)
library(jug)

tar<-"https://cloud.r-project.org/doc/manuals/r-release/NEWS.html"

jug() %>%
  get("/", function(req, res, err){
    versions <-
      tar %>% 
      read_html %>% 
      html_nodes("h3") %>% 
      html_text
    
    versions <- 
      sub(" CHANGES IN R ","",versions)
    
    res$json(versions)
  }) %>%
  simple_error_handler_json() %>%
  serve_it(host="0.0.0.0", port=80)
