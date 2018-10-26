
text <- readLines("president.txt")

head(text)

str1 <- str_replace_all(text,"\\W"," ")

class(str1)

head(str1)

words <- extractNoun(str1)

class(words)

str2 <- table(unlist(words))

df_words <- as.data.frame(str2, stringsAsFactors = F)

df_words <- rename(df_words, word=Var1, freq=Freq)

df_words <- filter(df_words, nchar(word)>=2)

pal <- brewer.pal(8,"Dark2")

set.seed(1234)

wordcloud(words = df_words$word,
          freq = df_words$freq,
          min.freq = 5,
          max.words = 100,random.order = F,colors = pal,rot.per = .1,scale = c(4,0.2)
          )
