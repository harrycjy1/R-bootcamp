
#변수를 이용해 파생변수를 만들수도 있지만, 조건문함수를 이용해서도 만들수 있는법을 배워봅니다.

#기준값을 정하기 위해서 합격여부를 지을수 있는 내용은 중앙값과 평균이 될것입니다.
summary(mpg$total)

#히스토그램으로 연비의 빈도를 연비로 볼수있습니다.
#히스토그램으로 보면 20~25에 데이터가 많이 분포되어 있고 또한 연비의
#중앙값과 평균이 약 20정도로 보면 될것입니다. 하여 기준을 20으로 잡자
hist(mpg$total)

#mpg$test파생변수에 total(통합연비)값이 20이상이면 합격, 이하면 불합격을 저장

mpg$test <- ifelse(mpg$total >= 20, "pass","fail")
head(mpg,20)

#합격과 불합격의 데이터 빈도수를 쉽게 알수 있는 함수 table()을 사용해봅니다.
#합격이 128이고 불합격이 106임을 알수 있습니다.
table(mpg$test)

#이 수치를 그래프화 하면 한눈에 들어올 것입니다.
library(ggplot2)
qplot(mpg$test)

#중첩조건을 이용해서 좀더 데이터를 구체적으로 분석해봅시다.
#grade변수를 생성하는데 total값이 30이상이면 A이고, 20~29.9999tkdlsms B 그이하는 C
mpg$grade2 <- ifelse(mpg$total >=30,"A",
                     ifelse(mpg$total>=25,"B",
                            ifelse(mpg$total >=20,"C","D")
                            )
                     )

table(mpg$grade2)
qplot(mpg$grade2)
