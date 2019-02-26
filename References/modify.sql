delete from bonus
insert into bonus(ename, job, sal, comm)
select ename, job, sal, comm
from emp

/*基本的增删改*/
select *
from bonus

update bonus
set ename='李'
where sal > 2000

/*今年只有RESEARCH部门有奖金，因此将用RESEARCH部门的相关信息填充bonus表*/


/*在bonus表中，删除工资大于所有员工平均工资的信息*/
delete from bonus
where sal > (
	select avg(sal)
	from emp
)

select *
from emp

delete from bonus
where sal > (
	select avg(sal)
	from emp
)


/*
	工资大于3000的，加薪十分之一
	工资小于3000的，加薪十二分二
*/

select ename, sal
from bonus
where ename='Jones'

update bonus
set sal = sal * 1.2
where sal <= 3000

update bonus
set sal = sal * 1.1
where sal > 3000

/*
CASE
    WHEN ... THEN ...
    ELSE ...
END
*/
update bonus
set sal = (
		case
			when sal < 3000 then sal * 1.1
			else sal * 1.2
		end
)


/*使用CASE WHEN进行行列转换*/
-- Attention !!!!
WITH TEMP AS (
    SELECT EMPNO, DEPTNO,
           CASE job WHEN 'Clerk'     THEN 1 END Clerk,
           CASE job WHEN 'Analyst'   THEN 1 END Analyst,
           CASE job WHEN 'Manager'   THEN 1 END Manager,
           CASE job WHEN 'Salesman'  THEN 1 END Salesman,
           CASE job WHEN 'President' THEN 1 END President
    FROM EMP)

SELECT DEPTNO, ISNULL(sum(ANALYST), 0) ANALYST,
       ISNULL(sum(SALESMAN), 0) SALESMAN, ISNULL(sum(MANAGER), 0) MANAGER,
       ISNULL(sum(PRESIDENT), 0) PRESIDENT, ISNULL(sum(CLERK), 0) CLERK
FROM TEMP
GROUP BY DEPTNO