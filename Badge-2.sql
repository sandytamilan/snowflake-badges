select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW01' as step
 ,(select count(*) 
   from PC_RIVERY_DB.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name ='PUBLIC') as actual
 , 1 as expected
 ,'Rivery is set up' as description
);

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW02' as step
 ,(select count(*) FDCID, DESCRIPTION, LOWERCASEDESCRIPTION, DATATYPE, GTINUPC, PUBLISHEDDATE, BRANDOWNER, BRANDNAME, INGREDIENTS, MARKETCOUNTRY, FOODCATEGORY, MODIFIEDDATE, DATASOURCE, PACKAGEWEIGHT, SERVINGSIZEUNIT, SERVINGSIZE, TRADECHANNELS, ALLHIGHLIGHTFIELDS, SCORE, FOODNUTRIENTS, HOUSEHOLDSERVINGFULLTEXT, SUBBRANDNAME, SHORTDESCRIPTION, COMMONNAMES, ADDITIONALDESCRIPTIONS, FOODCODE, FOODCATEGORYID, FINALFOODINPUTFOODS, FOODMEASURES, FOODATTRIBUTETYPES, NDBNUMBER, MOSTRECENTACQUISITIONDATE
   from PC_RIVERY_DB.INFORMATION_SCHEMA.TABLES 
   where ((table_name ilike '%FORM%') 
   and (table_name ilike '%RESULT%'))) as actual
 , 1 as expected
 ,'Rivery form results table is set up' as description
);

select * from pc_rivery_db.public.fdc_food_ingest;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW03' as step
 ,(select sum(round(nutritions_sugar)) 
   from PC_RIVERY_DB.PUBLIC.FRUITYVICE) as actual
 , 35 as expected
 ,'Fruityvice table is perfectly loaded' as description
);

truncate table PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST;


select *
from PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST
;



select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW04' as step
 ,(select count(*) 
   from pc_rivery_db.public.fdc_food_ingest
   where lowercasedescription like '%cheddar%') as actual
 , 50 as expected
 ,'FDC_FOOD_INGEST Cheddar 50' as description
);



select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW05' as step
 ,(select count(*) 
   from pc_rivery_db.public.fdc_food_ingest) as actual
 , 927 as expected
 ,'All the fruits!' as description
);


show stages in account;


list @my_internal_named_stage;


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW06' as step
 ,(select count(distinct METADATA$FILENAME) 
   from @demo_db.public.my_internal_named_stage) as actual
 , 3 as expected
 ,'I PUT 3 files!' as description
);

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
   SELECT 'DABW07' as step 
   ,(select count(*) 
     from pc_rivery_db.public.fruit_load_list 
     where fruit_name in ('jackfruit','papaya', 'kiwi', 'test', 'from streamlit', 'guava')) as actual 
   , 4 as expected 
   ,'Followed challenge lab directions' as description
); 



------------------------------------cloning-----------------------------
use role pc_rivery_role;
use database pc_rivery_db;
use schema public;

create table L7_end_fdc_food_ingest
clone fdc_food_ingest;

use role pc_rivery_role;
use database pc_rivery_db;
use schema public;

create table L8_orange_fdc_food_ingest
clone fdc_food_ingest;


use role pc_rivery_role;
use database pc_rivery_db;
use schema public;

create table L10_environment_fdc_food_ingest
clone fdc_food_ingest;

use role pc_rivery_role;
use database pc_rivery_db;
use schema public;

create table L11_environment_fdc_food_ingest
clone fdc_food_ingest;

create or replace table FRUIT_LOAD_LIST
(
FRUIT_NAME  VARCHAR(25)
);

insert into pc_rivery_db.public.fruit_load_list
values 
('banana')
,('cherry')
,('strawberry')
,('pineapple')
,('apple')
,('mango')
,('coconut')
,('plum')
,('avocado')
,('starfruit');

insert into fruit_load_list values ('test'),('from streamlit');

select * from fruit_load_list;

delete from fruit_load_list where fruit_name like 'test' or fruit_name like 'from streamlit';

