
#이제 데이터 프ㅔ임으 내용을 집단별로 구분하여 요약한 값을 구하는 방법에 대해서 알아봅니다.
#group_by() 함수와 summarise()함수의 사용법에 대해서 알아봅니다.

exam <- read.csv("csv_exam.csv")
exam
View(exam)

library(dplyr)

#아래 2개의 함수의 차이점을 보면 summarise()는 math변수의 데이터를 핪나하여 평균치 하나만
#출력하지만 
#mutate()는 math데이터의 평균치를 구하는 것은 동일하지만 각 행에 다 적용이 되어
#출력

 #하여 summarise()는 요약할때, group_by(함수오 병행해서 사용합니다.

exam %>% summarise(mean_math = mean(math))
exam %>% mutate(mean_math = mean(math))

#집단별로 요약하기
#아래 결과를 보면 class를 그룹별로 나누고 난후, math의 평균을 mean_math변수에 할당하여
#출력해준다. tibble은 dataframe의 상위버전이고 몇가지 기능만 더 추가된 것으로 이해하도ㅗㄱ 하자
#활용 형태는 datatframe과 동일

#int는 정수이고 dbl은 double의 약자

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

#여러 요약 통계량 한번에 산출하기
#1개의 데이터를 추가해보았습니다.
#출력결과는 math의 평균, 합계, 중앙값 그리고 n()은 count와 유사한 함수인 빈도수를 구하는 것
#즉 n()함수는 행의 갯수를 구하는 것입니다.

exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math),
            sum_math=sum(math),
            median_math = median(math),
            n=n()
            )

mpg <- as.data.frame(ggplot2::mpg)
mpg

#아래와 같이 mpg데이터를 가지고 group_by를 하는데 이자값이 두개 들어가게 되면
#먼저 첫번째 인자로 분류하고 나서 두번째 인자로 그 평균값을 구하게됩니다.
#즉, 다시말하면 상위집단에서 하위집단으로 나뉘는 겁니다.

mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer) %>%                   #일단 제조사 별로 분리하고
  filter(class=="suv") %>%                    #제조사로 분리한 것에서 suv만 추출
  mutate(tot = (cty+hwy)/2) %>%               #통합연비 변수를 생성
  summarise(mean_tot = mean(tot)) %>%         #통합연비의 평균을 구함 
  arrange(desc(mean_tot)) %>%                 #내림차순 정ㄹ
  head(5)


top_5 <- mpg %>% 
  group_by(manufacturer) %>%                   #일단 제조사 별로 분리하고
  filter(class=="suv") %>%                    #제조사로 분리한 것에서 suv만 추출
  mutate(tot = (cty+hwy)/2) %>%               #통합연비 변수를 생성
  summarise(mean_tot = mean(tot)) %>%         #통합연비의 평균을 구함 
  arrange(desc(mean_tot)) %>%                 #내림차순 정ㄹ
  head(5)

top_5

height <- as.numeric(top_5$mean_tot)
name <- as.character(top_5$manufacturer)

barplot(height, names.arg = name, main = "제조사별 통합연비", col =rainbow(length(height)),
        xlab = "제조사", ylab="통합연비", ylim = c(0,25))
