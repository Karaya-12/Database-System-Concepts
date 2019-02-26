/*
	属于RESEARCH部门且工资高于2000的
	员工姓名和工资
	comm 同源
*/
select ename, sal
from dept join emp
	on dept.deptno=emp.deptno
where dname='RESEARCH'
union
select ename, sal
from emp
where sal > 2000


select ename, sal
from emp join dept
	on emp.deptno = dept.deptno
where dname='RESEARCH'
union
select ename, sal
from emp
where sal > 2000


/*
	职位是manager，但是工资不大于3000的
	员工信息：员工姓名，工资
*/


select ename, sal
from emp
where job='manager' and sal !> 3000


select ename, sal
from emp
where job='manager'
except
select ename, sal
from emp
where sal > 3000


/*
	查询在所有部门都设置的工作岗位（Job）
	所有部门指有员工的部门
*/

select job
from emp
where not exists (
	select deptno
	from emp
	except
	select deptno
	from emp emp_sub
	where emp.job=emp_sub.job
)


select job
from emp
where not exists (
  --B 所有部门
	select deptno
	from dept
	except
	--A 当前职位关联的部门
	select deptno
	from emp emp_sub
	where emp.job=emp_sub.job
)


select distinct job
from emp
where not exists (
	(select deptno
	 from emp)
	 except
	(select deptno
	 from emp emp_sub
	 where emp.job = emp_sub.job)
)
