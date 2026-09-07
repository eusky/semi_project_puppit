# 로컬 개발 실행

MySQL만 Docker로 실행하고 앱은 로컬 JDK 11 / Tomcat 9에서 실행합니다.
Compose의 계정과 비밀번호는 개발용이며 DB는 루프백 주소에만 공개합니다.

## MySQL 실행

Docker Desktop을 켜고 프로젝트 루트에서 실행합니다.

```powershell
docker compose up -d --wait mysql
```

새 데이터 볼륨의 최초 실행에 SCHEMA.sql과 ops/mysql/02-seed.sql이 순서대로 실행됩니다.
카테고리, 판매 상태, 개발용 상품 등급 및 지역이 생성됩니다.
03-demo-users.sql로 개발용 계정 test01(구매자), test02(판매자), test03(일반 회원)도 생성됩니다.
세 계정의 비밀번호는 모두 `Puppit123!`이며 초기 포인트는 각각 10,000입니다.
이 역할 구분은 테스트 편의용 이름이며 권한 차이는 없습니다.
기존 스키마의 신규 회원 기본 포인트 10,000은 유지됩니다.

## 로컬 Tomcat 환경변수

IntelliJ Run/Debug Configurations의 Tomcat 환경변수에 등록합니다.

```dotenv
SPRING_DATASOURCE_URL=jdbc:mysql://127.0.0.1:13306/puppit?serverTimezone=Asia/Seoul&useSSL=false&allowPublicKeyRetrieval=true
SPRING_DATASOURCE_USERNAME=puppit
SPRING_DATASOURCE_PASSWORD=puppit_dev_password
```

AWS 및 포트원 설정은 기존 값을 사용하세요. 루트 .env는 Compose용이며 로컬 Tomcat은
자동으로 읽지 않습니다. Tomcat 9에 WAR 또는 WAR exploded를 배포하고 Application context를
/로 지정하면 기본 포트 기준 http://localhost:8080/ 로 접속합니다.

호스트는 기존 포트 충돌을 피하기 위해 13306을 사용합니다. 13306도 사용할 수 없다면
다음처럼 실행하고 JDBC URL도 3308로 변경하세요.

```powershell
$env:MYSQL_PORT = '3308'
docker compose up -d --wait mysql
```

## 상태 확인 및 종료

```powershell
docker compose ps
docker compose logs mysql
docker compose down
```

종료해도 mysql_dev_data 볼륨의 데이터는 유지됩니다. 초기 SQL 수정은 기존 볼륨에는
자동 적용되지 않습니다. 기존 DB에는 별도 마이그레이션이 필요합니다.
기존 app/nginx 컨테이너가 남아 있다면 사용 여부를 확인한 후 별도로 종료하세요.
