

#문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석기법을 텍스트마이닝(Text Mining)이라고 한다.
#텍스트 마이닝에서 가장먼저 해야 할일은 바로 형태소부넉, 즉 어떤 품사들로 이루어져 있는지를
#분석해야 한다. 먼저 텍스트 마이닝을 할 준비를 하자.

#먼저 벡터를 이용하여 워드클라우딩을 해보자.
install.packages("wordcloud")
library(wordcloud)

#wordcloud()
#패키지 : wordcloud
#사용법 : wordcloud(words, freq, scale, min.freq, max.words, random.order, random.color,
#rot.per, colors)
#설명 : 워드 클라우드 그리기

# 매개변수
# words : 단어
# freq : 단어들의 빈도
# scale : 가장 빈도가 큰 단어와 가장 빈도가 작은 단어 폰트 사이의 크기 차이
# min.freq : 출력될 단어들의 최소 빈도
# max.words : 출력될 단어들의 최대 빈도(inf : 최대제한이 없음을 의미)
# random.order : True이면 랜덤으로 단어출력, False이면 빈도수가 큰 단어를 중앙에 배치하고 작은순으로 배치함
# random.color : True이면 색은 랜덤순으로 정해지며, false이면 빈도순으로 정해짐
# rot.per : 90도 회전된 각도로 출력되는 단어비율
# colors : 가장 작은 빈도부터 큰 빈도까지의 단어 색

# 지역명 할당
word <- c("인천광역시","강화군","웅진군")
# 전입과 전출을 고려한 지역의 순이동 인구수
frequency <- c(651 , 85,61)
# 워드클라우드 출력
wordcloud(word,frequency, colors = "blue", random.order = FALSE)
wordcloud(word, frequency, random.order = FALSE, random.color = FALSE, colors = rainbow(length(word)))


install.packages("RColorBrewer")
library(RColorBrewer)

# brewer.pal()
# package : RcolorBrewer
# 사용법 : brewer.pal(n,name)
# 설명 팔레트를 마듬

# 매개변수
# n : 팔레트의 색의 수 (최소색은 3, 최대수는 팔레트 유형에 따라 다름)
# name : 팔레트 이름
# 팔레트 유형
# 1. Sequential palettes : 낮은 쪽에서 높은 쪽으로 생상밝기가 변함
# 2. Qualitative palettes : 색조의 변화로 시각 차이를 만듬
# 3. Diverging palettes : 가운데 색은 밝고 양 끝은 어두운 색으로 강조

# display.brewer.all()
# 패키지 : RColorBrewer
# 사용법 : display.brewer.all(type = "all")
# 설명 : 팔레트 유형에 해당하는 팔레트를 출력

# 매개변수
# type : 팔레트 유형
# 1. seq : Sequential palettes
# 2. div : Diverging palettes
# 3. qual : Qualitative palettes

#모든 팔레트 출력
display.brewer.all()

# display.brewer.pal()
# 패키지 : RColorBrewer
# 사용법 : display.brewer.pal(n,name)
# 설명 : 지정한 팔레트 출력

# 매개변수
# n : 팔레트 색의 수 (최소 3개, 최대수 팔레트 유형에 따라 다름)
# name : 팔레트 이름

display.brewer.pal(8, name = "Dark2")

# 1. 힙합음악 가사를 통한 텍스트 마이ㅣㅇ
# 패키지 준비, 먼저 한글 자연어 분석 패키지인 KoNLP를 이용
# 하면 한글데이터로 형태소 분석을 할 수 있다. 단, 자바가 설치되어 있어야한다
# 패키지를 순서대로 설치해보자

install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

# 단 아래와 같이 작업을 해줘야 하는 경우도 있다 \이 아니라 /이니 이스케이프 문자를 잘보도록하자.

Sys.setenv(JAVA_HOME="C:/Program Files")
Sys.setlocale(category = "LC_CTYPE", locale = "ko_KR.UTF-8")
Sys.getlocale()

library(KoNLP)
library(dplyr)

#이제 사전을 설정해야 되는데 KoNLP에서는 NiA라는 사전이 98만여 개의 단어로 구성되어있다
#이제 이 사전을 이용하도록 하자
useNIADic()

#주의 할 점, hiphop.txt파일을 깃허브에서 다운받을때 Raw 클릭시 깨짐현사잉 있다면 인코딩을 자동설정으로 해서
#복사해서 메모장에 붙여넣어서 사용하길 바란다.
txt <- readLines("hiphop.txt")
txt
#문장에 이모티콘이나 특수문자가 포함되어 있으면 분석에 오류가 발생할 수 있다.
#하여 문자 처리 패키지인 string의 str_replace_all()을 사용하여 특수문자를 빈칸으로 처리하자
install.packages("string")
library(stringr)

#오타에 주의하자 대문자 \\W다. //W는 정규표현식에서 특수문자를 의미한다
# 이것을 공백으로 바꾸는 것이다.
txt <- str_replace_all(txt,"\\W"," ")
txt
# extractNoun()함수는 명사(noun)만 추출한다
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

#그럼 위 가사에서 명사를 추출하고 각 단어가 몇번씩 사용되었느지 빈도표를 만들자
nouns <- extractNoun(txt)

#nouns는 현재 데이터 구조를 보니 list타입이다
# 이렇게 되어버리면 빈도를 구할수가 없다. 하여 벡터타입으로 변경이 불가피하다.
class(nouns)

#데이터구조
#벡터 : 1차우너이며 한가지 변수타입으로 구성
#데이터프레임 : 2차운이며 다양한 변수타입으로 구성
#매트릭스 : 2차원이며 한가지 변수타입으로 구성
#어레이 : 다차우너이며 2차원 이상의 매트릭스로 구성
#리스트 : 다차원이며 서로 다른 데이터 구조를 포함한것

#그럼 추출한 명사의 데이터 구조 list를 문자열 벡터로 변환하여 단어별 빈도표를 생성하자
wordcount <- table(unlist(nouns))

#테이블형태로 변환되었다
class(wordcount)
View(wordcount)

#테이블을 데이터프레임구조로 바꾸자.
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
class(df_word)
df_word

View(df_word)

#확인해보니 Var1 은 단어, Freq는 빈도수를 나타내고 잇으니 보기 좋게 변수명을 바꾸자
df_word <- rename(df_word, word=Var1, freq = Freq)

#보통 한글자로 된 단어는 의미가 없는 경우가 많아 nchar()를 이용하여 두 글자 이상 으로 된 단어만 추출하도록 하자
df_word <- filter(df_word, nchar(word) >=2)
df_word

#이제 두 그자 이상된 단어 중 빈도 순으로 정렬 한 후 , 상위20개만 추출

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

View(top_20)

#이제 이 단어들을 가지고 워드 클라우드를 만들어 보자
#워드클라우드는 단어의 빈도를 가지고 구름모양으로 표현한 그래프이다

library(wordcloud)
library(RColorBrewer)

pal <- brewer.pal(8,"Dark2")

# 워드클라우드는 실행할 때 마다 난수를 이용해서 매번 다른 모양의 워드 클라우드를 만들어 내므로
# 아래 시드값을 설정해서 동일하게 나오도록 하자.
set.seed(1234)

wordcloud(words = df_word$word, #나타낼 단어
          freq = df_word$freq, 
          min.freq = 5,
          max.words = 100,
          random.order = F,#랜덤배치 x
          rot.per = .1,         #회전단어비율
          scale = c(4,0.2),     #단어크기비율
          colors = pal)         #색상 목록



##################################################################################################

#10-2 국정원 트윗 텍스트 마이닝
# 텍스트 마이닝은  SNS에 올라온 글을 통해 사람들이 어떤생각을 가지고 있는지에 대해 알아보기위한
# 목적으로 자주 활용된다. 아래 예제는 2013년 6월 뉴스타파가 인터넷을 통해 공개한 것이다.
# 무작위로 나열되어 있지만, 텍스트 마이닝을 통해 의도가 분명한 경향성을 반견할 수 있을 것이다.

twitter <- read.csv("twitter.csv", stringsAsFactors = F, fileEncoding = "UTF-8")
View(twitter)
str(twitter)
class(twitter)
dim(twitter)

library(dplyr)
twitter <- rename(twitter, 
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)
library(stringr)
#특수 문자 제거
twitter$tw <- str_replace_all(twitter$tw,"\\W"," ")
head(twitter$tw, 5)

#트윗 내용에서 명사 추출
nouns <- extractNoun(twitter$tw)
nouns

class(nouns)

# 추출한 명사 list데이터구조를 문자열 벡터로 변환, 단어별 빈도표 생성
# word <- unlist(nouns)
# class(word)
# wd <- as.data.frame(wordcount1, stringsAsFactors = F)
# class(wd)
# wd
# wordcount <- table(wd)
#class(wordcount)
# 추출한 명사 list데이터구조를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
class(wordcount)
#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
class(df_word)
str(df_word)

#변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

#두글자 이상 단어만 추철
df_word <- filter(df_word, nchar(word)>=2)
df_word

#빈도수가 상위 20개만 추출
top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

#아래와 같이 출력해보니 북한, 대한민국 좌파 등등 이 많이 사용된 것을 알수가 있다.
top_20
library(ggplot2)
order <- arrange(top_20,freq)
order




#그래프ㅗ 그려보니 무려 북한이란 단어가 대한민국의 세배 정도 된다. 
#국정원 트윗에서 북한이라는 용어가 많이 등장을 했고 이슈화 시키려고하는 의도가 보임

ggplot(data = top_20, aes(x=word, y= freq))+
  ylim(0,2000)+
  geom_col(fill="black", colour = "yellow")+
  coord_flip()+
  scale_x_discrete(limit = order$word)+
  geom_text(aes(label = freq), hjust = -0.3) #빈도를 표시함

#위의 자료로 워드클라우드 만들기
pal <- brewer.pal(8,"Dark2")
pal1 <- brewer.pal(9,"Blues")[5:9]
set.seed(1234)

#필요없는 단어 지우기
df_word$word <- gsub("우리"," ",df_word$word)

library(wordcloud)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 100,
          random.order = FALSE, #단어 빈도가 높은것을 중아에 배치
          rot.per = .1, #회전단어 비율
          scale = c(6, 0.5), #단어 크기 목록
          colors = pal
          )


