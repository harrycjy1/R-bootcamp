
#이번장에서는 데이터 분석하기 기초를 배우도록 합니다.
#데이터를 분석하기 위해서는 일단 데이터를 가져와야 합니다.
library(readxl)

exam <- read.csv("csv_exam.csv")
exam

#head함수는 데이터의 양이 많을때 앞부분만 가져와서 데이터의 구성을 살필때 사용
head(exam)
head(exam,11)

#tail은 뒤에서 부터

tail(exam)
tail(exam,11)

#View()함수는 실제 excel과 유사하게 화면에 데이터를 보여주는 함수
#반드시 V는 대문자로 해야합니다. 함수에는 대소문자가 섞여있는 것들이 많음

View(exam)

#dim()함수는 dimensions(차원)의 약자로 데이터의 행열을 보여줌 (row,column)
#행(row)는 하나의 데이터 값이고 열(column)은 속성, 변수라고 함

dim(exam)

#속성을 알아보는 str()함수를 사용해봅니다.
#여기서 obs(observation) - 관측치 즉, 행의 갯수를 의미하고 variables는 변수(속성)의 갯수를 의미

str(exam)
exam$id<-as.character(exam$id)
exam$class <- as.character(exam$class)

#요약 통계량을 산출하는 함수는 summary()써보자

summary(exam)

#summary()함수를 사용해서 출력하면 6개의 값이 산출된다. 이게 바로 기초분석인데 각각 설명하자면
#min은 최소 1st Qu : 1사분위수(1st Quantile) 하위 25% 지점에 위치하는값
#Median : 중앙값, Mean : 평균값 3rd Qu : 3사분위수 하위 75%지점에 위치하는 값
#Max : 최대값

#과학점수를 분석해보면 62.50을 기준으로 하여, 45.00에서 78.00사이에 학생들의 점수가 쏠려있음

#또한 과학 최저점은 12점 최고점은 98점 평균은 59.45입니다.

#mpg데이터 파악하기
#mpg데이터는 ggplot2패키지안에 내장되어 있는 데이터입니다.
#mpg변수에 as.data.frame()함수를 이용해서 데이터 속성을 데이터 프레임 형태로 바꾸어 저장하고 있습니다.
#그리고 인자값인 ggplot2::mpg는 ggplot2패키지에 들어있는 mpg데이터를 가리키는 코드

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
mpg



#데이터가 234행에 변수 11개로 구성
dim(mpg)

head(mpg)
tail(mpg)
View(mpg)

#속성은 char(문자), num(소수점이 있는 실수, P/G언어에서 float나 double)
#int(정수) 중요한것은 num과 int를 구별할 줄 알아야한다.
str(mpg)

#요약창을 봅니다 각 속성들은 책을 참고
summary(mpg)

boxplot(mpg$hwy)

#여기서 hwy(고속도로연비),  cty(도시연비)에 대해서 분석하고 발표해 봅시다.
#help를 이용하면 mpg데이터의 속성들에 대해 나와 있습니다.
?mpg

write.csv(mpg, file="fuel.csv")

