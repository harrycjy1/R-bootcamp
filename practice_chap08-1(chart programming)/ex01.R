
# R틀을 이용하여 차트를 그려보자

#pie()
# 패키지 : graphics
# 사용법 : pie(x, labels, clockwise, init, angle, col, main)
#설명 : 파이차트 출력

#매개변수
# x : 음수가 아닌 수치벡터(부채꼴의 크기로 표현)
# labels : 부채꼴에 대응하는 이름.
#clockwise : 부채꼴(x)의 출력방향, 디폴트는 FALSE로 반시계방향
#init.angle : 디폴트는 3시방향에서 부채꼴 출력
#col : 색깔
# main : 그래프에 대한 전체 제목

#단순 파이차트
# 차트 생성하기 위해 벡터 값 생성
x <- c(9,15,20,6)
label <- c("영업1팀","영업 2팀","영업 3팀","영업 4팀")
#파이차트 출력
pie(x,labels = label, main = "부서별 영업 실적")

#기준선 변경
# init.angle = 90은 기준선을 수직으로 설정하겠다 라는 것
pie(x,init.angle = 90, labels = label, main = "부서별 영업 실적")

#색과 라벨 수정
pct <- round(x/sum(x)*100) #각 항목의 비율 구함
pct

label <- paste(label,pct) # label에다 pct붙임
label <- paste(label,"%") # label에다 %붙임
pie(x, labels = label,init.angle = 90,col=rainbow(length(x)), main = "부서별 영업 실적")

#3D 파이 차트
install.packages("plotrix")
library(plotrix)
pie3D(x, labels=label, explode = 0.1, labelcex = 0.8, main ="부서별 영업 실적")



#기본 바 차트 출력

#barplot()
#패키지 : graphics
#사용법 : barplot(height, width, names.arg, horiz, col, main, sub, xlab, ylab, slim, ylim)
#설명 : 수평 수직의 막대그래프 출력

#매개변수
#height : 막대의 크기를 나타내는 벡터
#width : 막대의 너비
# names.arg: 각 막대 아래 출력될 이름에 대한 벡터
#horiz: 수직, 수평설정
#col: 막대에대한 색, 디폴트는 회색
#main : 제목
#sub : 막대그래프에 대한 부제
#xlab,ylab : x,y축 라벨
#xlim, ylim : x,y축 크기

height <- c(9,15,20,6)
name <- c("영업1팀","영업 2팀","영업 3팀","영업 4팀")
barplot(height, names.arg = name, main = "부서별 영업 실적")

#막대의 색 지정
barplot(height, names.arg = name, main = "부서별 영업 실적",col=rainbow(length(height)))

#x, y 축의 라벨과 크기
#col = rainbow(length(height)) : 막대 그래프의 막대 색을 부서의 수만큼 무지개 색으로 설정
barplot(height, names.arg = name, main = "부서별 영업 실적",col=rainbow(length(height)), xlab="부서",ylab="영업실적(억 원)",ylim=c(0,25))

#데이터 라벨 출력
bp <- barplot(height, names.arg = name, main = "부서별 영업 실적",col=rainbow(length(height)), xlab="부서",ylab="영업실적(억 원)",ylim=c(0,25))

#그래프 각 막대의 문자데이터 추가, labels는 문자, pos는 문자의 상대적 위치값
#pos가 1이면 막대끝 선의 아래쪽
#pos가 2이면 막대끝 선의 왼쪽,
#pos가 3이면 막대끝 선의 위쪽
#pos가 4이면 막대긑 선의 오른쪽

text(x=bp, y=height, labels = round(height,0),pos=3)
bp <- barplot(height, names.arg = name, main = "부서별 영업 실적",col=rainbow(length(height)), xlab="부서",ylab="영업실적(억 원)",ylim=c(0,25))

text(x=bp, y=height, labels = round(height,0),pos=1)

#바 차트의 수평 회전(가로 막대)
#horiz = True 는 수평으로 나타내어라
barplot(height, names.arg = name, main="부서별 영업실적",col=rainbow(length(height)),xlab="영업 실적(억 원)",ylab="부서",horiz=T,width=50)


#스택형 바 차트(Stacked bar Chart)
height1 <- c(4,18,5,8)
height2 <- c(9,15,20,6)

#행으로 합침(matrix)
height <- rbind(height1,height2)

height
class(height)

name <- c("영업1팀","영업 2팀","영업 3팀","영업 4팀")
legend_lbl <- c("2014년","2015년") #범례 만들기

barplot(height, main="부서별 영업실적", names.arg = name, xlab="부서",ylab="영업 실적(억 원)",
        col = c("darkblue","red"),#그룹별 색
        legend.text=legend_lbl,#그룹별 라벨
        ylim=c(0,35))


#그룹형 바 차트(Grouped Bar chart)
barplot(height, main="부서별 영업 실적",
        names.arg = name,
        xlab="부서",ylab = "영업 실적(억 원)",
        col = c("darkblue","red"),
        legend.text=legend_lbl,
        ylim = c(0,30),
        beside=T, #막대들을 옆으로 배치
        args.legend=list(x="top"))



#일반적인 X-Y플로팅
data(women)
View(women)
class(women)

# women의 weight를 벡터로 추출
weight <-women$weight * 0.45 #kg으로 단위 전환
height <-women$height * 2.54 #cm로 단위 전환


class(weight) #numeric타입
weight

#plot()
#패키지 : graphics
#사용법 : plot(x,y,....)
#설명 : R객체의 그래프 출력을 위한 일반적인 기능제공

#매개변수
# x : x좌표값
# y : y좌표값

#plot그래프 그리기
plot(weight)


plot(height,weight,xlab = "키",ylab="몸무게",xlim=c(140,190),ylim=c(50,80))

#플로팅 문자의 출력
# type이 "p"이면 점, type이 "l"이면 선
# type = "b"이면 점과선, type이 "o"이면 점위의 선
# type ="s"이면 계단
plot(height, weight, xlab = "키",ylab = "몸무게",col="blue",type="o")

#지진의 강도에 대한 히스토그램
#quakes는 내장 데이터 세트임
head(quakes)
class(quakes)
View(quakes)


#mag는 지진 가도 데이터임
mag <- quakes$mag
mag


#hist()
#패키지 ; graphics
#사용법 : hist(x,breaks,freq,probability,main,xlim,xlab,col)
#설명 : 히스토그램을 출력하는 일반적인 기능제공

#매개변수 
# x : 히스토그램을 위한 벡터데이터
# breaks : 계급구간의 수
# freq : TRUE는 빈도수
# probability : freq값의 반대
# main : 제목
# xlim,,ylim : x,y의 크기
# col : 계급들의 색


hist(mag,main="지진 바생 강도의 분포",xlab = "지진 강도",ylab="발생 건수")

#계급 구간과 색
colors <- c("red","orange","yellow","green","blue","navy","violet")
hist(mag, main = "지진 발생 강도의 분포", xlab = "지진수 강도",ylab = "발생 건수",
     col = colors, breaks=seq(4, 6.5, by=0.5))

#선표시
lines(density(mag))


#박스 플롯
#boxplot()
#패키지 : graphics
#사용법 : boxplot(x,...)
#설명 : 박스플롯의 일반적인 기능 제공

#매개변수
# x: 박스플롯을 위한 벡터데이터
mag <- quakes$mag
min(mag)
max(mag)
median(mag)
quantile(mag,c(0.25,0.5,0.75))
boxplot(mag, main="지진 발생 강도의 분포", xlab="지진", ylab="발생 건수",col="red")


# 과제 CDNow거래 데이터의 차트 출력과 분포 파악
# CDNow는 1992년도에 설립된 닷캄의 대표적인 온라인 유통회사로서, 2002년도에 아마존에
# 매각되었다. 1997년 1월부터 1998년 6월까지의 6,919건의 거래에서 각 거래별 CD판매량(cds)에 대해 분석해보자ㅣ
# 데이터 소스 : http://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv

url <- "http://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv"
data <- read.csv(url,header=T)
dim(data)
head(data)
class(data)

#문제 1. 거래량(cds)에 대한 빈도수(table()를 이용)를 히스토그램으로 출력
#문제 2. 거래량에 대한 빈도수를 박스플롯으로 출력
#문제 3. 거래량에 대한 빈도수를 막대그래프로 출력

table(data$cds)

data1 <- (data$cds)

head(data1,10)
table(data1)

#1
hist(data1, xlab ="주문 당 CD거래량", ylab = "빈도수",breaks=seq(0, 40, by=1))

#2
boxplot(data1,main="시디 판매 갯수에 대한 빈도수")

#3
barplot(table(data1),main="시디 판매 갯수에 대한 빈도수")



