
#변수 x만들고 데이터 저장
x <- c(1,2,3)
x

#mean()함수는 인자값(매개변수, parameter)의 평균을 구하는 함수이다
#함수라는 개념은 중요 함수는 변수와 다르게 항상 뒤에 () 가 붙는다 꼭 기억하자

mean(x)

#최대값 구하기
max(x)

#최소값 구하기
min(x)

#문자나 문자열을 다루는 함수 예제

#변수 Str에 문자열을 가지는 값을 저장함
str5<- c("hello","world","is","good")
str5

#paste()함수는 인자값을 가지고 문자나 문자열을 합치는 함수이다
#여기서 collapse는 함수의 인자값이다 무엇이든 인자값을 통해서 결과를 바꿀 수 있다.

paste(str5,collapse=",") #좌측은 str5에 있는 문자열을 쉼표를 구분자로하여 붙이라는 명령

#함수의 결과물을 또다른 변수에 저장할 수 있습니다. 이것을 리턴값이라고도 합니다
x_mean <- mean(x)
x_mean

#인자값을 "/"로 주었다.
str5_paste <- paste(str5, collapse = "/")
str5_paste