
#파생변수라고 하는 것은 기존의 변수를 활용 및 가공을 통해 새로 생성되는 변수를 말합니다.

#데이터 프레임 생성
df <- data.frame(var1 = c(4,3,1),
                 var2 = c(2,6,1)
                 )
df

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- df$var_sum/2
df

library(ggplot2)

#mpg 데이터프레임의 cty와 hwy를 이용해서 도시연비와 고속도로 연비의 평균을 구함으로써 통합연비 total파생변수를 만들고 있습니다.

mpg <- as.data.frame(ggplot2::mpg)
mpg

mpg$total<- (mpg$cty+mpg$hwy)/2.0

#통합연비를 구해봅니다.
mean(mpg$total)
