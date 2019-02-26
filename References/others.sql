-- 1
select 
 case 
	when 1>1 then '正确1'
	when 1=1 then '正确2'
	when 1<1 then '正确3'
 end


-- 2
select * from dept
union
select * from dept
order by deptno


-- 3
select count(*)
from emp
where (1=1 or 2>1) and 1=2


/* rank|dense_rank|row_number|ntile */
select  rank() over(order by sal) rk, ename, sal
from emp

select count(*) rk, e1.ename, e1.sal
from emp e1, emp e2
where e1.sal >= e2.sal
group by e1.ename, e1.sal


/*
	查询员工的工资水平，用百分比给出每个员工工资的梯队。
	即，排在0-25%，25-50%，50-75%，75-100%之中
*/
select  ename, sal, case
					  when ntile(4) over(order by sal) = 1 then '0-25%'
					  when ntile(4) over(order by sal) = 2 then '25-50%'
					  when ntile(4) over(order by sal) = 3 then '50-75%'
					  else '75-100%'
					end per
from emp


/*
	手动实现排序：
	小于等于当前值得个数就是当前值得排名。
*/

select count(*) rk, e1.ename, e1.sal
from emp e1 , emp e2
where e1.sal >= e2.sal
group by e1.ename, e1.sal

select count(*) rk, e1.ename, e1.sal
from emp e1 , emp e2
where e1.sal >= e2.sal
group by e1.ename, e1.sal


/*分页技能*/
select *
from (select row_number() over(order by sal) rk, empno, ename, sal
		from emp) temp
where temp.rk between 6 and 10


/*
	给出每个部门中各个职位（job）的分布情况。
	deptno，job1_number, job2_number, ...
*/
select distinct job
from emp
order by deptno

with a as(
select empno,deptno
		,case job when 'ANALYST' then 1 end ANALYST
		,case job when 'SALESMAN' then 1 end SALESMAN
		,case job when 'MANAGER' then 1 end MANAGER
		,case job when 'PRESIDENT' then 1 end PRESIDENT
		,case job when 'CLERK' then 1 end CLERK
from emp)

select deptno,  isnull(sum(ANALYST),0) ANALYST,
				isnull(sum(SALESMAN),0) SALESMAN,
				isnull(sum(MANAGER),0) MANAGER,
				isnull(sum(PRESIDENT),0) PRESIDENT,
				isnull(sum(CLERK),0) CLERK
from a group by deptno

select dname, sum(isnull(sal,0)) salcomm
from dept left join emp on dept.deptno=emp.deptno
group by dname
order by case dname when 'RESEARCH' then 1
				else 2 end, sum(comm)