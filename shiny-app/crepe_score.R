
crepe_score <- function(text, dir) {
  
  require(mxnet)
  
  alphabet <- c("abcdefghijklmnopqrstuvwxyz0123456789-,;.!?:'\"/\\|_@#$%^&*~`+ =<>()[]{}")
  vocab.size <- nchar(alphabet)  
  feature.len <- 1014
  
  str.manipulate <- function(x, max.text.lenght=500){
    x <- substr(x, 1, max.text.lenght)
    Encoding(x) <- "UTF-8"
    x <- tolower(x)
    return(x)
  }
  
  map.text.to.number <- function(data, alphabet, nomatch = 0){
    alphabet.list <- strsplit(alphabet, split = "")[[1]]
    xx <- strsplit(data, split="")
    xx <- lapply(xx, rev)
    data.map <- lapply(xx, match, table=alphabet.list, nomatch = nomatch)
    data.map
  }
  
  dict.decoder <- function(data, alphabet, feature.len, batch.size){
    vocab.size <- nchar(alphabet)
    feature.matrix <- apply(data, 2, function(x){
      im <- matrix(0L, feature.len, vocab.size)
      for(i in seq_along(x)){
        im[i,x[i]] <- 1L
      }
      im
    })
    dim(feature.matrix) <- c(feature.len, vocab.size, 1,  batch.size)
    feature.matrix
  }
  
  test_line <- str.manipulate(text, max.text.lenght = 500)
  
  data.map <- unlist(map.text.to.number(test_line, alphabet))
  data.map <- c(data.map, rep(0, feature.len - length(data.map)))
  data.map <- as.array(data.map)
  dim(data.map) <- c(1014, 1)
  
  feature.matrix <- dict.decoder(data.map, alphabet = alphabet, feature.len = feature.len, batch.size = 1)
  
  model_dir <- ""
  model <- mx.model.load(file.path(model_dir, "crepe_amazon_categories_mrs"), iteration = 10)
  
  prediction <- predict(model, X = feature.matrix)
  
  prediction <- as.numeric(prediction)
  
  prediction
  
}

