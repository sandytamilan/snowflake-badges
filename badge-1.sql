use role sysadmin;
create or replace table GARDEN_PLANTS.VEGGIES.ROOT_DEPTH (
   ROOT_DEPTH_ID number(1), 
   ROOT_DEPTH_CODE text(1), 
   ROOT_DEPTH_NAME text(7), 
   UNIT_OF_MEASURE text(2),
   RANGE_MIN number(2),
   RANGE_MAX number(2)
   );
   
   alter table GARDEN_PLANTS.FLOWERS.ROOT_DEPTH rename to GARDEN_PLANTS.VEGGIES.ROOT_DEPTH;
   drop table GARDEN_PLANTS.FLOWERS.ROOT_DEPTH;
   USE WAREHOUSE COMPUTE_WH;

INSERT INTO ROOT_DEPTH (
	ROOT_DEPTH_ID ,
	ROOT_DEPTH_CODE ,
	ROOT_DEPTH_NAME ,
	UNIT_OF_MEASURE ,
	RANGE_MIN ,
	RANGE_MAX 
)

VALUES
(
    3,
    'D',
    'Deep',
    'cm',
    60,
    90
)
;

select * from ROOT_DEPTH;

create or replace table GARDEN_PLANTS.FLOWERS.ROOT_DEPTH (

   ROOT_DEPTH_CODE varchar(1), 
   ROOT_DEPTH_NAME text(7), 
   UNIT_OF_MEASURE text(2),
   RANGE_MIN int,
   RANGE_MAX number(2)
   );
   
   create table vegetable_details
(
plant_name varchar(25)
, root_depth_code varchar(1)    
);

select * from garden_plants.veggies.vegetable_details ;
delete from garden_plants.veggies.vegetable_details where plant_name='Kale';
TRUNCATE TABLE GARDEN_PLANTS.VEGGIES.VEGETABLE_DETAILS;

create file format garden_plants.veggies.PIPECOLSEP_ONEHEADROW 
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '|' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
    ;

create file format garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW 
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row  
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
    ;
    
    select * from garden_plants.veggies.vegetable_details  ;
   SHOW FILE FORMATS IN ACCOUNT;
   use role accountadmin;
create or replace api integration dora_api_integration
api_provider = aws_api_gateway
api_aws_role_arn = 'arn:aws:iam::321463406630:role/snowflakeLearnerAssumedRole'
enabled = true
api_allowed_prefixes = ('https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora');
   
   show integrations;
   
    use role accountadmin;  
create or replace external function demo_db.public.grader(
      step varchar
    , passed boolean
    , actual integer
    , expected integer
    , description varchar)
returns variant
api_integration = dora_api_integration 
context_headers = (current_timestamp,current_account, current_statement) 
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/grader'
; 
   
   use role accountadmin;
use database demo_db; --change this to a different database if you prefer
use schema public; --change this to a different schema if you prefer

select grader(step, (actual = expected), actual, expected, description) as graded_results from
(SELECT 
 'DORA_IS_WORKING' as step
 ,(select 123) as actual
 ,123 as expected
 ,'Dora is working!' as description
); 

SELECT * 
FROM GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES;

-- changing/altering schemas
--Typo:     ALTER SCHEMA GARDEN_PLANTS.WEGGIES RENAME TO GARDEN_PLANTS.VEGGIES;

--Wrong Place:   ALTER SCHEMA DEMO_DB.VEGGIES RENAME TO GARDEN_PLANTS.VEGGIES;

SELECT * 
FROM GARDEN_PLANTS.INFORMATION_SCHEMA.SCHEMATA
where schema_name in ('FLOWERS','FRUITS','VEGGIES'); 

SELECT count(*) as SCHEMAS_FOUND, '3' as SCHEMAS_EXPECTED 
FROM GARDEN_PLANTS.INFORMATION_SCHEMA.SCHEMATA
where schema_name in ('FLOWERS','FRUITS','VEGGIES'); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT
 'DWW01' as step
 ,( select count(*)  
   from GARDEN_PLANTS.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name in ('FLOWERS','VEGGIES','FRUITS')) as actual
  ,3 as expected
  ,'Created 3 Garden Plant schemas' as description
); 



use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;

--Do NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW02' as step 
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name = 'PUBLIC') as actual 
 , 0 as expected 
 ,'Deleted PUBLIC schema.' as description
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW03' as step 
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
   where table_name = 'ROOT_DEPTH') as actual 
 , 1 as expected 
 ,'ROOT_DEPTH Table Exists' as description
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW04' as step
 ,( select count(*) as SCHEMAS_FOUND 
   from UTIL_DB.INFORMATION_SCHEMA.SCHEMATA) as actual
 , 2 as expected
 , 'UTIL_DB Schemas' as description
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW05' as step
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
   where table_name = 'VEGETABLE_DETAILS') as actual
 , 1 as expected
 ,'VEGETABLE_DETAILS Table' as description
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from ( 
 SELECT 'DWW06' as step 
,( select row_count 
  from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
  where table_name = 'ROOT_DEPTH') as actual 
, 3 as expected 
,'ROOT_DEPTH row count' as description
);  

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW07' as step
 ,( select row_count 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
   where table_name = 'VEGETABLE_DETAILS') as actual
 , 41 as expected
 , 'VEG_DETAILS row count' as description
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from ( 
   SELECT 'DWW08' as step 
   ,( select count(*) 
     from GARDEN_PLANTS.INFORMATION_SCHEMA.FILE_FORMATS 
     where FIELD_DELIMITER =',' 
     and FIELD_OPTIONALLY_ENCLOSED_BY ='"') as actual 
   , 1 as expected 
   , 'File Format 1 Exists' as description 
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW09' as step
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.FILE_FORMATS 
   where FIELD_DELIMITER ='|' 
   ) as actual
 , 1 as expected
 ,'File Format 2 Exists' as description
); 

 create stage garden_plants.veggies.like_a_window_into_an_s3_bucket 
 url = 's3://uni-lab-files';
 
 list @like_a_window_into_an_s3_bucket;
 
use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
 select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW10' as step
  ,(select count(*) 
    from GARDEN_PLANTS.INFORMATION_SCHEMA.stages
    where stage_url='s3://uni-lab-files' 
    and stage_type='External Named') as actual
  , 1 as expected
  , 'External stage created' as description
 ); 

use database garden_plants;
use schema veggies;
use role sysadmin;
 create or replace table vegetable_details_soil_type
( plant_name varchar(25)
 ,soil_type number(1,0)
);

copy into vegetable_details_soil_type
from @like_a_window_into_an_s3_bucket
files = ( 'VEG_NAME_TO_SOIL_TYPE_PIPE.txt')
file_format = ( format_name=PIPECOLSEP_ONEHEADROW );

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DWW11' as step
  ,(select row_count 
    from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
    where table_name = 'VEGETABLE_DETAILS_SOIL_TYPE') as actual
  , 42 as expected
  , 'Veg Det Soil Type Count' as description
 ); 
 
 use database garden_plants;
use schema veggies;
use role sysadmin;
 select $1
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv;

--Same file but with one of the file formats we created earlier  
select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW);

--Same file but with the other file format we created earlier
select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.PIPECOLSEP_ONEHEADROW );

create file format garden_plants.veggies.L8_CHALLENGE_FF
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '\t' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
    ;
    
    select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.L8_CHALLENGE_FF );

create or replace table LU_SOIL_TYPE(
SOIL_TYPE_ID number,	
SOIL_TYPE varchar(15),
SOIL_DESCRIPTION varchar(75)
 );
 
 copy into LU_SOIL_TYPE
from @like_a_window_into_an_s3_bucket
files = ( 'LU_SOIL_TYPE.tsv')
file_format = ( format_name=L8_CHALLENGE_FF );

select * from garden_plants.veggies.lu_soil_type;

create or replace table VEGETABLE_DETAILS_PLANT_HEIGHT(
PLANT_NAME varchar(25),	
UOM char,
LOW_END_OF_RANGE number,
HIGH_END_OF_RANGE number    
 );
 
     select $1, $2, $3
from @garden_plants.veggies.like_a_window_into_an_s3_bucket/veg_plant_height.csv
(file_format => garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW );

 copy into VEGETABLE_DETAILS_PLANT_HEIGHT
from @like_a_window_into_an_s3_bucket
files = ( 'veg_plant_height.csv')
file_format = ( format_name=COMMASEP_DBLQUOT_ONEHEADROW  );

select * from garden_plants.veggies.vegetable_details_plant_height;


use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (  
      SELECT 'DWW12' as step 
      ,(select row_count 
        from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
        where table_name = 'VEGETABLE_DETAILS_PLANT_HEIGHT') as actual 
      , 41 as expected 
      , 'Veg Detail Plant Height Count' as description   
); 


use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (  
     SELECT 'DWW13' as step 
     ,(select row_count 
       from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
       where table_name = 'LU_SOIL_TYPE') as actual 
     , 8 as expected 
     ,'Soil Type Look Up Table' as description   
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from ( 
     SELECT 'DWW14' as step 
     ,(select count(*) 
       from GARDEN_PLANTS.INFORMATION_SCHEMA.FILE_FORMATS 
       where FILE_FORMAT_NAME='L8_CHALLENGE_FF' 
       and FIELD_DELIMITER = '\t') as actual 
     , 1 as expected 
     ,'Challenge File Format Created' as description  
); 





use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (  
     SELECT 'DWW15' as step 
     ,(select count(*) 
      from LIBRARY_CARD_CATALOG.PUBLIC.Book_to_Author ba 
      join LIBRARY_CARD_CATALOG.PUBLIC.author a 
      on ba.author_uid = a.author_uid 
      join LIBRARY_CARD_CATALOG.PUBLIC.book b 
      on b.book_uid=ba.book_uid) as actual 
     , 6 as expected 
     , '3NF DB was Created.' as description  
); 

use database DEMO_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;
 select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT 'DWW16' as step
  ,(select row_count 
    from LIBRARY_CARD_CATALOG.INFORMATION_SCHEMA.TABLES 
    where table_name = 'AUTHOR_INGEST_JSON') as actual
  ,6 as expected
  ,'Check number of rows' as description
 ); 
 
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (   
     SELECT 'DWW17' as step 
      ,(select row_count 
        from LIBRARY_CARD_CATALOG.INFORMATION_SCHEMA.TABLES 
        where table_name = 'NESTED_INGEST_JSON') as actual 
      , 5 as expected 
      ,'Check number of rows' as description  
); 

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
   SELECT 'DWW18' as step
  ,(select row_count 
    from SOCIAL_MEDIA_FLOODGATES.INFORMATION_SCHEMA.TABLES 
    where table_name = 'TWEET_INGEST') as actual
  , 9 as expected
  ,'Check number of rows' as description  
 );
 
 select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT 'DWW19' as step
  ,(select count(*) 
    from SOCIAL_MEDIA_FLOODGATES.INFORMATION_SCHEMA.VIEWS 
    where table_name = 'HASHTAGS_NORMALIZED') as actual
  , 1 as expected
  ,'Check number of rows' as description
 ); 
 
 select current_account();
 
 select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DORA_IS_WORKING' as step
 ,(select 223) as actual
 , 223 as expected
 ,'Dora is working!' as description
); 
