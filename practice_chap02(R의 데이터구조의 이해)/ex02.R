
#배열(array)은 한개 이상의 벡터로 구성되며, 동일한 데이터 유형을 가진다.
#배열을 마들기 위해서 사용하는 함수가 array()이다

#array()
#패키지 : base
#사용법 : array(data, dim, [dimnames])
#설명 : 배열생성
# 반환값 : 배열


#매개변수
#data : 벡터자료
#dim : 차원을 나타내는 벡터
#dimnames : 각 차원의 이름을 나타내는 백터

#1~3까지의 정수를 1행 3열로 표시, 1차원 배열임
x <- array(1:3, dim=c(3))
x
class(x)

#2차원 배열 만들기
x <- array(c(1:6), dim = c(2,3))
x

x<- array(seq(2,12,by=2),dim=c(2,3))
x

#2차워 배열의 요소 값 보기 및 수정
x[1,3] # 1행 3열의 값

x[,3] #3열의 모든 값
x[,-3]#3열 제외한 모든ㄱ값

x[1,2] <- 20
x


#행과 열에 이름 추가
#행과 열 이름을 갖는 두 벡터로 하는 리스트 생성
names <- list(c("1행","2행"),c("1열","2열","3열"))

x <- array(c(2,4,6,8,10,12), dim = c(2,3))
x

#dimnames추가
x <- array(c(2,4,6,8,10,12), dim =c(2,3), dimnames = names)
x

# "1행"이라는 이름을 갖는 행의 모든 값 출력
x["1행",]
# "2열"이라는 이름을 갖는 열의 모든 값 출력
x[,"2열"]

#3차원 배열 만들기
x <- array(c(1:24), dim = c(2,3,4))
x
