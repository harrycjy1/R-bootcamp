
#함수를 앞서 배웠다. 여기서는 패키지에 대해서 알아보는데, 쉽게 생각해라

#패키지는 ㅎ마수들을 모아놓은 꾸러미라고 생각하면 이해하기 쉬울것이다.

#데이터를 그래프로 표현하는 작업을 할 때 가장많이 쓰는 패키지인 ggplot2 인스톨함
install.packages("ggplot2")

library(ggplot2)

#변수 저장
x<-c("a","b","c","d")
#x <- c("a","b","c","d","a")
x

#qplot()는 인자값으 빈도수를 그래프로 보여주는 함수이다.
qplot(x)

#아래 내용의 mpg(Mile per Gallon)라는 것은 미국에서 그냥 공개한 데이터이다
#여기서는 앞서 말했듯 인자값이 어떻게 변하느냐에 따라 기능이 달라진다는 것을 확인하고 인지하면 된다
#자세한건 뒤에서

qplot(data = mpg, x=hwy)

qplot(data = mpg, x = cty)

#x축을 drv, y축을 hwy로 설정
qplot(data = mpg, x = drv, y = hwy)

#선으로 보이기
qplot(data = mpg, x = drv, y = hwy,geom = "line")

#박스로 보이기 #색상변경
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

?qplot




