
# 데이터 프레임이란? 다시말해 표와같은 형태로 데이터가 존재하는 것이라고 보면 이해가 빠름
# 혹시 DB를 조금이라도 다루어 보았다면 테이블과 같다고 생각하면 도니다.
# 표 혹은 테이블은 열과행으로 이루어 진다.
# 하여, 행이 많아지는 것과 열이 많아지는 것은 데이터분석적인 측면에서 완전 달라지는 것이다.
# 데이터의 행이 많아진다는것은 분석기법은 변하지 않는다 다만 속도가 느려질뿐(데이터가 많아진다는 뜻)
# 하지만, 열(column)이 많아지는 것은 데이터 분석 기법이 달라진다.
# 그래서 데이터 분석에 잇어서는 행(row)보다는 열(column)이 더욱더 중요한 부분을 차지

english <- c(90,80,60,70)
english
math<-c(50,60,100,20)
math

# 아래 코드 내용은 data.frame()함수를 이용하여 위에 선언한 변수들을 인자값으로 하여
# 표와 같이 즉 데이터프레임을 만들고 잇다. 그리고 타 변수와 구별하기 위해 약자로 df를
# 접두어로 넣어주면 나중에 구분하기 편하다.

df_midterm <- data.frame(english,math)
df_midterm

class <- c(1,2,3,4)
class

df_midterm<- data.frame(class,english,math)
df_midterm


#$기호가 나오는데 이 기호는 데이터프레임 안에 있는 열(속성(컬럼))를 지정할 때 사용함
es <- sum(df_midterm$english)
ms <- sum(df_midterm$math)
em <- mean(df_midterm$english)

df_midterm <- data.frame(english = c(90,80,60,70,es),
                         math=c(50,60,100,20,ms),
                         class =c(1,1,2,2,"합"))
                         
df_midterm
