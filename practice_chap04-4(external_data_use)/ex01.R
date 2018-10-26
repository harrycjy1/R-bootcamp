
#외부 데이터를 불러오는 법을 습득하도록 합니다.
#해당 프로젝트 폴더에 git에 가서 필요한 파일을 다운로드하여 저장합니다

#연속 변수, 범주변수
#연속 변수(성적,값 등)
 a <-factor(c(10,20,30,10,20,10,20,30,30))
 b <- c(10,20,30,10,40,10,20,30,30,30,40,10)

 a+10
b+10



#excel파일을 r로 가져오기 위해 패키지 reaxl을 install합니다
install.packages("readxl")
library(readxl)

#readxl 패키지에 있는 read_excel()함수를 이용해서 excel파일을 불러올수 있습니다.
#df_exam데이터프레임변수에 excel_exam.xlsx파일의 내용을 데이터 프레임 형식으로 저장

df_exam <- read_excel("excel_exam.xlsx") #같은 프로젝트 폴더에있다면 파일명 아니면 절대경로를 적어라

df_exam
View(df_exam)
View(head(df_exam))
tail(df_exam)

#데이터 프레임의 행과 열의 숫자를 볼수 있게 해주는 함수.
dim(df_exam)

mean(df_exam$english)
mean(df_exam$science)

#통상 read_excel()함수는 첫번째 행을 컬럼명(속성)으로 인식해서 불러옵니다.
#하지만 컬럼명 없이 데이터가 바로 첫 행부터 존재한다면 첫번재 행은 컬럼명으로 지정되어
#1행이 데이터 누실된다. 이때 col_name이라는 read_excel()함수의 인자값을 설정하면 문제점이 해결
#자, 아래와 같이 읽어들이니 첫번재 행이 컬럼값으로 나온다.

df_exam_novar <- read_excel("excel_exam_novar.xlsx")
df_exam_novar

#col_names라는 read_excel()함수의 인자값을 설정하였습니다.
#여기서 False는 거짓이라는 논리형 벡터 변수입니다.
#프로그래밍언어에서 배웠듯 boolean타입과 같다고 보면 됩니다. 단 대문자로 작성
#F라고 써도 무방
df_exam_novar <- read_excel("excel_exam_novar.xlsx",col_names = FALSE)
df_exam_novar

#excel파일에는 여러개의 sheet가 존재 sheet별로 불러올수도 있습니다.
#이 때, sheet라는 인자값을 사용하면 됩니다.

df_exam_sheet <- read_excel("excel_exam_sheet.xlsx",sheet = 3)
df_exam_sheet


#범용 데이터 파일로 많이 쓰이는 확장자가 csv(comma-seperated values)인 파일을 많이 보았을 
#것이다 csv파일을 읽어오기 위해서는 read.csv()함수를 사용하면 된다.

df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam

#문자가 들어있는 csv파일을 불러올때는 아래와 같이 stringAsFactor를 설정하자
df_exam_csv <- read.csv("csv_exam.csv", stringsAsFactors = FALSE)


#이제는 R에서 만든 dataFrame을 csv파일로 만드는 것을 알아보도록 합시다.
df_midterm <- data.frame(english=c(90,80,60,70),
                         math = c(10,55,33,70),
                         class = c(1,1,2,2)
                         )

df_midterm

#R의 기본 내장함수인 wirte.csv()의 file인자값을 이요하여 코딩하면 파일로 내보내어진다.
write.csv(df_midterm, file = "df_midterm.csv")


#Rdata파일 활용하기
#Rdata(.rda or .rdatag확장자)는 R전용 데이터 파일이다. 하여 다른파일에 비해 R에서 읽고 쓴느 속도가
#빠르고 용량이 작다는 장점이 있다 R을 사용하는 사용자와 작업시에는 Rdata파일을 이용하는게 좋고,
#그게 아니라면 csv파일을 사용하자

save(df_midterm, file = "df_midterm.rda")



#x<-15
#rm()내장함수는 변수를 삭제할수 있다.
rm(df_midterm)
#rm(x)

df_midterm

#이제는 앞서 저장한 R파일을 불러오도록 하자 .load()함수를 이용하면 된다.
#다시 DAta탭을 보면 df_midterm()이 목록에 보인다.
load("df_midterm.rda")
df_midterm

#기억할 사항은 read.csv()나 read_excel()함수는 파일을 불러와서 또 다른 변수에 할당해야
#하는 작업이 생기나, load()함수는 저장할 당시에 데이터프레임형태로 바로 가져오기 때문에
#새로운 변수를 지정할 번거로움을 제거해준다는 장점이 있다는 것이다.









