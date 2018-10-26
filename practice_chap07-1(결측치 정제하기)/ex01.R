#데이터 정제 
#결측치 제거 

#데이터에서 NA는 결측치를 의미 (missing value)
df<-data.frame(sex=c("M","F",NA,"M","F"),
               score =c(5,4,3,4,NA))
df

#is.na(data frame name)
#return true -> missing value.
is.na(df)

#table()을 적용해 사용할 수도 있다.
table(is.na(df))

#missing value를 제거하기 위해선 변수(컬럼)명을 알아야 한다.
table(is.na(df$sex)) #sex변수명에 결측치 1개
table(is.na(df$score)) #score 변수명에 결측치 1개 

#결측치가 있으면 연산이 정상적으로 작동하지 않는다.
#제거를 하고 연산을 해야 한다.
mean(df$score)
sum(df$score)

#결측치 제거 
library(dplyr)
#score열의 결측치 제거 (!기호를 붙인다.)
df %>% filter(!is.na(df$score))

#sex열의 결측치도 같이 제거 
df %>% filter(!is.na(df$score) & !is.na(df$sex))

#위에서 나온 결과를 또 다른 프레임 변수에 할당 
df_nomiss <- df %>% filter(!is.na(df$score) & !is.na(df$sex))
df_nomiss

#결측치 제거 후 평균, 합계를 정상출력 할 수 있다.
mean(df_nomiss$score)
sum(df_nomiss$score)

#데이터프레임에 있는 결측치들을 한번에 제거하는 법
df_nomiss2 <- na.omit(df) #na.omit()는 결측치를 한번에 제거한다. 
df_nomiss2 

#그러나 한번에 결측치를 제거하는 na.omit()이 편하기는 하나,
#분석을 할때 분석에 필요한 데이터까지 제거할 수 있기 때문에 
#상황에 맞춰 사용을 해야한다. 
#보통 filter()를 이용해 분석한다. 

#수치 연산 함수들은 결측치를 제외하고 연산하도록 인자값으로 
#na.rm(na를 remove)을 지원한다. TRUE로 설정하면 결측치를 제거하는 절차를 
#건너뛰고 연산을 수행
mean(df$score, na.rm="TRUE")
sum(df$score, na.rm="true")

#dplyr패키지에 있는 summarize도 na.rm인자값을 제공 
exam <- read.csv("csv_exam.csv")
View(exam)

#아래 []사이의 의미는 쉼표를 기준으로 왼쪽은 행의 값, 오른쪽은 열의 값을 
#나타낸다. 즉, math열 3,8,15행에 NA값을 저장하라는 것.
exam[c(3,8,15), "math"] <-NA
exam

#결측치가 math열에는 3개 있기 때문에 평균값이 나오질 않는다.
exam %>% summarise(mean_math=mean(math))

#결측치 제외후 평균 산출
exam %>% summarize(mean_math=mean(math, na.rm="TRUE"))
exam %>% summarize(mean_math = mean(math,na.rm = "true"),#평균
                   sum_math=sum(math,na.rm="True"),#합계
                   median_math = median(math,na.rm="True"))#중앙

#데이터가 크고 결측치가 얼마 없다면 결측치를 제거하고 분석해도 무방
#소규모 데이터이고 결측치가 많다면 결측치를 다 제거 하면 많은 데이터가 손실
#따라서 분석결과가 왜곡될 수 있다. 
#이를 위해 결측치 대체법(imputation)

#평균값으로 결측치 대체
mean(exam$math, na.rm="TRUE") #평균 대략 55

#math열의 값이 NA이면 평균값인 55로 대체
exam$math <- ifelse(is.na(exam$math), 55, exam$math)

#확인해보니 NA값이 없다
table(is.na(exam$math))
exam
mean(exam$math)