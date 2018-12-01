##Load Package:

library(dplyr)
library(ggplot2)
library(magick)

install.packages("tm")
install.packages("wordcloud")
install.packages("RColorBrewer")
library(tm)
library(NLP)
library(wordcloud)
library(RColorBrewer)

##Read File:

fileName1 <- "PM_Modi_Speech.txt"

conn1 <- file(fileName1,open="r")

linn1 <-readLines(conn1)

for (i in 1:length(linn1)){
  
  print(linn1[i])
  
}

modi<-Corpus(VectorSource(linn1))
inspect(modi)[1:10]

##Data Cleaning:
modi_data<-tm_map(modi,stripWhitespace)
modi_data<-tm_map(modi_data,tolower)
modi_data<-tm_map(modi_data,removeNumbers)
modi_data<-tm_map(modi_data,removePunctuation)
modi_data<-tm_map(modi_data,removeWords, stopwords("english"))


modi_data<-tm_map(modi_data,removeWords, c("and","the","our","that","for","are","also","more","has","must","have","should","this","with"))

tdm_modi<-TermDocumentMatrix (modi_data) #Creates a TDM
TDM1<-as.matrix(tdm_modi) #Convert this into a matrix format
v = sort(rowSums(TDM1), decreasing = TRUE) #Gives you the frequencies for every word

wordcloud (modi_data, scale=c(5,0.5), max.words=40, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))
