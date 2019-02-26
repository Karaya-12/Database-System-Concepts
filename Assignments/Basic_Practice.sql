/*Practice No.1*/
CREATE TABLE DBSConcepts.dbo.DEPT
(
    DEPTNO int NOT NULL,
    DNAME  varchar(20),
    LOC    varchar(20),
    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
)

CREATE TABLE DBSConcepts.dbo.EMP
(
    EMPNO    int NOT NULL,
    ENAME    varchar(20),
    JOB      varchar(20),
    MGR      int,
    HIREDATE DATETIME,
    SAL      int,
    COMM     float,
    DEPTNO    int,
    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
    CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DBSConcepts.dbo.DEPT (DEPTNO)
)

CREATE TABLE BONUS
(
    ENAME varchar(20),
    JOB		varchar(20),
    SAL		int,
    COMM	int
)

CREATE TABLE SALGRADE
(
    GRADE int,
    LOSAL int,
    HISAL int
)


/*Practice No.2*/
INSERT INTO DEPT VALUES
(10, 'ACCOUNTING', 'NEW YORK')
INSERT INTO DEPT VALUES
(20, 'RESEARCH', 'DALLAS')
INSERT INTO DEPT VALUES
(30, 'SALES', 'CHICAGO')
INSERT INTO DEPT VALUES
(40, 'OPERATIONS', 'BOSTON')

INSERT INTO EMP VALUES
(7369, 'SMITH', 'CLERK', 7566, '1980-12-17', 800, NULL, 20)
INSERT INTO EMP VALUES
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30)
INSERT INTO EMP VALUES
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30)
INSERT INTO EMP VALUES
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20)
INSERT INTO EMP VALUES
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30)
INSERT INTO EMP VALUES
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30)
INSERT INTO EMP VALUES
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10)
INSERT INTO EMP VALUES
(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-13', 3000, NULL, 20)
INSERT INTO EMP VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10)
INSERT INTO EMP VALUES
(7844, 'TURN...', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30)
INSERT INTO EMP VALUES
(7876, 'ADAMS', 'CLERK', 7788, '1987-06-13', 1100, NULL, 20)
INSERT INTO EMP VALUES
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30)
INSERT INTO EMP VALUES
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10)

INSERT INTO SALGRADE VALUES
(1, 700, 1200)
INSERT INTO SALGRADE VALUES
(2, 1201, 1400)
INSERT INTO SALGRADE VALUES
(3, 1401, 2000)
INSERT INTO SALGRADE VALUES
(4, 2001, 3000)
INSERT INTO SALGRADE VALUES
(5, 3001, 9999)


/*Practice No.3*/
select ENAME, (sal + sal / 10) sal, comm
from EMP


/*Practive No.4*/
select ENAME, JOB, HIREDATE, SAL
from EMP
where DEPTNO = 10


/*Practice No.5*/
select distinct JOB
from EMP


/*Practice No.6*/
select ENAME,(sal * 12) Annual_Salary
from EMP


/*Practice No.7*/
select ENAME, (SAL + isnull(comm, 0)) Total  --isnull(e1, e2) --> If e1 is null, return e2
from EMP


/*Practice No.8*/
select ENAME, SAL
from EMP
where JOB = 'manager'


/*Practice No.9*/
select ENAME, SAL
from EMP
where ENAME like '__O%'  --Refer to Page 78 -> 3.4.2 String Operations


/*Practice No.10*/
select ENAME, SAL, JOB
from EMP
where JOB in ('Salesman', 'Manager')
--where JOB = 'Salesman' or JOB = 'Manager'


/*Practice No.11*/
select ENAME
from EMP
where COMM is null  --Refer to Page 85 -> 3.6 Null Values


/*Practice No.12*/
select ENAME, SAL, COMM
from EMP
where COMM is not null


/*Practice No.13*/
select ENAME, SAL
from EMP
order by SAL desc


/*Practice No.14*/
select max(SAL) Max_Salary, min(SAL) Min_Salary
from EMP


/*Practice No.15*/
select avg(SAL) Avg_Salary, sum(SAL) Total_Salary
from EMP


/*Practice No.16*/
select cast(cast(count(COMM) as float) / count(*) as decimal(18,14)) Percentage
--count(*) -> Count Row Numbers, count(column) -> Count Not Null Row Number
--cast(exp as float / double...), cast(exp as decimal(xx, xx)
from EMP


/**Practice No.17*/
select distinct JOB, avg(SAL) Avg_Salary
from EMP
group by JOB


/**Practice No.18*/
select DEPTNO, JOB, avg(SAL) Avg_Salary, max(SAL) Max_Salary
from EMP
group by JOB, DEPTNO
order by JOB asc, DEPTNO asc


/*Practice No.19*/
select DEPTNO, avg(SAL) Avg_Salary, max(SAL) Max_Salary
from EMP
group by DEPTNO
having avg(SAL) < 2500
order by DEPTNO asc


/*Practice No.20*/
select DEPTNO, avg(SAL) Avg_Salary, max(SAL) Max_Salary
from EMP
group by DEPTNO
having avg(SAL) < 2500
order by Avg_Salary asc  --'avg(SAL)' Will Also Be Practical


/*Practice No.21*/
select ENAME, SAL, JOB, DEPTNO
from EMP
where SAL > 2500 or JOB = 'Manager'


/*Practice No.22*/
select ENAME, DEPTNO, SAL
from EMP
order by DEPTNO asc, SAL desc, HIREDATE asc


/*Pactice No.23*/
select DNAME, ENAME
from EMP join DEPT on emp.DEPTNO = dept.DEPTNO


/*Practice No.24*/
--Approach I --> Scala Subquery
select ENAME
from EMP
where JOB = 'Manager' and DEPTNO = (
    select DEPTNO
    from EMP
    where ENAME = 'SCOTT'
    )

--Approach II --> Self 'join'
select E1.ENAME
from EMP as E1 join EMP as E2 on E1.DEPTNO = E2.DEPTNO
where E1.ENAME = 'SCOTT' and E2.JOB = 'Manager'


/*Practice No.25*/
--left join
select DNAME, ENAME
from DEPT left join EMP on DEPT.DEPTNO = EMP.DEPTNO  --'left join' -> Department Operation Has No Employee !
order by DNAME asc

--right join
select DNAME, ENAME
from EMP right join DEPT on DEPT.DEPTNO = EMP.DEPTNO  --'right join' -> Department Operation Has No Employee !
order by DNAME asc


/*Practice No.26*/
select ENAME, SAL, (
    select GRADE
    from SALGRADE
    where SAL between LOSAL and HISAL
    )
from EMP
order by SAL


/*Practice No.27*/
select ENAME, SAL
from EMP
where EMP.DEPTNO = (
    select DEPTNO
    from DEPT
    where DNAME = 'Accounting'
    )
order by ENAME


/*Practice No.28*/
select ENAME, JOB, SAL, DEPTNO
from EMP
where JOB in (
    select JOB
    from EMP
    where EMP.DEPTNO = 10
    )


/*Practice No.29*/
select ENAME, SAL, DEPTNO
from EMP
where SAL > all(
    select SAL
    from EMP
    where DEPTNO = 30
    )


/*Additional Practice*/
select DNAME, LOC
from DEPT
where DEPTNO in (
    select DEPTNO
    from EMP
    where SAL between (
        select LOSAL
        from SALGRADE
        where GRADE = 4
        ) and (
            select HISAL
            from SALGRADE
            where GRADE = 4
            )
    )

-- Another Approach
SELECT DNAME, LOC
FROM DEPT join (EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL) ON DEPT.DEPTNO = EMP.DEPTNO
WHERE GRADE = 5


/*Practice No.30*/
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > 2500
UNION
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'Manager'


/*Pratice No.31*/
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > 2500
INTERSECT
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'Manager'


/*Practice No.32*/
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > 2500
EXCEPT
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'Manager'
