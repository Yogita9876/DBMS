
----------------------------------------------

-- Team Number: 5
-- Team Members: Bader Albulayhis, Yogita Singh
-- My SQL Statements

-- 

INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('EMPLOYEE');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('SSN', 'N');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('FULL_NAME', 'Y' );

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('HRS', 'N' );

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('SSN','EMPLOYEE','NUMBER','TEST','Y','PRIMARY',10,5,10);

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('FNAME','EMPLOYEE','CHAR','TEST','N','',10,5,10);


INSERT INTO REL_TYPE(RNAME,TYPE)
VALUES ('HAS','BINARY');

INSERT INTO REL_TYPE(RNAME,TYPE)
VALUES ('WORKS_ON,'TERNARY');

INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('HAS','EMPLOYEE','WORKER','M','1','M');

INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('WORKS_ON','EMPLOYEE','PROJECT_MEMBER','M','1','M');


-----------------------------
Specialization
-----------------------------

INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('HOURLY');

INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('SALARIED');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('RATE', 'N');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('SALARY', 'Y' );

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('RATE','HOURLY','NUMBER','TEST','N','',10,5,10);

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('SALARY','SALARIED','NUMBER','TEST','N','',10,5,10);


INSERT INTO REL_TYPE(RNAME,TYPE)
VALUES ('ISA','SUB');

INSERT INTO SPECIALIZATION (SNAME,ENAME,TOTAL,OVERLAPPING)
VALUES ('EMP_SPCL','EMPLOYEE','Y','N');

INSERT INTO SUB (ENAME,SNAME)
VALUES ('HOURLY','EMP_SPCL');

INSERT INTO SUB (ENAME,SNAME)
VALUES ('SALARIED','EMP_SPCL');

--------------------------------------------------------------------


INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('DEPARTMENT');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('DEPT_NUM','N');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('DEPT_NAME', 'Y');


INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('DEPT_NUM','DEPARTMENT','NUMBER','TEST','Y','PRIMARY',10,5,10);

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('DEP_NAME','DEPARTMENT','CHAR','TEST','N','NULL',20,0,10);

INSERT INTO REL_TYPE(RNAME,TYPE)
VALUES ('OWNS','BINARY');


INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('HAS','DEPARTMENT','GOVERNS','1','1','1');

INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('OWNS','DEPARTMENT','PROJECT_CONTROL','M','1','M');



--------------------------------------

INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('PROJECT');


INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('PNAME','Y');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('PNUMBER','N');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('BUDGET','N');

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('PNAME','PROJECT','CHAR','TEST','N','',10,5,10);

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('PNUMBER','PROJECT','NUMBER','TEST','Y','PRIMARY',10,5,10);


INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('OWNS','PROJECT','GOVERNED_BY','M','0','M');

INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('WORKS_ON','PROJECT','EMP_ASSIGNMENT','M','0','M');


----------------------------------------------


INSERT INTO ENTITY_TYPE(ENAME)
VALUES ('CLIENT');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('CNUM', 'N');

INSERT INTO ATTR_TYPE (ANAME,MULTI_VALUED)
VALUES ('CNAME', 'Y' );

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('CNUM','CLIENT','NUMBER','TEST','Y','PRIMARY',10,5,10);

INSERT INTO CONTAINS (ANAME,ENAME,DATA_TYPE,DOMAIN,IS_KEY ,KEY_TYPE,LENGTH,PRECISION,SCALE)
VALUES ('CNAME','CLIENT','CHAR','TEST','N','',10,5,10);


INSERT INTO RELATES (RNAME,ENAME,ROLE,CARDINALITY,MIN_CARD,MAX_CARD)
VALUES ('WORKS_ON','CLIENT','SEES','M','0','M');

----------------------------------------------------------

INSERT INTO IS_USED_BY (RNAME,ANAME,DATA_TYPE,DOMAIN,LENGTH,PRECISION,SCALE)
VALUES ('WORKS_ON','HRS','NUMBER','TEST',10,5,10);

INSERT INTO IS_USED_BY (RNAME,ANAME,DATA_TYPE,DOMAIN,LENGTH,PRECISION,SCALE)
VALUES ('OWNS','BUDGET','NUMBER','TEST',10,5,10);





Q1 /

Create view Ent_rel_2m as 
Select distinct contains.ENAME,contains.ANAME,contains.DATA_TYPE
from contains,RELATES 
where contains.ename=RELATES.ename and contains.ename in 
(select ename
from RELATES
where lower (CARDINALITY) = 'm'
having count(Ename)>=2
group by ename);





Q2/ 
	 
-- covering the case if the relation doesn't have an attribute
Create view Rel_Att_0_key as 	 
SELECT r.rname, i.aname,i.data_type
FROM IS_USED_BY i RIGHT OUTER JOIN relates r 
ON i.rname = r.rname
where r.ename not in (select ename from contains where (lower (KEY_TYPE) ='primary' or lower (KEY_TYPE) ='candidates'))





Q3/ 

Create view Rel_3Ent as
select rname,ename
from relates
where rname in (
                 select rname 
                 from relates  
				 group by rname
				 having count (rname)=3
				 );
      
	  
	  
	 


	 
	  
Q4/ 

-- covering the case if the sub entity doesn't have an attribute
create view Spec_Ent_both as 
Select s.ename ,c.aname
from SPECIALIZATION s,contains c
where s.ename=c.ename
union
Select s.ename ,c.aname
from sub s left OUTER JOIN contains c
ON s.ename=c.ename










