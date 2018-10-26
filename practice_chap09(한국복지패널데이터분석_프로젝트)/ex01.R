#'9장 데이터 분석 프로젝트- '한국인의 삶을 파악하라'
#'9-1장 한국복지패널데이터 분석 준비하기

#'지금까지 데이터의 분석 기술을 익혀보았다. 이제배운
#'분석기술로 데이터를 분석해 보도록 하자. 먼저 한국복지패널 데이터를 
#'이용하여 해보도록 한다. 
#'한국분석복지패널 데이터에는 7000여 가구를 선정하여 
#'2006년 부터 매년 추적 조사한 자료로써 경제활동, 생활실태, 복지욕구 등
#'천여개 변수로 구성되어 있어 데이터 분석하는데 매우 훌룡한 자료이다. 
#'깃허브(bit.ly/doit_rb)에서 "Koweps_hpc10_2015_bera1.sav" 파일을 다운하자
#'foreing패키지는 통계분석 솦프트 웨어인 SPSS전용파일이나
#'SAS, STATA등 다양한 통계분석 소프트웨어 파일을 불러올수 있는 패키지이다. 



library(foreign) #SPSS불러오기
library(dplyr)   #전처리
library(ggplot2) #시각화
library(readxl)  #엑셀파일 불러오기

#'foreign패키지의 read.spss()를 이용해 복지패널 데이터를 불러오자.
#'원본은 복원해야할 상황에 대비하여 그대로 두고 복사본을 만들어 활용한다. 

#'데이터 불러오기 , to.data.frame=T는 SPSS파일을
#'데이터프레임 형태로 변환하느느 기능을 한다 .
#'이 인자값을 주지 않을시 데이터를 리스트 형태로 불러온다. 
raw_welfare <- read.spss(file="Koweps_hpc10_2015_beta1.sav", to.data.frame=T)

#복사본 만들기 
welfare <- raw_welfare

# 개략적인 데이터의 형태
head(welfare)
tail(welfare)
View(welfare) #상당히 많은 데이터이기 때문에 로딩 속도가 좀 걸린다. 
dim(welfare)
str(welfare)
summary(welfare)

# 다운받은 엑셀자료 코드북을 참고해서 분석에 사용할 7개 변수의 이름을 
# 쉬운 변수명으로 바ㅏ꾸자
welfare <- rename(welfare,
                  sex = h10_g3,            #성별
                  birth = h10_g4,          #출생 년도
                  marriage = h10_g10,      #혼인상태
                  religion= h10_g11,       #종교
                  income = p1002_8aq1,     #월급
                  code_job = h10_eco9,     #직업코드
                  code_region = h10_reg7   #지역코드
)
# 자, 이렇게 하면 데이터 분석의 필요한 준비 즉, 수집은 끝났습니다. 



#############################################################################################

# 9-2장 성별에 따른 월급 차이 - "성별에 따라 월급이 다를까?"
#'9-1장에서 수집한 데이터를 근거로 하여 성별에 따라 월급이 차이가 있는지 한번 살펴보자
#'그럼 먼저 볼 변수는 바로 성별, 월급 변숙 될 것이다. 
#'
#'성별의 변수타입을 보니 numeri이다. numeric은 범주변수에 속하기 때문에 
#'사칙연산 등이 되는 변수가 아니가. 
#'class()는 변수의 타입을 알아보는 함수이다. 
class(welfare$sex)

#'이제 sex변수는 분명 1,2가 들어있을 텐데 그 범주안에 얼마나 속하는지
#'확인해 보자
table(welfare$sex)

#'이제 전처리를 해야된댜. 즉, 이상치를 알아내어 제거를 해야 그 변수의 
#'분석에 영향을 끼치지 아니한다. 
#'일단 엑셀로 다운받은 코드북을 보면 성별에서 1이면 남자, 2이면 여자로 
#'된다는 것을 알수 있다. 모른다고 답을 하거나 응답하지 않은 사람은 9로 되어 있다라고 나온다.
#'이 정보를 토대로 9의값을 NA로 설정하자
#'왜 제거해야하니까....
table(welfare$sex)
#'그러나 확인해보니 sex변수에는 이상치가 없다. 없기 때문에 이상치를 
#'결측처리하는 절차는 없어도 된다. 하지만 만약 이상치가 발생한다면 
#'앞서 배운듯이 아래와 같이 진행하고 결측치 확인을 해보면 됫 것이다. 
#'
#'이상치 결측처리
welfare$sex <- ifelse(welfare$sex ==9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

#하지만 교재에 따라 male, female로 설정하자.
welfare$sex <- ifelse(welfare$sex ==1, "male","female")
table(welfare$sex)

#앞서 배운 변수의 빈도 즉, 값의 개수를 막대의 길이로 표현한 수 있는 
#qplot()을 이용해서 그려보자. 
qplot(welfare$sex)
# 이로써 sex에 대한 전처리는 끝이 났다. 

#'이제 월급에 대하여 전처리를  진행해보자
#'코드북을 보니 월급은 만원단위로 기록되어 있는걸 볼수있다. 
#'income(월급)변수를 검토하고 역시 qplot(0로 분포를 확인해보자
#'앞서 본 성별은 범주변수이기 때문에 table()을 이용래서 빈도나,
#'특징을 알 수 있지만 월급은 연속변수 이므로 table()보다는 summary()
#'를 이용하여 특징을 확인하다
class(welfare$income)

#'income역시 numeric타입이나 연속변수 이므로 사칙연산등이 가능하다. 
#'summary()를 통한 분석을 해보면 0~2400만원 사이로 분포하며, 122~316만원 
#'사이에 가장많이 분포하고 있다. 평균은 241.6만원, 중앙값은 192.5만원으로 전반적으로
#'낮은 값 쪽으로 치우쳐 있다는 것을 파악할 수 있다. 
#'
summary(welfare$income)

# 빈도그래프를 그려봐도 범주가 0~2400으로 설정되어 나오니 보기가 불편...
qplot(welfare$income) + xlim(0,1000)

#코드북을 보면 월급은 1~1900 사이의 값을 지니며, 모름 또는
#무응답은 9999로 되어 있다는 것을 볼 수 있다.
# 아래와 같이 그럼 전처리를 하면 될 것이다.

# 이상치 확인
summary(welfare$income)
#확인하면 곁측치가 12,030 개나 있다. 아마 직업이 없어서 월급을 받지 못한다는 사람 떄문에 결측치가 존재할 것이다.
#월급 변수의 결측치를 제외시켜보자
#0이라는 값도 결측치로 봐야 할 것이다.
#하여0이나 9999를 결측치로 보고 NA처리 하도록 하자

#아래와 값이 2가지 방법중 아무거나 써도 좋으니 1번째 방법을 쓰자.
welfare$income<-
  ifelse(welfare$income %in% c(0,9999),NA,welfare$income)

#결측치 확인
table(is.na(welfare$income))

#이로써 월급에 대한 변수의 전처리도 완료가 되었다.
#이제 sex와 income변수를 이용해서 두 변수의 관계를 분석하자
# 성별 월급 평균표를 만들어 보자
sex_income<-welfare %>% 
  filter(!is.na(income)) %>%           #월급 변수의 NA이가 아닌 것만 추출
  group_by(sex) %>%                    #sex로 그룹됨
  summarise(mean_income=mean(income))  #mean_income에 income의 평균대입

#출력해보자
sex_income
# 여성의 평균월급은 163만원이고, 남자는 112만원임을 볼 수 가 있다.

#그래프로 그려보자
ggplot(data=sex_income, aes(x=sex,y=mean_income))+geom_col()


##########################################################################

# 9-3장 나이와 월급의 관계 -"몇 살때 월급을 가장 많이 받을까?"

# 앞서 워급에 대한 전처리를 했다. 그럼 나이를 저너리하여 보자
class(welfare$birth)
#역시 birth변수는 numeric 연속 변수이다.

summary(welfare$birth)
qplot(welfare$birth)

#코드북을 보니 1990~2014사이의 값을 birth변수는 지니고 있고, 모름/무응답은 9999로 확인이 된다.

#결측치를 확인해보니 결측치가 없다.
table(is.na(welfare$birth))

#결측치가 없으니 그냥 전처리를 진행하면 될 것 같다.

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

# 태어난 연도(birth)변수가 있으니 나이(age)라는 파생변수를 만들어야한다.
# 현재 연도가 2018이니 2018에서 태어난 연도를 빼주고 +1을 하면 나이를 구할 수 있다.
# 책의 내용과 좀 다르다 책은 2015년도에 작성

welfare$age <- 2015 - welfare$birth +1
summary(welfare$age)
qplot(welfare$age)

#이제 나이에 따른 월급의 전처리가 끝이 났다. 그럼 두 변수의 관계를 분석 해보자
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

age_income
View(age_income)

# 그래프를 그리고 분석해보면 20대 초반에 100만원 가량 월급을 받고 증가하면서
# 50대에 300만원 초반 정도 받다가 이후로는 하락추세로 흘러가는 것을 볼수 있다.
# 70대 이후는 20대보다 낮은 월급을 받는 것을 확인할 수가 있다.
ggplot(data = age_income, aes(x = age, y = mean_income))+
  geom_line()

###################################################################################


#9-4장 연령대에 따른 월급 차이 - "어떤 연령대의 월급이 가장 많을까?"

#일단 연령대를 나이(age)변수를 이용해서 파생변수로 만들어 보자

# 파생변수를 만들 때 아래와 같이 2가지 방법이 있다.
# 하지만, mutate()를 이용하는 방법을 이용하자. 왜냐하면 데이터프레임명을 계속 적어주기는 귀찮다.

# welfare$agea <- ifelse(welfare$age <30, "young",
#                       ifelse(welfare$age <= 59, "middle","old"))

welfare <- welfare %>% 
  mutate(ageg = ifelse(age<30, "young",
                       ifelse(age <=59, "middle", "old")))

head(welfare$ageg)

table(welfare$ageg)
qplot(welfare$ageg)

#9-2절에서 월급변수에 대한 전처리를 완료하였으나, 바로 연령대별로 
#평균 월급이 얼마나 다른지 알아보자.

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_ageg_income = mean(income))

# 출력해보니 중년층이 281, 노년층이 150, 젋은층이 140정도 나온다.
ageg_income

ggplot(data = ageg_income, aes(x = ageg, y = mean_ageg_income))+
  geom_col()

#앞선 강의에서도 설명했다시피 ggplot()는 범주내 알파벳순으로 정렬한다.
#하지만, 범주내 변수를 원하는데로 정렬하고 싶다면 scale_x_discrete()를 사용하면된다.

ggplot(data = ageg_income, aes(x = ageg, y = mean_ageg_income))+
  geom_col()+
  scale_x_discrete(limits = c("young","middle","old"))

############################################################################################################3
# 9-5장 연령대 및 성별 월급 차이 - 성별 워급차이는 연령대별로 다를까?
# 앞선 강의에서 성별에 따라 월급 차이를 분석해 보았다. 이번에는 성별 월급차이가
# 연령대에 따라, 어떻게 양상을 보이느지 분석해 보자. 연령대, 성별, 월급 변수는
# 모두 앞에서 전처리를 했으므로 바로 변수간에 관계를 분석해보면 될것이다.

sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income = mean(income))

sex_income

#아래와 같이 출력하여 그래프를 보면 월급이 연령대 막대에 포함되어서
#보기가 애매하다. 이럴때 geom_col()의 인자값으로 position을 주어서
#dodge를 설정하자

ggplot(data = sex_income, aes(x=ageg, y=mean_income, fill=sex))+
  geom_col()+
  scale_x_discrete(limits = c("young","middle","old"))

#이제 그래프를 보면 보기가 좀 편하다.
ggplot(data = sex_income, aes(x=ageg, y=mean_income, fill=sex))+
  geom_col(position = "dodge")+
  scale_x_discrete(limits = c("young","middle","old"))

#아래는 연령대로 구분하지 않고 age(나이),sex(성별)로 월급 평균표를 만들고 있다.
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mean_income = mean(income))

sex_age

# aes의 인자값중 col에 sex를 주어 선그래프를 그리고 있다.
ggplot(data = sex_age, aes(x = age, y = mean_income, col=sex))+
  geom_line()


# 분석을 해보자면 남성은 50대 중반을 기준으로 지속적으로 증가 후 급격한 하락이 진행되지만,
# 여성은 30대 중반을 기점으로 하여 약간 상승곳선을 타다가 지속적으로 완만히 하락한다.
# 성별 월급 격차는 30대 초반부터 지속적으로 50대 중반까지 벌어지다가 이후 줄어들고
# 70대 후반이 되면 비슷하게 되는 경향을 볼 수 있다.

###########################################################################################

# 9-6 직업별 월급 차이 - "어떤 직업이 월급을 가장 많이 받을까?"

# 이번에는 직업별로 월급을 분석해보자. 과연 어떤 직업이 워급을 가장 많이 받는지 분석해보자
# 월급변수(income)는 전처리를 하였으니, 직업변수(code_job)만 전처리를 ㅎ배ㅗ도록 하자

#확인해보니 변수타입은 numeric이며, 직업변수는 직업코드별로 출력이 됩을 알 수 있다.
class(welfare$code_job)
table(welfare$code_job)

#이 코드로는 어떤 직업을 의미하는지 모르기때문에 이코드를 이용하여 직업명칭을 나타내는 변수를 만들어야 할 것이다.
#이전에 받아놓은 koweps_codebook.xls 파일을 해당프로젝트로 옮기자자
library(readxl)
#파일을 읽어오는데 첫번째 행의 값 즉, 컬럼의 이름을 가져오겠다 라는 것이며,
#해당 파일의 2번째 시트를 가져오겠다는 것이다.
list_job <- read_excel("Koweps_Codebook.xlsx",col_names = T, sheet=2)

#출력해보니 해당 code_job에 있는 job이 각각 한글로 표기되어있어 보기 쉽다
list_job
#직업이 149개로 분류가 됨을 알수 있다.
dim(list_job)

head(welfare$code_job)


#아래 2개의 변수의 공통적인 code_job으로 left_join을 이용하여 데이터를 합치면 될 것이다.
View(list_job)
View(welfare$code_job)

welfare <- left_join(welfare, list_job, id="code_job")

# left_join()으로 welfare 데이터프레임에 job변수가 추가됨을 확인할 수 있다.
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

# 아래와 같이 월급을 확인해보니 NA값이 많다 하여 월급변수에 대한 NA값을 제외를 해야 할것이다.
welfare %>% 
  filter(is.na(income)) %>% 
  select(income, job, code_job)

#이제 전처리가 둘다 끝났으니, 직업별 평균 급여를 산출해보자.
job_income <- welfare %>% 
  filter(!is.na(job)& !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

# 직업별 급여를 확인한다.
head(job_income)

#어떤 직업이 월급이 많은지 월급을 내림차순 정렬하여 top10에 저장

top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

#출력해보니 "금속재료 공학기술자" 평균 급여가 845만원으로 제일 많다.
top10

#이제 top10을 이요하여 그래프로 한눈에 파악하도록 하자
#하지만, job의 이름이 길어서 세로로 그래프를 그리게 되면 알아보기 힘드므로 
# 가로그래프를 그려보자
# 여기서, reorder(x축으로 지정할 변수, 정렬기준으로 삼을 변수)가 들어간다.
# 또한 coord_flip()는 그래프를 가로로 출력 즉 오른쪽 90도를 회전하라는 것이다.
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income))+
  geom_col()+
  coord_flip()

#그래프를 분석 해보자.
# 이번에는 반대로 월급이 어떤 직업들이 적은가를 한번 분석해보자

bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

#출력해보기
bottom10

#그래프그리기
ggplot(data=bottom10, aes(x = reorder(job, -mean_income), y = mean_income))+
  geom_col()+
  coord_flip()+
  ylim(0,850)

#두개의 그래프를 분석해보니 가장 많은 평균급여를 받는 직업군은 "금속재료공학 기술자 및 시험원" 이고
#가장 적은 평균급여를 받는 사람은 "가사 및 육아 도우미"군으로 알 수가 있다 10배 이상 차이난다.



#########################################################################################################

#9-7 성별 직업 빈도 - 성별로 어떤 직업이 가장 많을까?
#성별에 따라 어떤 직업이 많은지 분석을 하기 위해서는 성별이란 변수와 직업이란 변수가 필요하다.
# 앞서 이미 두개의 변수는 전처리를 하였으므로, 관계분석에 들어가자.

# 남성 직업 빈도 상위 10개를 추출하자

welfare$job

job_male <- welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% #행의 갯수를 요약
  arrange(desc(n)) %>%   #행의 갯수에 따라 내림차순 정렬
  head(10)

job_male

job_female <- welfare %>% 
  filter(!is.na(job)& sex == "female") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% #행의 갯수를 요약
  arrange(desc(n)) %>%   #행의 갯수에 따라 내림차순 정렬
  head(10)

job_female

#위의 2개의 데이터 프레임을 이용하여 그래프로 나타내보자
#먼저 남성직업 빈도 상위10개 직업

ggplot(data = job_male, aes(x = reorder(job,n), y=n))+
  geom_col()+
  coord_flip()

#여성직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job,n), y=n))+
  geom_col()+
  coord_flip()

#남여 합친 빈도 상위 10개 직업
str <- welfare %>% 
  filter(!is.na(job)) %>% 
  group_by(job,sex) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)


#################################################################################################

#09-8 종교 유무에 따른 이혼율 - "종교가 있는 사람들이 이혼을 덜 할까?"

#종교 유무에 따라 이혼을 많이 하는지 안하는지에 대해서 한번 알아보도록 하죠
#먼저 종교(religion)변수와 혼인(marriage)변수에 대해서 전처리를 할 필요가 있다.
class(welfare$religion)
table(welfare$religion)

#코드북을 보니 종교가 있으면 1, 없으면 2이고 무응답이나 모름은 9로 되어있다고 나와있따.
#하지만 9라는 값은 table()로 보니 없는것을 알수 있어 이상치를 결측처리하는 작업은 생략할수 있다.
#종교 유무에 따라 문자를 부여하자

#종교 유무에 따라 이름 부여
welfare$religion <- ifelse(welfare$religion ==1, "yes","no")
table(welfare$religion)
qplot(welfare$religion)

#이제는 혼인(marriage)변수를 전처리 해보자
class(welfare$marriage)
table(welfare$marriage)

#marriage변수를 확인해보니 numeric에 해당값이 0~6까지다
#코드북을 살펴보니 0은 미해당(18세 미만), 1은 혼인상태, 2는 사별, 3은 이혼, 4는 별거 , 5는 미혼(18세이상, 미혼모포함)
# 6은 기타(사망) 등으로 나와있다.
#1, 3 을 이용하여 이혼여부를 나타내는 파생변수를 만들어보자

#이혼여부 파생변수 만들기(group_marriage)
welfare$group_marriage <- ifelse(welfare$marriage ==1, "marriage",
                                 ifelse(welfare$marriage==3,"divorce",NA))

#결혼한 사람이 8431명 이혼한 사람이 712명이다

table(welfare$group_marriage)

#확인해보니 NA값 즉 결측치가 7521명이다 
#이부분은 분석이서 제외해야함
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

#종교유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion,group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  count(religion,group_marriage) %>%  #religion, group_marriage별로 빈도구하기
  group_by(religion) %>% #그룹핑 안하면 전체 대상으로 round함수가 적용됨
  mutate(pct = round(n/sum(n)*100,1))

#위에서 만든 요약표에서 이혼에 해당하는 값만 추출하자

divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion,pct) #원하는 컬럼만 선택

#이제 divorce 데이터프레임을 가지고 그래프를 그려보자
#종교가 있는 사람들이 다소 이혼율이 낮다는걸 볼수가 있다.

ggplot(data=divorce, aes(x=religion, y=pct))+
  geom_col()+
  scale_x_discrete(limits = c("yes","no"))

#위에서는 전체를 대상으로 종교 유무에 따른 이혼율을 분석했다 좀더 자세히 분석하기 위해서 연령대 및 종교유무에
#따른 이혼율을 알아보자
#먼저 연령대별 이혼율표를 만들어보자

ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg,group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_marriage

ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  count(ageg,group_marriage) %>% 
  group_by(ageg) %>% 
  mutate(pct = round(n/sum(n)*100,1))

#위에서 만든 요약표에서 초녀(young)를 제외하고, 이혼비율을 산출해보자
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)

#그래프로 그려보자
ggplot(data = ageg_divorce, aes(x = ageg, y = pct))+
  geom_col()

#이제 종교 유무에 따른 이혼율 차이가 연령대별로 다른지 알아보자.
#먼저 연령대(ageg) 종교유무(religion), 결혼상태(group_marriage)별로 집단을 나눠서
#빈도를 구한다음 각 집단 전체빈도로 나눠 비율을 구하고 이혼에 해당하는 값만 추출 하면 될 것이다.

ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  group_by(ageg,religion,group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_religion_marriage

ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  count(ageg,religion,group_marriage) %>% 
  group_by(ageg,religion) %>% 
  mutate(pct = round(n/sum(n)*100,1))

df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% #이혼한 사람중에서
  select(ageg,religion,pct) #연령, 종교유무, 비율만 출력하라.

df_divorce

#그래프로 한번 그려보자
#분석해보면 중년은 종교가 없는 사람이 이혼율이 높고 노년층은 비슷한것을 알수가 있다.
ggplot(data = df_divorce, aes(x=ageg, y=pct, fill = religion))+
  geom_col(position = "dodge")



###########################################################################################################

#09-9 노년층이 많은 지역은 어디일까?

class(welfare$code_region)
table(welfare$code_region)

#지역명 변수(list_region)
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산.경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))

list_region

#이제 welfare데이터에 left_join을 이용하여 위에서 만든 지역명 변수를 추가하자 물론 id값을 code_region으로 해야 매핑이 되어 들어갈 것이다.

welfare <- left_join(welfare, list_region, id = "code_region")

#추가 되었는지 확인해보자
welfare %>% 
  #count(code_region, region)
  select(code_region, region) %>% 
  tail()

region_ageg <- welfare %>% 
  count(region, ageg) %>%
  group_by(region) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,2))

View(region_ageg)

#그래프 만들기
ggplot(data = region_ageg, aes(x=region, y=pct, fill = ageg))+
geom_col()+
  coord_flip()

#그래프를 보니 정렬이 안되어 있어 보기가 매우 불편하다.
#노년층 비율 오름차순 정렬
list_order_old <- region_ageg %>% 
  filter(ageg =="old") %>% 
  arrange(pct)

list_order_old
#지역명 순서 변수 만들기
#다시 노년층의 오름차순으로 된 것을 이용하여 거기서 지역명을 추출한후 그래프에 기준으로 주면 된다.
order <- list_order_old$region
View(list_order_old$region)
order

#그래프 그리기
#ggplot2패키지의 치트시트를 보고 이해하자
# scale_x_discrete()는 인자값에 순서에 따라 표식기능을 가지고 있다
#현재는 order갑이 노년층 비율이 높은 순서대로 되어 있다.
ggplot(data=region_ageg, aes(x=region, y=pct, fill=ageg))+
  geom_col()+
  coord_flip()+
  scale_x_discrete(limits = order)

#위에서 만든 그래프는 연령대 순서가 맞지 않다 하여 초년 중년 노년의 순서로 나열되도록 하자
# 먼저 regionageg의 속성을 보자
#확인하니 문자타입이다 이것을 막대색깔을 순서대로 나열하려면 fill인자값을 지정할때 
#변수의 범주(levels)순서를 지정하면 된다.
class(region_ageg$ageg)
levels(region_ageg$ageg)

#하여 문자값을 factor로 바꾸자
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old","middle","young"))
region_ageg$ageg

class(region_ageg$ageg)
levels(region_ageg$ageg)

#이제 그래프를 그려보자
#보기 좋게 노년층이 많은순으로 나열 되었으며 대구 경북이 최고로 노녀층이 많음을 알 수 있고 
#초년 중년은 수도권에 제일 많은걸로 보인다.
ggplot(data = region_ageg, aes(x = region, y=pct , fill = ageg))+
  geom_col()+
  coord_flip()+
  scale_x_discrete(limits = order)
