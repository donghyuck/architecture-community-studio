	-- =================================================  
	-- PACKAGE: FRAMEWORK  
	-- CREATE : 2018.11.6
	-- UPDATE : 
	-- =================================================	
	
	CREATE TABLE AC_UI_PROPERTY (
		PROPERTY_NAME	VARCHAR2(100)   NOT NULL,
		PROPERTY_VALUE	VARCHAR2(1024)  NOT NULL,
		CONSTRAINT AC_UI_PROPERTY_PK PRIMARY KEY (PROPERTY_NAME)
	);
	
	
	CREATE TABLE AC_UI_SEQUENCER(
	SEQUENCER_ID	INTEGER NOT NULL,
	NAME			VARCHAR2(100)   NOT NULL,
	DISPLAY_NAME    VARCHAR(255),
	VALUE			INTEGER NOT NULL,
	CONSTRAINT AC_UI_SEQUENCER_PK PRIMARY KEY (SEQUENCER_ID)
	);
	
	
	CREATE UNIQUE INDEX  "AC_UI_SEQUENCER_UIDX1" ON "AC_UI_SEQUENCER" ("NAME"); 
	COMMENT ON COLUMN "AC_UI_SEQUENCER"."SEQUENCER_ID" IS '시퀀서 ID';
	COMMENT ON COLUMN "AC_UI_SEQUENCER"."NAME" IS '시퀀서 이름';
	COMMENT ON COLUMN "AC_UI_SEQUENCER"."VALUE" IS '시퀀서 값';
	COMMENT ON TABLE  "AC_UI_SEQUENCER"  IS '애플리케이션 전역에서 사용되는 시퀀서 정보';
	
	-- =================================================  
	-- PACKAGE: SECURITY  
	-- CREATE : 2018.11.6
	-- UPDATE : 
	-- =================================================	
	-- User 
	
		CREATE TABLE AC_UI_USER (
		  USER_ID                INTEGER NOT NULL,
		  USERNAME               VARCHAR2(100) NOT NULL,
		  PASSWORD_HASH          VARCHAR2(64)  NOT NULL,
		  NAME                   VARCHAR2(100),		  
		  NAME_VISIBLE           NUMBER(1, 0)  DEFAULT 1 ,
		  FIRST_NAME             VARCHAR2(100),		  
		  LAST_NAME              VARCHAR2(100),		
		  EMAIL                  VARCHAR2(100) NOT NULL,
		  EMAIL_VISIBLE          NUMBER(1, 0)  DEFAULT 1,
		  USER_ENABLED           NUMBER(1, 0)  DEFAULT 1, 
		  USER_EXTERNAL			NUMBER(1, 0)  DEFAULT 0, 
		  STATUS                 NUMBER(1, 0)  DEFAULT 0,
		  CREATION_DATE          DATE DEFAULT  SYSDATE NOT NULL,
		  MODIFIED_DATE          DATE DEFAULT  SYSDATE NOT NULL,		    
		  CONSTRAINT AC_UI_USER_PK PRIMARY KEY (USER_ID)
		);		
		
		CREATE UNIQUE INDEX AC_UI_USER_IDX_USERNAME ON AC_UI_USER (USERNAME);
		
		COMMENT ON TABLE  "AC_UI_USER"  IS '사용자 테이블';
		COMMENT ON COLUMN "AC_UI_USER"."USER_ID" IS 'ID'; 
		COMMENT ON COLUMN "AC_UI_USER"."USERNAME" IS '로그인 아이디'; 
        COMMENT ON COLUMN "AC_UI_USER"."NAME" IS '전체 이름';
		COMMENT ON COLUMN "AC_UI_USER"."PASSWORD_HASH" IS '암호화된 패스워드'; 
        COMMENT ON COLUMN "AC_UI_USER"."NAME_VISIBLE" IS '이름 공개 여부';        
		COMMENT ON COLUMN "AC_UI_USER"."FIRST_NAME" IS '이름'; 
        COMMENT ON COLUMN "AC_UI_USER"."LAST_NAME" IS '성';        
		COMMENT ON COLUMN "AC_UI_USER"."EMAIL" IS '메일주소'; 
        COMMENT ON COLUMN "AC_UI_USER"."EMAIL_VISIBLE" IS '메일주소 공개여부';           
		COMMENT ON COLUMN "AC_UI_USER"."USER_ENABLED" IS '계정 사용여부';     
        COMMENT ON COLUMN "AC_UI_USER"."STATUS" IS '계정 상태';	    
        COMMENT ON COLUMN "AC_UI_USER"."CREATION_DATE" IS '생성일자';	    
        COMMENT ON COLUMN "AC_UI_USER"."MODIFIED_DATE" IS '수정일자';	
        
        -- Role
		CREATE TABLE AC_UI_ROLE (
		  ROLE_ID                     INTEGER NOT NULL,
		  NAME                        VARCHAR2(100)   NOT NULL,
		  DESCRIPTION              VARCHAR2(1000)  NOT NULL,
		  CREATION_DATE           DATE DEFAULT  SYSDATE NOT NULL,
		  MODIFIED_DATE           DATE DEFAULT  SYSDATE NOT NULL,	
		  CONSTRAINT AC_UI_ROLE_PK PRIMARY KEY (ROLE_ID)
		);
		
		COMMENT ON TABLE "AC_UI_ROLE"  IS '롤 테이블';
		COMMENT ON COLUMN "AC_UI_ROLE"."ROLE_ID" IS '롤 ID'; 
		COMMENT ON COLUMN "AC_UI_ROLE"."NAME" IS '롤 이름'; 
		COMMENT ON COLUMN "AC_UI_ROLE"."DESCRIPTION" IS '설명'; 	
		COMMENT ON COLUMN "AC_UI_ROLE"."CREATION_DATE" IS '생성일자'; 
		COMMENT ON COLUMN "AC_UI_ROLE"."MODIFIED_DATE" IS '수정일자'; 				
		
		CREATE UNIQUE INDEX AC_UI_ROLE_NAME_IDX ON AC_UI_ROLE (NAME);
		
		-- User Roles  
		CREATE TABLE AC_UI_USER_ROLES (
		  USER_ID                 INTEGER NOT NULL,
		  ROLE_ID                 INTEGER NOT NULL,
		  CONSTRAINT AC_UI_USER_ROLES_PK PRIMARY KEY (USER_ID, ROLE_ID)
		);

		COMMENT ON TABLE "AC_UI_USER_ROLES"  IS '사용자 롤 테이블';
		COMMENT ON COLUMN "AC_UI_USER_ROLES"."USER_ID" IS '그룹 ID'; 
		COMMENT ON COLUMN "AC_UI_USER_ROLES"."ROLE_ID" IS '롤 ID'; 
		
		
		-- User remember me
		CREATE TABLE AC_UI_USER_LOGIN_TOKEN (
			UUID			VARCHAR2(100) NOT NULL,
			USERNAME		VARCHAR2(100) NOT NULL, 
		 	TOKEN 			VARCHAR2(100) NOT NULL, 
		 	LAST_USE_DATE	TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
		);
 
		COMMENT ON TABLE "AC_UI_USER_LOGIN_TOKEN"  IS '인증 정보 저장 테이블';
		COMMENT ON COLUMN "AC_UI_USER_LOGIN_TOKEN"."UUID" IS '시퀀스 값'; 
		COMMENT ON COLUMN "AC_UI_USER_LOGIN_TOKEN"."USERNAME" IS '로그인아이디'; 	
		COMMENT ON COLUMN "AC_UI_USER_LOGIN_TOKEN"."TOKEN" IS '인증 토큰 값'; 
		COMMENT ON COLUMN "AC_UI_USER_LOGIN_TOKEN"."LAST_USE_DATE" IS '마지막 사용일자'; 	
		

	--  COMPANY	
		CREATE TABLE AC_UI_COMPANY (
			  COMPANY_ID                INTEGER NOT NULL,
			  DISPLAY_NAME             	VARCHAR2(255)   NOT NULL,
			  NAME                      VARCHAR2(100)   NOT NULL,
			  DOMAIN_NAME				VARCHAR2(100),
			  DESCRIPTION               VARCHAR2(1000),
			  CREATION_DATE            	DATE DEFAULT  SYSDATE NOT NULL,
			  MODIFIED_DATE            	DATE DEFAULT  SYSDATE NOT NULL,	
			  CONSTRAINT AC_UI_COMPANY_PK 	PRIMARY KEY (COMPANY_ID)
		);
		
		CREATE INDEX AC_UI_COMPANY_DATE_IDX ON AC_UI_COMPANY(CREATION_DATE) ;		
		CREATE INDEX AC_UI_COMPANY_NAME_IDX ON AC_UI_COMPANY(NAME);			
		CREATE INDEX AC_UI_COMPANY_DOMAIN_IDX ON AC_UI_COMPANY(DOMAIN_NAME);			
		
		COMMENT ON TABLE      "AC_UI_COMPANY"  IS '회사 테이블';
		COMMENT ON COLUMN "AC_UI_COMPANY"."COMPANY_ID" IS '회사 ID'; 
		COMMENT ON COLUMN "AC_UI_COMPANY"."NAME" IS '회사 이름'; 
		COMMENT ON COLUMN "AC_UI_COMPANY"."DISPLAY_NAME" IS '출력시 보여줄 회사 이름'; 
		COMMENT ON COLUMN "AC_UI_COMPANY"."DESCRIPTION" IS '설명'; 
		COMMENT ON COLUMN "AC_UI_COMPANY"."DOMAIN_NAME" IS '도메인 이름';
		COMMENT ON COLUMN "AC_UI_COMPANY"."CREATION_DATE" IS '생성일자'; 
		COMMENT ON COLUMN "AC_UI_COMPANY"."MODIFIED_DATE" IS '수정일자'; 		
	
		
	    CREATE TABLE AC_UI_COMPANY_PROPERTY (
		  COMPANY_ID               INTEGER NOT NULL,
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_COMPANY_PROPERTY_PK PRIMARY KEY (COMPANY_ID, PROPERTY_NAME)
		);	
		COMMENT ON TABLE      "AC_UI_COMPANY_PROPERTY"  IS '회사 프로퍼티 테이블';
		COMMENT ON COLUMN "AC_UI_COMPANY_PROPERTY"."COMPANY_ID" IS '회사 ID'; 
		COMMENT ON COLUMN "AC_UI_COMPANY_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
		COMMENT ON COLUMN "AC_UI_COMPANY_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 	

	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : MENU  
	-- CREATE : 2019.10.11
	-- UPDATE : 
	-- =================================================	

	CREATE TABLE AC_UI_MENU (
	MENU_ID			INTEGER NOT NULL,
	NAME			VARCHAR2(255) NULL,
	DESCRIPTION		VARCHAR2(1000),
	CREATION_DATE	TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	MODIFIED_DATE	TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	CONSTRAINT AC_UI_MENU_PK PRIMARY KEY (MENU_ID)
	);
	
	-- CREATE UNIQUE INDEX AC_UI_MENU_UIDX1 ON AC_UI_MENU (NAME);
	
	COMMENT ON TABLE  "AC_UI_MENU"  IS '메뉴 테이블';
	COMMENT ON COLUMN "AC_UI_MENU"."MENU_ID" IS '메뉴 ID';
	COMMENT ON COLUMN "AC_UI_MENU"."NAME" IS '메뉴 이름';
	COMMENT ON COLUMN "AC_UI_MENU"."DESCRIPTION" IS '메뉴 설명';
	COMMENT ON TABLE "AC_UI_MENU"  IS 'UI 메뉴 테이블';

	CREATE TABLE AC_UI_MENU_PROPERTY (
		  MENU_ID				INTEGER NOT NULL, 
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_MENU_PROPERTY_PK PRIMARY KEY (MENU_ID, PROPERTY_NAME)
	);	

	COMMENT ON TABLE  "AC_UI_MENU_PROPERTY"  IS 'MENU 프로퍼티 테이블';
	COMMENT ON COLUMN "AC_UI_MENU_PROPERTY"."MENU_ID" IS 'MENU ID';  
	COMMENT ON COLUMN "AC_UI_MENU_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_MENU_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값';  
	
	
	CREATE TABLE AC_UI_MENU_ITEM (
		MENU_ID			INTEGER NOT NULL,
		PARENT_ID		INTEGER NOT NULL,
		MENU_ITEM_ID	INTEGER NOT NULL,
		NAME			VARCHAR2(255) NOT NULL,
		SORT_ORDER		INTEGER DEFAULT 1 NULL,
		DESCRIPTION		VARCHAR2(4000) NULL,
		LINK_URL		VARCHAR2(255) NULL,
		ROLES			VARCHAR2(255) NULL,
		PAGE			VARCHAR2(255) NULL,	
		CREATION_DATE	TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
		MODIFIED_DATE 	TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
		CONSTRAINT AC_UI_MENU_ITEM_PK PRIMARY KEY (MENU_ITEM_ID)
	);
   
	CREATE INDEX AC_UI_MENU_ITEM_IDX1   ON AC_UI_MENU_ITEM (MENU_ID, PARENT_ID);
   	CREATE INDEX AC_UI_MENU_ITEM_IDX2   ON AC_UI_MENU_ITEM (PARENT_ID);
 
	COMMENT ON COLUMN "AC_UI_MENU_ITEM"."MENU_ID" IS '메뉴 ID';
	COMMENT ON COLUMN "AC_UI_MENU_ITEM"."PARENT_ID" IS '부모 메뉴 아이템 이름';
	COMMENT ON COLUMN "AC_UI_MENU_ITEM"."MENU_ITEM_ID" IS '메뉴 아이템 ID';
	COMMENT ON TABLE "AC_UI_MENU_ITEM"  IS 'UI 메뉴 아이템 테이블';

	CREATE TABLE AC_UI_MENU_ITEM_PROPERTY (
		  MENU_ITEM_ID				INTEGER NOT NULL, 
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_MENU_ITEM_PROPERTY_PK PRIMARY KEY (MENU_ITEM_ID, PROPERTY_NAME)
	);	

	COMMENT ON TABLE  "AC_UI_MENU_ITEM_PROPERTY"  IS 'MENU_ITEM 프로퍼티 테이블'; 
	COMMENT ON COLUMN "AC_UI_MENU_ITEM_PROPERTY"."MENU_ITEM_ID" IS 'MENU_ITEM ID'; 	
	COMMENT ON COLUMN "AC_UI_MENU_ITEM_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_MENU_ITEM_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값';  
	
	
	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : USER AVATAR 
	-- CREATE : 2019.09.18
	-- UPDATE : 
	-- =================================================	 
	
		CREATE TABLE AC_UI_AVATAR_IMAGE (	
			"AVATAR_IMAGE_ID" NUMBER(*,0) NOT NULL ENABLE, 
			"USER_ID" NUMBER(*,0) NOT NULL ENABLE, 
			"PRIMARY_IMAGE" NUMBER(1,0) DEFAULT 1, 
			"FILE_NAME" VARCHAR2(255 BYTE) NOT NULL ENABLE, 
			"FILE_SIZE" NUMBER(*,0) NOT NULL ENABLE, 
			"CONTENT_TYPE" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
			"CREATION_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
			"MODIFIED_DATE" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
			CONSTRAINT AC_UI_AVATAR_IMAGE_PK PRIMARY KEY (AVATAR_IMAGE_ID)
		);
		CREATE INDEX  AC_UI_AVATAR_IMAGE_IDX1  ON AC_UI_AVATAR_IMAGE  ("USER_ID") ;

		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."AVATAR_IMAGE_ID" IS 'ID';	 
		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."USER_ID" IS '사용자 ID';	 
		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."PRIMARY_IMAGE" IS '주 이미지 여부';	 
		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."FILE_NAME" IS '이미지 파일 이름';	 
		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."FILE_SIZE" IS '이미지 파일 크기';	 
	   COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."CONTENT_TYPE" IS 'CONTENT TYPE 값';	 
	   COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."CREATION_DATE" IS '생성일';	 
	   COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE"."MODIFIED_DATE" IS '수정일';	 
	   COMMENT ON TABLE   "AC_UI_AVATAR_IMAGE"  IS '아바타 이미지 테이블';
 
  		CREATE TABLE  "AC_UI_AVATAR_IMAGE_DATA" (	
  			"AVATAR_IMAGE_ID" NUMBER(*, 0) NOT NULL ENABLE, 
			"AVATAR_IMAGE_DATA" BLOB, 
	 		CONSTRAINT "AC_UI_AVATAR_IMAGE_DATA_PK" PRIMARY KEY ("AVATAR_IMAGE_ID")
	 	);

		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE_DATA"."AVATAR_IMAGE_ID" IS 'ID'; 
		COMMENT ON COLUMN  "AC_UI_AVATAR_IMAGE_DATA"."AVATAR_IMAGE_DATA" IS '이미지 데이터'; 
		COMMENT ON TABLE   "AC_UI_AVATAR_IMAGE_DATA"  IS '아바타 이미지 데이터 테이블'; 	
		
		
	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : PAGE 
	-- CREATE : 2018.09.19
	-- UPDATE :
	-- 2018.09.17 - AC_UI_PAGE_BODY_VERSION.SCRIPT 추가 
	-- =================================================	
	CREATE TABLE AC_UI_PAGE(	
		PAGE_ID						INTEGER NOT NULL,
		OBJECT_TYPE					INTEGER NOT NULL,
		OBJECT_ID					INTEGER NOT NULL,
		NAME						VARCHAR2(255) NOT NULL,	
		VERSION_ID					INTEGER DEFAULT 1 NOT NULL,
		USER_ID						INTEGER NOT NULL,
		READ_COUNT          		INTEGER DEFAULT 0  NOT NULL,
		PATTERN						VARCHAR2(255) NULL,	
		CREATION_DATE				DATE DEFAULT  SYSDATE NOT NULL,
		MODIFIED_DATE				DATE DEFAULT  SYSDATE NOT NULL,			
		CONSTRAINT AC_UI_PAGE_PK PRIMARY KEY (PAGE_ID)
	);

	CREATE UNIQUE INDEX AC_UI_PAGE_IDX1 ON REP_PAGE (NAME);
	CREATE INDEX AC_UI_PAGE_IDX2   ON REP_PAGE (OBJECT_TYPE, OBJECT_ID, PAGE_ID);
	CREATE INDEX AC_UI_PAGE_IDX3   ON REP_PAGE (USER_ID);

	CREATE TABLE AC_UI_PAGE_BODY
	(	
		BODY_ID						INTEGER NOT NULL,
		PAGE_ID						INTEGER NOT NULL,
		BODY_TYPE					INTEGER NOT NULL,
		BODY_TEXT					CLOB,
		CONSTRAINT AC_UI_PAGE_BODY_PK PRIMARY KEY (BODY_ID)
    ) ;
	
		
	CREATE TABLE AC_UI_PAGE_BODY_VERSION
	(	
		BODY_ID					INTEGER NOT NULL,
		PAGE_ID						INTEGER NOT NULL,
		VERSION_ID				INTEGER DEFAULT 1 NOT NULL ,
		CONSTRAINT AC_UI_PAGE_BODY_VERSION_PK PRIMARY KEY (BODY_ID, PAGE_ID, VERSION_ID )
   );
   
   CREATE INDEX AC_UI_PAGE_BODY_VERSION_IDX1   ON AC_UI_PAGE_BODY_VERSION (PAGE_ID, VERSION_ID);

		
  CREATE TABLE AC_UI_PAGE_VERSION
   (	
	PAGE_ID					INTEGER NOT NULL,
	VERSION_ID				INTEGER DEFAULT 1 NOT NULL ,
	STATE					VARCHAR2(20), 
	TITLE					VARCHAR2(255), 
	SECURED          		NUMBER(1, 0)  DEFAULT 1,
	TEMPLATE				VARCHAR2(255), 
	SCRIPT					VARCHAR2(255), 
	PATTERN					VARCHAR2(255), 	
	SUMMARY					VARCHAR2(4000), 
	USER_ID					INTEGER	NOT NULL,
	CREATION_DATE			DATE DEFAULT  SYSDATE NOT NULL,
	MODIFIED_DATE			DATE DEFAULT  SYSDATE NOT NULL,	
	CONSTRAINT AC_UI_PAGE_VERSION_PK PRIMARY KEY (PAGE_ID, VERSION_ID)
   ) ;

		
	CREATE INDEX AC_UI_PAGE_VERSION_IDX1   ON AC_UI_PAGE_VERSION (CREATION_DATE);
	CREATE INDEX AC_UI_PAGE_VERSION_IDX2   ON AC_UI_PAGE_VERSION (MODIFIED_DATE);
	CREATE INDEX AC_UI_PAGE_VERSION_IDX3   ON AC_UI_PAGE_VERSION (TITLE);
	CREATE INDEX AC_UI_PAGE_VERSION_IDX4   ON AC_UI_PAGE_VERSION (PAGE_ID, STATE);

			
	CREATE TABLE AC_UI_PAGE_PROPERTY (
		  PAGE_ID				INTEGER NOT NULL,
		  VERSION_ID				INTEGER DEFAULT 1 NOT NULL,
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_PAGE_PROPERTY_PK PRIMARY KEY (PAGE_ID, VERSION_ID, PROPERTY_NAME)
	);	

	COMMENT ON TABLE  "AC_UI_PAGE_PROPERTY"  IS 'PAGE 프로퍼티 테이블';
	COMMENT ON COLUMN "AC_UI_PAGE_PROPERTY"."PAGE_ID" IS 'PAGE ID'; 
	COMMENT ON COLUMN "AC_UI_PAGE_PROPERTY"."VERSION_ID" IS 'PAGE VERSION'; 	
	COMMENT ON COLUMN "AC_UI_PAGE_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_PAGE_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 	 		
	
	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : API 
	-- CREATE : 2018.10.18
	-- UPDATE : 
	-- =================================================		
	CREATE TABLE AC_UI_API (
		OBJECT_TYPE				INTEGER NOT NULL,
		OBJECT_ID				INTEGER NOT NULL,	 
		API_ID					INTEGER NOT NULL,
		TITLE					VARCHAR2(255), 
		API_NAME				VARCHAR2(255) NOT NULL,
		API_VERSION				VARCHAR2(255) NOT NULL,
		DESCRIPTION				VARCHAR2(1000), 
		CONTENT_TYPE			VARCHAR2(50), 
		SECURED					NUMBER(1, 0)  DEFAULT 1,
		ENABLED					NUMBER DEFAULT 0,	
		SCRIPT					VARCHAR2(255), 
		PATTERN					VARCHAR2(255), 
		CREATOR_ID				INTEGER NOT NULL,
		CREATION_DATE			TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
		MODIFIED_DATE			TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
		CONSTRAINT AC_UI_API_PK PRIMARY KEY (API_ID)
	);	
	
	CREATE INDEX AC_UI_API_IDX_01 ON AC_UI_API (OBJECT_TYPE, OBJECT_ID);

	CREATE TABLE "AC_UI_API_PROPERTY" (	
	"API_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"PROPERTY_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"PROPERTY_VALUE" VARCHAR2(1024 BYTE) NOT NULL ENABLE, 
	CONSTRAINT "AC_UI_API_PROPERTY_PK" PRIMARY KEY ("API_ID", "PROPERTY_NAME"));

	COMMENT ON COLUMN "AC_UI_API_PROPERTY"."API_ID" IS 'TASK ID'; 
	COMMENT ON COLUMN "AC_UI_API_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_API_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 
	COMMENT ON TABLE  "AC_UI_API_PROPERTY"  IS 'TASK 프로퍼티 테이블';		
	
	
	-- =================================================  
	--  VIEWCOUNT	
	-- =================================================	
	CREATE TABLE AC_UI_VIEWCOUNT(	
		ENTITY_TYPE					INTEGER NOT NULL,
		ENTITY_ID					INTEGER NOT NULL,
		VIEWCOUNT					INTEGER NOT NULL,
		CONSTRAINT AC_UI_VIEWCOUNT_PK PRIMARY KEY (ENTITY_TYPE, ENTITY_ID)
   	);		
   		
   	COMMENT ON TABLE "AC_UI_VIEWCOUNT"  IS '뷰 카운트 테이블';
	COMMENT ON COLUMN "AC_UI_VIEWCOUNT"."ENTITY_TYPE" IS '객체 타입'; 
	COMMENT ON COLUMN "AC_UI_VIEWCOUNT"."ENTITY_ID" IS '객체 아이디'; 
	COMMENT ON COLUMN "AC_UI_VIEWCOUNT"."VIEWCOUNT" IS '카운트'; 
	
	

	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : IMAGE 
	-- CREATE : 2018.09.19
	-- UPDATE : 
	-- =================================================		
		
	CREATE TABLE AC_UI_IMAGE (
		IMAGE_ID                 INTEGER NOT NULL,
		OBJECT_TYPE              INTEGER NOT NULL,
		OBJECT_ID                INTEGER NOT NULL,
		FILE_NAME                VARCHAR2(255)   NOT NULL,
		FILE_SIZE                INTEGER   NOT NULL,
		CONTENT_TYPE             VARCHAR2(50)  NOT NULL,			  
		USER_ID				   	 INTEGER NOT NULL,	 	
		CREATION_DATE            DATE DEFAULT  SYSDATE NOT NULL,
		MODIFIED_DATE            DATE DEFAULT  SYSDATE NOT NULL,	
		CONSTRAINT AC_UI_IMAGE_PK PRIMARY KEY (IMAGE_ID)
	);		        
		
		
		CREATE INDEX AC_UI_IMAGE_IDX1 ON AC_UI_IMAGE( OBJECT_TYPE, OBJECT_ID ) ;	
		COMMENT ON TABLE "AC_UI_IMAGE"  IS '이미지 테이블';
		COMMENT ON COLUMN "AC_UI_IMAGE"."IMAGE_ID" IS 'ID'; 
		COMMENT ON COLUMN "AC_UI_IMAGE"."OBJECT_TYPE" IS '이미지와 연관된 모델 유형'; 
        COMMENT ON COLUMN "AC_UI_IMAGE"."OBJECT_ID" IS '이미지와 연관된 모델 ID';
		COMMENT ON COLUMN "AC_UI_IMAGE"."FILE_NAME" IS '이미지 파일 이름'; 
        COMMENT ON COLUMN "AC_UI_IMAGE"."FILE_SIZE" IS '이미지 파일 크기';        
		COMMENT ON COLUMN "AC_UI_IMAGE"."CONTENT_TYPE" IS 'CONTENT TYPE 값'; 
		COMMENT ON COLUMN "AC_UI_IMAGE"."CREATION_DATE" IS '생성일'; 
        COMMENT ON COLUMN "AC_UI_IMAGE"."MODIFIED_DATE" IS '수정일';
        
        CREATE TABLE AC_UI_IMAGE_DATA (
			  IMAGE_ID                    INTEGER NOT NULL,
			  IMAGE_DATA               BLOB,
			  CONSTRAINT AC_UI_IMAGE_DATA_PK PRIMARY KEY (IMAGE_ID)
		);		        
		
		COMMENT ON TABLE "AC_UI_IMAGE_DATA"  IS '이미지 데이터 테이블';
		COMMENT ON COLUMN "AC_UI_IMAGE_DATA"."IMAGE_ID" IS 'ID'; 
		COMMENT ON COLUMN "AC_UI_IMAGE_DATA"."IMAGE_DATA" IS '이미지 데이터'; 		
		
	CREATE TABLE AC_UI_IMAGE_PROPERTY (
		  IMAGE_ID				INTEGER NOT NULL, 
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_IMAGE_PROPERTY_PK PRIMARY KEY (IMAGE_ID, PROPERTY_NAME)
	);	

	COMMENT ON TABLE  "AC_UI_IMAGE_PROPERTY"  IS 'IMAGE 프로퍼티 테이블';
	COMMENT ON COLUMN "AC_UI_IMAGE_PROPERTY"."IMAGE_ID" IS 'IMAGE';  
	COMMENT ON COLUMN "AC_UI_IMAGE_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_IMAGE_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 	 

	
		CREATE TABLE AC_UI_IMAGE_LINK ( 
			LINK_ID						VARCHAR2(255)	NOT NULL, 
			IMAGE_ID					INTEGER NOT NULL,			
			PUBLIC_SHARED			NUMBER(1, 0)  DEFAULT 1,
			CONSTRAINT AC_UI_IMAGE_LINK_PK PRIMARY KEY (LINK_ID)
		); 		
		CREATE UNIQUE INDEX AC_UI_IMAGE_LINK_IDX ON AC_UI_IMAGE_LINK (IMAGE_ID);
		
		COMMENT ON TABLE "AC_UI_IMAGE_LINK"  IS '이미지 링크 테이블';
		COMMENT ON COLUMN "AC_UI_IMAGE_LINK"."LINK_ID" IS '링크 아이디'; 
		COMMENT ON COLUMN "AC_UI_IMAGE_LINK"."IMAGE_ID" IS '이미지 아이디'; 	
		
		
	-- =================================================  
	--  EXTERNAL_LINK	
	-- =================================================	
	
		CREATE TABLE AC_UI_SHARED_LINK ( 
			LINK_ID						VARCHAR2(255)	NOT NULL, 
			OBJECT_TYPE					INTEGER NOT NULL,		
			OBJECT_ID                INTEGER NOT NULL,
			PUBLIC_SHARED			NUMBER(1, 0)  DEFAULT 1,
			CONSTRAINT AC_UI_LINK_ID_PK PRIMARY KEY (LINK_ID)
		); 		
		
		CREATE UNIQUE INDEX AC_UI_SHARED_LINK_IDX1 ON AC_UI_SHARED_LINK (OBJECT_TYPE, OBJECT_ID);
		
		COMMENT ON TABLE "AC_UI_SHARED_LINK"  IS '공유 링크 테이블';
		COMMENT ON COLUMN "AC_UI_SHARED_LINK"."LINK_ID" IS '링크 아이디'; 
		COMMENT ON COLUMN "AC_UI_SHARED_LINK"."OBJECT_TYPE" IS '객체타입'; 	
		COMMENT ON COLUMN "AC_UI_SHARED_LINK"."OBJECT_ID" IS '객체 아이디'; 	
		COMMENT ON COLUMN "AC_UI_SHARED_LINK"."PUBLIC_SHARED" IS '공개여부'; 	
		
		
--------------------------------------------------------
--  DDL for Table AC_UI_ATTACHMENT
--------------------------------------------------------

  CREATE TABLE "AC_UI_ATTACHMENT" 
   (	"ATTACHMENT_ID" NUMBER(*,0), 
	"OBJECT_TYPE" NUMBER(*,0), 
	"OBJECT_ID" NUMBER(*,0), 
	"CONTENT_TYPE" VARCHAR2(255 BYTE), 
	"FILE_NAME" VARCHAR2(255 BYTE), 
	"FILE_SIZE" NUMBER(*,0), 
	 USER_ID	INTEGER NOT NULL,	 	
	"CREATION_DATE" DATE DEFAULT SYSDATE, 
	"MODIFIED_DATE" DATE DEFAULT SYSDATE
   ) ;

   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."ATTACHMENT_ID" IS 'ID';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."OBJECT_TYPE" IS '첨부파일과 연관된 모델 유형';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."OBJECT_ID" IS '첨부파일과 연관된 모델 ID';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."CONTENT_TYPE" IS 'CONTENT TYPE 값';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."FILE_NAME" IS '첨부파일 이름';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."FILE_SIZE" IS '첨부파일 크기';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."CREATION_DATE" IS '생성일';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT"."MODIFIED_DATE" IS '수정일';
   COMMENT ON TABLE "AC_UI_ATTACHMENT"  IS '첨부파일 테이블';
/
--------------------------------------------------------
--  DDL for Table AC_UI_ATTACHMENT_DATA
--------------------------------------------------------

  CREATE TABLE "AC_UI_ATTACHMENT_DATA" 
   (	"ATTACHMENT_ID" NUMBER(*,0), 
	"ATTACHMENT_DATA" BLOB
   ) ;

   COMMENT ON COLUMN "AC_UI_ATTACHMENT_DATA"."ATTACHMENT_ID" IS 'ID';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT_DATA"."ATTACHMENT_DATA" IS '첨부파일 데이터';
   COMMENT ON TABLE "AC_UI_ATTACHMENT_DATA"  IS '첨부파일 데이터 테이블';
/
--------------------------------------------------------
--  DDL for Table AC_UI_ATTACHMENT_PROPERTY
--------------------------------------------------------

  CREATE TABLE "AC_UI_ATTACHMENT_PROPERTY" 
   (	"ATTACHMENT_ID" NUMBER(*,0), 
	"PROPERTY_NAME" VARCHAR2(100 BYTE), 
	"PROPERTY_VALUE" VARCHAR2(1024 BYTE)
   ) ;

   COMMENT ON COLUMN "AC_UI_ATTACHMENT_PROPERTY"."ATTACHMENT_ID" IS '첨부파일 ID';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름';
   COMMENT ON COLUMN "AC_UI_ATTACHMENT_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값';
   COMMENT ON TABLE "AC_UI_ATTACHMENT_PROPERTY"  IS '첨부파일 프로퍼티 테이블';
/		

	-- =================================================  
	--  TAG	
	-- =================================================	
	
    CREATE TABLE AC_UI_TAG(	 
	    TAG_ID					INTEGER NOT NULL,	
	    TAG_NAME				VARCHAR2(100) NOT NULL,
	    CREATION_DATE		TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
	    CONSTRAINT AC_UI_TAG_PK PRIMARY KEY (TAG_ID)
    );
   
    CREATE UNIQUE INDEX AC_UI_TAG_IDX1 ON AC_UI_TAG( TAG_NAME ) ;	
    CREATE INDEX AC_UI_TAG_IDX2 ON AC_UI_TAG (CREATION_DATE) ;
   
    CREATE TABLE AC_UI_OBJECT_TAG(	 
    		TAG_ID					INTEGER NOT NULL,	
		OBJECT_TYPE			INTEGER NOT NULL,
		OBJECT_ID				INTEGER NOT NULL,
   		CREATION_DATE		TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
	);
    
	CREATE INDEX AC_UI_OBJECT_TAG_IDX1 ON AC_UI_OBJECT_TAG (OBJECT_ID, TAG_ID, OBJECT_TYPE) ;
    CREATE INDEX AC_UI_OBJECT_TAG_IDX2 ON AC_UI_OBJECT_TAG (TAG_ID) ;
    CREATE INDEX AC_UI_OBJECT_TAG_IDX3 ON AC_UI_OBJECT_TAG (OBJECT_TYPE, OBJECT_ID, CREATION_DATE, TAG_ID) ;
    CREATE INDEX AC_UI_OBJECT_TAG_IDX4 ON AC_UI_OBJECT_TAG (OBJECT_TYPE, TAG_ID) ;

	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : ANNOUNCE 
	-- CREATE : 2019.11.09
	-- UPDATE : 
	-- =================================================		
		CREATE TABLE AC_UI_ANNOUNCE (
			ANNOUNCE_ID				INTEGER NOT NULL,
			OBJECT_TYPE						INTEGER NOT NULL,
			OBJECT_ID							INTEGER NOT NULL,	 		
			USER_ID								INTEGER NOT NULL,	 		
			SUBJECT								VARCHAR2(255) NOT NULL,
			BODY								CLOB NOT NULL,
			START_DATE							TIMESTAMP DEFAULT  SYSTIMESTAMP NOT NULL,
			END_DATE							TIMESTAMP DEFAULT  SYSTIMESTAMP NOT NULL,
			STATUS								NUMBER(1, 0)  DEFAULT 0, 
			CREATION_DATE					DATE DEFAULT  SYSDATE NOT NULL,
			MODIFIED_DATE					DATE DEFAULT  SYSDATE NOT NULL,
			CONSTRAINT AC_UI_ANNOUNCE_PK PRIMARY KEY (ANNOUNCE_ID)
		);
		
		CREATE INDEX AC_UI_ANNOUNCE_IDX1 ON V2_USER (OBJECT_TYPE, OBJECT_ID);
		CREATE INDEX AC_UI_ANNOUNCE_IDX2 ON V2_USER (START_DATE);
		CREATE INDEX AC_UI_ANNOUNCE_IDX3 ON V2_USER (END_DATE);
		CREATE INDEX AC_UI_ANNOUNCE_IDX4 ON V2_USER (USER_ID);
		
		CREATE TABLE AC_UI_ANNOUNCE_PROPERTY (
		  ANNOUNCE_ID                     INTEGER NOT NULL,
		  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
		  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
		  CONSTRAINT AC_UI_ANNOUNCE_PROPERTY_PK PRIMARY KEY (ANNOUNCE_ID, PROPERTY_NAME)
		);	
		COMMENT ON TABLE      "AC_UI_ANNOUNCE_PROPERTY"  IS '공지 프로퍼티 테이블';
		COMMENT ON COLUMN "AC_UI_ANNOUNCE_PROPERTY"."ANNOUNCE_ID" IS '공지 ID'; 
		COMMENT ON COLUMN "AC_UI_ANNOUNCE_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
		COMMENT ON COLUMN "AC_UI_ANNOUNCE_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 		

		

	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : COMMENT 
	-- CREATE : 2019.12.04
	-- UPDATE : 
	-- =================================================	
	CREATE TABLE AC_UI_COMMENT(	
		COMMENT_ID					INTEGER NOT NULL,		
		OBJECT_TYPE					INTEGER NOT NULL,
		OBJECT_ID						INTEGER NOT NULL,
		PARENT_COMMENT_ID		INTEGER,
		PARENT_OBJECT_TYPE		INTEGER,
		PARENT_OBJECT_ID			INTEGER,
		USER_ID						INTEGER,
		NAME							VARCHAR2(100),
		EMAIL							VARCHAR2(255),
		URL								VARCHAR2(255),
		IP								VARCHAR2(15),
		BODY                            VARCHAR2(4000),
		STATUS							INTEGER NOT NULL, 
		CREATION_DATE				DATE DEFAULT  SYSDATE NOT NULL,
		MODIFIED_DATE				DATE DEFAULT  SYSDATE NOT NULL,		
		CONSTRAINT AC_UI_COMMENT_PK PRIMARY KEY (COMMENT_ID)
   );	
   
	CREATE INDEX AC_UI_COMMENT_IDX1 ON AC_UI_COMMENT (CREATION_DATE) ;
	CREATE INDEX AC_UI_COMMENT_IDX2 ON AC_UI_COMMENT (MODIFIED_DATE) ;
	CREATE INDEX AC_UI_COMMENT_IDX3 ON AC_UI_COMMENT (OBJECT_TYPE, OBJECT_ID) ;
	CREATE INDEX AC_UI_COMMENT_IDX4 ON AC_UI_COMMENT (PARENT_OBJECT_TYPE, PARENT_OBJECT_ID) ;
	CREATE INDEX AC_UI_COMMENT_IDX5 ON AC_UI_COMMENT (USER_ID) ;
	
	CREATE TABLE AC_UI_COMMENT_PROPERTY (
	  COMMENT_ID               INTEGER NOT NULL,
	  PROPERTY_NAME          VARCHAR2(100)   NOT NULL,
	  PROPERTY_VALUE         VARCHAR2(1024)  NOT NULL,
	  CONSTRAINT AC_UI_COMMENT_PROPERTY_PK PRIMARY KEY (COMMENT_ID, PROPERTY_NAME)
	);	
	
	COMMENT ON TABLE  "AC_UI_COMMENT_PROPERTY"  IS 'COMMENT 프로퍼티 테이블';
	COMMENT ON COLUMN "AC_UI_COMMENT_PROPERTY"."COMMENT_ID" IS 'COMMENT ID'; 
	COMMENT ON COLUMN "AC_UI_COMMENT_PROPERTY"."PROPERTY_NAME" IS '프로퍼티 이름'; 
	COMMENT ON COLUMN "AC_UI_COMMENT_PROPERTY"."PROPERTY_VALUE" IS '프로퍼티 값'; 		
	
	-- =================================================  
	-- PACKAGE: UI  
	-- COMPONENT : AC_UI_AUDIT_TRAIL 
	-- CREATE : 2019.12.04
	-- UPDATE : 
	-- =================================================		
	CREATE TABLE AC_UI_AUDIT_TRAIL
    (
    	AUD_USER      VARCHAR2(100) 		NOT NULL,
    	AUD_CLIENT_IP VARCHAR(15)   		NOT NULL,
    	AUD_CLIENT_USERAGENT VARCHAR2(255) 	NOT NULL,
    	AUD_SERVER_IP VARCHAR(15)   		NOT NULL,
    	AUD_RESOURCE  VARCHAR2(100) 		NOT NULL,
    	AUD_ACTION    VARCHAR2(100) 		NOT NULL,
    	APPLIC_CD     VARCHAR2(255)   		NOT NULL, 
    	AUD_DATE      TIMESTAMP     		TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    );
    
-- ===================================================== --
-- ACL Schema SQL for Oracle Database 10g+               --
-- ----------------------------------------------------- --
-- drop trigger acl_sid_id_trigger;
-- drop trigger acl_class_id_trigger;
-- drop trigger acl_object_identity_id_trigger;
-- drop trigger acl_entry_id_trigger;
-- drop sequence acl_sid_sequence;
-- drop sequence acl_class_sequence;
-- drop sequence acl_object_identity_sequence;
-- drop sequence acl_entry_sequence;
-- drop table acl_entry;
-- drop table acl_object_identity;
-- drop table acl_class;
-- drop table acl_sid;

CREATE TABLE acl_sid (
    id NUMBER(38) NOT NULL PRIMARY KEY,
    principal NUMBER(1) NOT NULL CHECK (principal in (0, 1)),
    sid NVARCHAR2(100) NOT NULL,
    CONSTRAINT unique_acl_sid UNIQUE (sid, principal)
);
CREATE SEQUENCE acl_sid_sequence START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER acl_sid_id_trigger
    BEFORE INSERT ON acl_sid
    FOR EACH ROW
BEGIN
    SELECT acl_sid_sequence.nextval INTO :new.id FROM dual;
END;

CREATE TABLE acl_class (
    id NUMBER(38) NOT NULL PRIMARY KEY,
    class NVARCHAR2(100) NOT NULL,
    CONSTRAINT uk_acl_class UNIQUE (class)
);
CREATE SEQUENCE acl_class_sequence START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER acl_class_id_trigger
    BEFORE INSERT ON acl_class
    FOR EACH ROW
BEGIN
    SELECT acl_class_sequence.nextval INTO :new.id FROM dual;
END;

CREATE TABLE acl_object_identity (
    id NUMBER(38) NOT NULL PRIMARY KEY,
    object_id_class NUMBER(38) NOT NULL,
    object_id_identity NUMBER(38) NOT NULL,
    parent_object NUMBER(38),
    owner_sid NUMBER(38),
    entries_inheriting NUMBER(1) NOT NULL CHECK (entries_inheriting in (0, 1)),
    CONSTRAINT uk_acl_object_identity UNIQUE (object_id_class, object_id_identity),
    CONSTRAINT fk_acl_object_identity_parent FOREIGN KEY (parent_object) REFERENCES acl_object_identity (id),
    CONSTRAINT fk_acl_object_identity_class FOREIGN KEY (object_id_class) REFERENCES acl_class (id),
    CONSTRAINT fk_acl_object_identity_owner FOREIGN KEY (owner_sid) REFERENCES acl_sid (id)
);
CREATE SEQUENCE acl_object_identity_sequence START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER acl_object_identity_id_trigger
    BEFORE INSERT ON acl_object_identity
    FOR EACH ROW
BEGIN
    SELECT acl_object_identity_sequence.nextval INTO :new.id FROM dual;
END;

CREATE TABLE acl_entry (
    id NUMBER(38) NOT NULL PRIMARY KEY,
    acl_object_identity NUMBER(38) NOT NULL,
    ace_order INTEGER NOT NULL,
    sid NUMBER(38) NOT NULL,
    mask INTEGER NOT NULL,
    granting NUMBER(1) NOT NULL CHECK (granting in (0, 1)),
    audit_success NUMBER(1) NOT NULL CHECK (audit_success in (0, 1)),
    audit_failure NUMBER(1) NOT NULL CHECK (audit_failure in (0, 1)),
    CONSTRAINT unique_acl_entry UNIQUE (acl_object_identity, ace_order),
    CONSTRAINT fk_acl_entry_object FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity (id),
    CONSTRAINT fk_acl_entry_acl FOREIGN KEY (sid) REFERENCES acl_sid (id)
);
CREATE SEQUENCE acl_entry_sequence START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER acl_entry_id_trigger
    BEFORE INSERT ON acl_entry
    FOR EACH ROW
BEGIN
    SELECT acl_entry_sequence.nextval INTO :new.id FROM dual;
END;
