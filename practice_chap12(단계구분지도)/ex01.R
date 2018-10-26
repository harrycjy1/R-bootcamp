# 지역별로 통계치를 나타낼 때, 색깔의 차이로 표현한 지도를 단계구분도라고 한다.
#단계구분도를 보면 인구나 소득 같은 특성이 지역별로 얼마나 다른지 한눈에 알 수 가 있다.
#미국 주별 강력 범죄율 데이터를 이용해서 단계 구분도를 만들어보자.

# 패키지 준비하기
install.packages("ggiraphExtra") #단계구분도를 그리기 위해서 패키지를 설치
library(ggiraphExtra)
#미국 주별 범죄 데이터 준비하기
# R에 내장된 데이터셋인 USArrests는 1973년 미국 주 (state)별 강력 범죄율 정보를 담고 있다.

str(USArrests)
head(USArrests)
library(tibble)

#행 이름을 state변수로 바꿔 데이터 프레임 생성
crime<-rownames_to_column(USArrests,var="state")
crime

#지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <-tolower(crime$state)
crime
str(crime)

#미국 주 지도 데이터 준비하기
library(ggplot2)

#R에 내장된 maps패키지에 미국 주별 위경도를 나타낸 state데이터가 있다.
#이것을 ggplot2패키지의 map_data()를 이용해서 데이터 프레임 형태로 불러온다.
states_map<-map_data("state")
str(states_map)

#지도에 표현할 범죄 데이터의 배경이 될 지도 데이터가 준비되었으니 ggiraphExtra
#패키지의 ggChoropleth()를 이용해서 단계 구분도를 만들어본다.
# 단계 구분도 만들기
ggChoropleth(data=crime, #지도에 표현할 데이터
             aes(fill=Murder, #색깔로 표현할 변수
                 map_id=state), #지역 기준 변수
             map=states_map)


#인터렉티브 단계 구분도 만들기
ggChoropleth(data=crime,                 #지도에 표현할 데이터
             aes(fill=Murder,           #색깔로 표현할 변수
                 map_id=state),         #지역 기준 변수
             map=states_map,            #지도 데이터
             interactive=TRUE)          #인터렉티브 합성


#Viewer 창에서 export->save as Wep Page...를 클릭하면 HTML 포맷으로
#저장할 수 있다. 마우스휠로 특정영역을 확대 축소가 가능
#크롬으로 열면 깨질수도 있으니 인터넷 웹브라우져로 열자.