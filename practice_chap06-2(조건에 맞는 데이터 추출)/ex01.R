
# 우선 데이터를 분석하기 위해서는 데이터를 자유자재로 다룰 수 있어야합니다.
#추출, 종류 별로 나누거나 여러 데이터들을 합치는 작업등을 말합니다.
#이러한 것을 데이터 전처기(data prerprocessing)이라고 하며, 비슷한 말로 데이터 가공(data manupulation),
#데이터 핸들링(data handling), 데이터 랭글링(data wrangling)이라고도 불립니다.
#데이터 전처리 작업을 할 때 가장 많이 사용하는 패키지는 바로 dplyr패키지입니다.

#우선 filter함수에 대해서 알아봅니다.
#filter()함수는 dplyr패키지에 있는 함수로 원하는 데이터를 추출할 때 쓰이는 함수입니다.

library(dplyr)

exam <- read.csv("csv_exam.csv")
exam
View(exam)

#데이터를 확인해보면 5개의 클래스로 구성되어진것을 알수 있습니다.
#1 class만 추출해보겠습니다

exam %>% filter(class==1)

#위에서 %>% 표식은 dplyr패키지에 존재합니다, %>% 는 파이프 연산자라고도 하며, 함수들을 연결하는 기능을 하고, 단축키는 ctrl shift m 입니다.

#2 class만 추철
exam %>% filter(class==2)

exam %>% filter(class!=1)

exam %>% filter(class!=3)

#이제는 부등호를 사용해서 초과, 미만 이상 이하의 조건을 걸어보자

exam %>% filter(math >50)

exam %>% filter(math<50)

#영어점수 80이상

exam %>% filter(exam$english >= 80)  #변수 exam$를 사용하지 않아도 됨
exam %>% filter(english >=80)

exam %>% filter(english <= 80)

#1반이면서 수학점수가 50점 이상
#두개의 조건을 다 만족해야 결과가 출력되는 것은 연산자 %를 사용, 하나만 만족해도 출력하고자
#한다면 |를 사용합니다.

exam %>% filter(class==1 & math >=50)

exam %>% filter(class==2 & english>=80)

exam %>% filter(math>=90 & english >=90)

#영어점수가 90점 미만이거나 과학점수가 50점 미만인 경우
exam %>% filter(english <90 | science <50)

exam %>% filter(english <90)

exam %>% filter(english >=90 & science >=50)

#class가 1,3,5만 추출하고자 할때
exam %>% filter(class==1|class==3|class==5)

#또 다른 방법으로 매치연산자(match operator)인 %in%를 사용해도 좋다
exam %>% filter(class %in% c(1,3,5))

#추출한 행으로 데이터로 만들수 있습니다.
class1 <- exam %>% filter(class ==1)
class1

class2 <- exam %>% filter(class==2)

#1반 , 2반의 수학평균
mean(class1$math)
mean(class2$math)












