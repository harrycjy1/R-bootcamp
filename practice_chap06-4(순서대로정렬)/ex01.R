

#이번에는 데이터들을 정렬을 하는 법을 배워봅니다.
#먼저 정렬을 할려면 기준이 되는 변수가 있어야됩니다.

exam <- read.csv("csv_exam.csv")

#원본 데이터 프레임 생성
library(dplyr)

#exam데이터프레임에서 math변수를 중심으로 오름차순 정렬이 됩니다. 
exam %>% arrange(math)

#내림차순으로 정렬하려면 desc(descending)함수를 사용하면 도비니다.
exam %>% arrange(desc(math)) 
