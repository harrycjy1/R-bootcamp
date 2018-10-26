
#이번장에서는 앞서 좀 다루었던 파생변수를 함수를 통해 추가하는 방법을 알아봅니다.
#앞서 다룰 때에는 $를 이용해서 데이터프레임에 파생변수를 만들었지만
#코드량이 길어 질때는 이장에서 공부하는 mutate()함수를 적절히 이용하면 편리합니다.

exam <- read.csv("csv_exam.csv")
library(dplyr)
exam

# exam 에 있는 변수의 값들을 다 더하는 총합 변수를 추가해보도록 하겠습니다.
# 앞서 배운 방법
exam$total = exam$math+exam$english + exam$science
exam

#mutate()함수 이용방법
exam<-exam %>% 
  mutate(total= math + english+science,
         mean = (math+english+science)/3.0)


# mutate()에 조건문 적용하기
exam %>% mutate(test = ifelse(science >=60 ,"pass","fail")) %>% 
  head()

exam %>% 
  mutate(total = math+english+science) %>% 
  arrange(total) %>% #성적 기준으로 오름차순
  head()
