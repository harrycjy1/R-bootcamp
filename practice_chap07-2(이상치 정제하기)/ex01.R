#outlier 이상치

# outlier 변수에는 데이터프레임 2개 존재
#sex에는 1,2 score는 1~5
#하지만 3,6 이상치 존재
outlier <- data.frame(sex=c(1,2,1,3,2,1),
                      score=c(5,4,3,4,2,6)
)

outlier

library(dplyr)

table(outlier$sex)
table(outlier$score)

# ifelse()를 이용해서 결측치로 변경하여 NA를 부여
#sex가 3이면 NA를 할당
outlier$sex <- ifelse(outlier$sex ==3, NA, outlier$sex)
outlier

#위와 똑같은 방법으로 score에도 NA를 할당
outlier$score <- ifelse(outlier$score >5, NA, outlier$score)
outlier

#이제 이상치를 결측치로 변경했으니, 분석할 때 결측치 제외하고 
#filter()를 이용해 남녀별로 score를 구해보자. 
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

#그리고 논리적으로 존재할 수 있지만 극단적으로 크기가 작은 값을 
#극단치라고 한다. 몸무게가 200KG이라면 존재할 수는 있지만 
#상대적으로 굉장히 드문 경우에 해당.
#극단치 역시 분석결과를 왜곡할 수 있으므로 분석하기전에는 제거를 해야한다.
#통계적으로 상하위 0.3%또느 +-3표준편차에 해당할 만큼 극단적으로 
#크기가 작으면 극단치로 간주 
#또는 boxplot을 이용해 중심에서 크게 벗어난 값을 극단치로 볼수도 있다.

library(ggplot2)
mpg<-as.data.frame(ggplot2 :: mpg)
boxplot(mpg$hwy)
mpg
View(mpg)

#아래 결과를 분석해보면 1인덱스는 아래쪽 극단치 경계, 2번째 인덱스는 
#1사분위수, 3번째 인덱스는 중앙값, 4번째 인덱스는 3사분위수, 5번째 인덱스는 
#극단치 경계를 의미한다. 이런 분석을 통해 12~37을 벗어나면
#통상 극단치로 분류한다.
boxplot(mpg$hwy)$stats

#극단치를 결측치로 대체 
#대체된건 3개
mpg$hwy <- ifelse(mpg$hwy <12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

#이제 결측치로 대체가 되었으니 결측치를 제외하고 hwy의 평균을 구해보자 
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy,na.rm=T))

View(mpg)

#결측치 정제를 위해 결측치 확인
table(is.na(df$score))

#결측치 제거 
df_nomiss <- df %>% filter(!is.na(score))

#여러 변수 동시에 결측치 제거 
df_nomiss <- df %>%  filter(!is.na(score) & !is.na(sex))

#함수의 결측치 제외 기능 
mean(df$score, na.rm = T)
exam %>% summarise(mean_math=mean(math,na.rm=T))

#2.이상치 정제하기
#이상치 확인
table(outlier$sex)

#결측 처리 
outlier$sex <- ifelse(outlier$sex ==3, NA, outlier$sex)

#boxplot으로 극단치 기준 찾기
boxplot(mpg$hwy)$stats

#극단치 결측 처리
mpg$hwy <- ifelse(mpg$hwy<12 | mpg$hwy > 37, NA, mpg$hwy)