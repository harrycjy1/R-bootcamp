
#이번 장은 데이터를 합치는 것에 대해서 알아보도록 합니다.
#예ㅡㄹ 들면 중간, 기말고사 데이터를 합쳐서 하나의 시험점수 데이터를 만들어 분석해보도록 합시다.

#1 먼저 가로로 합치기를 해봅시다.

test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))

test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

#dplyr패키지의 left_join()을 이용하면 데이터를 가로로 합칠 수 있습니다.
library(dplyr)

#left_join을 사용시에 인자값에 by를 추가하여 기준이 되는 변수를 ""로 지정해야한다.
total <- left_join(test1, test2, by = "id")
total

library(readxl)
exam <- read_excel("excel_exam.xlsx")
exam

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim","lee","park","choi","jung"))
name

#class별로 가로로 합치게 됩니다.
exam_new <- left_join(exam,name,by="class")
exam_new

#세로로 합치기에 대해 알아봅니다.

#먼저 세로로 합칠 데이터프레임을 2개 아래와 같이 생성합니다.

group_a <- data.frame(id=c(1,2,3,4,5),
                      test = c(60,80,70,90,85))

group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,83,66,77,55))

#group_a와 b가 각각 변수명이 id,test로 동일하기때문에 bind_rows를 이용해서 세로로 합칠수가 있습니다.
#변수명이 다르다면 rename()을 통해서 변수명을 동일하게 하도락 합니다

group_all <- bind_rows(group_a,group_b)
group_all

#dplyr패키지 함수의 요약
#1. 조건에 맞는 데이터만 추출하기
exam %>% 
  filter(english>=80)

#여러 조건을 동시에 충족
exam %>% 
  filter(class == 1 & math >= 50)

#여러조건 중 하나 이상 충족
exam %>%
  filter(math >=90 | english >= 90)

# %in% 부호는 해당변수값들에 or개념으로 있는지 확인하여 출력하여 준다.
exam %>% 
  filter(class %in% c(1,5))

#필요한 변수만 추출하기
exam %>% 
  select(math)

exam %>% 
  select(class,math,english)

#함수 조합하기
exam %>% 
  select(id,math) %>% 
  head(10)

#순서대로 정렬하기
#오름차순
exam %>% 
  arrange(math)

#내림차순
exam %>% 
  arrange(desc(math))

#여러변수를 기준 오름차순 정렬
#먼저 class로 오름차순하고 class의 같은 값안에서 또 math로 오름차순 정리
exam %>% 
  arrange(class,math) %>% 
  haed(5)

#5 파생변수 추가하기
exam %>% 
  mutate(total = math+english+science)

#파생변수 한꺼번에 추가하기 추가는 하지만 데이터 프레임의 변수로 직접저장은 x

exam %>% 
  mutate(total = math+english+science,
         mean = total/3)

#아래는 직접 데이터프레임에 추가 됩니다.
exam$total <- exam$math + exam$english
exam


#mutate안에 ifelse문 삽입(삼항연산사)
exam %>% 
  mutate(test = ifelse(science >=60, "pass","fail"))

#추가한 변수를 dplyr코드에 바로 적용하기
exam %>% 
  mutate(total = math+english+science) %>% 
  arrange(total)

# 집단별로 요약하기

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

#각 집단별로 다시 집단 나누기

mpg <- as.data.frame(ggplot2::mpg)

mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_cty = mean(cty))

#7 데이터 합치기

#가로로 합치기
total <- left_join(test1, test2, by = "id")
total

#세로로 합치기

group_all <- bind_rows(group_a,group_b)
group_all


