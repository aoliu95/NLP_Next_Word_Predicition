# Import libraries that are needed for processing in this module.
library(shiny) 
library(data.table) 
library(tm) 
library(NLP) 


#Read in the Dataset for the N-grams.
Dataset <- fread("NgramTable_05percent_Datatable.txt") 
setkeyv(Dataset, c('w1', 'w2', 'w3', 'w4', 'freq')) 

#Format the text inout and remove blanks spaces.
Translate_Input <- function(Text){ 
  RemainderInput <- tolower(Text) 
  RemainderInput <- stripWhitespace(RemainderInput) 
  RemainderInput <- gsub("[^\\p{L}\\s]+", "", RemainderInput, ignore.case=F, perl=T) 
  return(RemainderInput) 
} 

#Tokenize the text
  Split_Translate_Input <- function(Text){ 
  RemainderInput <- tolower(Text) 
  RemainderInput <- stripWhitespace(RemainderInput) 
  RemainderInput <- gsub("[^\\p{L}\\s]+", "", RemainderInput, ignore.case=F, perl=T) 
  TokenizeInput <- unlist(strsplit(RemainderInput, " ")) 
  return(TokenizeInput) 
} 

  #Display alternative predictions. 
  WordCount1 <- function(TextInputWC1){ 
  NgramsData <<- Dataset[list("<s>", TextInputWC1[1])] 
  NgramsData <<- NgramsData[NgramsData$w3!="<s>", ] 
  NgramsData <<- NgramsData[order(NgramsData$freq, decreasing=TRUE), ] 
  
  #Display alternative predictions.
  Prediction <<- as.data.frame(NgramsData) 
  Prediction <<- Prediction[1:15, c("w3", "freq")] 
  Prediction <<- Prediction[!is.na(Prediction$freq), ] 
  Prediction <<- Prediction[!duplicated(Prediction), ] 
  if(nrow(Prediction)==0){ 
    Prediction <<- data.frame(Word=NA, Likelihood=NA) 
  }else{ 
    Prediction$freq <- round(Prediction$freq/sum(Prediction$freq)*100, 1) 
    Prediction <<- Prediction 
    colnames(Prediction) <<- c("Word", "Likelihood") 
    rownames(Prediction) <<- NULL 
  } 
  # Error handle, if program cannot the next word for the inputted statement.
  ShowPrediction <- NgramsData$w3[1] 
  if(is.na(ShowPrediction)|is.null(ShowPrediction)){ 
    ShowPrediction <- "The Shiny app could not predict the next word. Please try again with a new statement." 
  } 
  
  #test rownames(Prediction) <<- NULL 
  return(ShowPrediction) 
} 


WordCount2 <- function(TextInputWC2){ 
  NgramsData <<- Dataset[list("<s>", TextInputWC2[1], TextInputWC2[2])] 
  NgramsData <<- NgramsData[NgramsData$w4!="<s>", ] 
  NgramsData <<- NgramsData[order(NgramsData$freq, decreasing=TRUE), ] 
  
  #Display alternative predictions. 
  Prediction <<- as.data.frame(NgramsData) 
  Prediction <<- Prediction[1:15, c("w4", "freq")] 
  Prediction <<- Prediction[!is.na(Prediction$freq), ] 
  Prediction <<- Prediction[!duplicated(Prediction), ] 
  if(nrow(Prediction)==0){ 
    Prediction <<- data.frame(Word=NA, Likelihood=NA) 
  }else{ 
    Prediction$freq <- round(Prediction$freq/sum(Prediction$freq)*100, 1) 
    Prediction <<- Prediction 
    colnames(Prediction) <<- c("Word", "Likelihood") 
    rownames(Prediction) <<- NULL 
  } 
  
  ShowPrediction <- NgramsData$w4[1] 
  if(is.na(ShowPrediction)|is.null(ShowPrediction)){        
    ShowPrediction <- WordCount1(TextInputWC2[2]) 
  } 
  
  return(ShowPrediction) 
} 


WordCount3 <- function(TextInputWC3){ 
  NgramsData <<- Dataset[list("<s>", TextInputWC3[1], TextInputWC3[2], TextInputWC3[3])] 
  NgramsData <<- NgramsData[NgramsData$w5!="<s>", ] 
  NgramsData <<- NgramsData[order(NgramsData$freq, decreasing=TRUE), ] 
  
  #Display alternative predictions. 
  Prediction <<- as.data.frame(NgramsData) 
  Prediction <<- Prediction[1:15, c("w5", "freq")] 
  Prediction <<- Prediction[!is.na(Prediction$freq), ] 
  Prediction <<- Prediction[!duplicated(Prediction), ] 
  if(nrow(Prediction)==0){ 
    Prediction <<- data.frame(Word=NA, Likelihood=NA) 
  }else{ 
    Prediction$freq <- round(Prediction$freq/sum(Prediction$freq)*100, 1) 
    Prediction <<- Prediction 
    colnames(Prediction) <<- c("Word", "Likelihood") 
    rownames(Prediction) <<- NULL 
  } 
  
  #Display predictions.
  ShowPrediction <- NgramsData$w5[1] 
  if(is.na(ShowPrediction)|is.null(ShowPrediction)){ 
    Shortened_Input <- c(TextInputWC3[2], TextInputWC3[3]) 
    ShowPrediction <- WordCount2(Shortened_Input) 
    if(is.na(ShowPrediction)|is.null(ShowPrediction)){ 
      ShowPrediction <- WordCount1(TextInputWC[3]) 
    } 
  } 
  
  return(ShowPrediction) 
} 
