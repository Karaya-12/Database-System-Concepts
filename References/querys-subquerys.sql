/*
	查询员工数大于5的部门，并给出部门名称和员工数量
*/

select dname, count(*) cnt
from emp join dept on emp.deptno=dept.deptno
group by dept.dname
having count(*) > 5


/*
	属于科研部门（RESEARCH）的所有员工信息:
	员工姓名，工资
	on predicate
*/

select ename, sal
from emp, dept
where emp.deptno=dept.deptno
	and dept.dname='RESEARCH'


select ename, sal
from emp
where exists (
	select *
	from dept
	where dept.dname='RESEARCH'
		and emp.deptno = dept.deptno
)


select ename, sal
from emp
where deptno in (
	select deptno
	from dept
	where dname='RESEARCH'
	)


select ename, sal
from emp
where exists (
	select *
	from dept
	where emp.deptno=dept.deptno
			and dname='RESEARCH'
)


/*
	查找员工信息：姓名，部门号，工资
	满足
	他的工资比他所在部门的平均工资高

	分两步走试试？
*/

select ename, sal, deptno
from emp
where sal > (
	select avg(sal)
	from emp emp_sub
	where emp.deptno = emp_sub.deptno
)


select deptno, avg(sal) avg_sal
from emp
group by deptno

select ename, sal, emp.deptno
from emp join (
		select deptno, avg(sal) avg_sal
		from emp
		group by deptno
		) as emp_sal on emp.deptno = emp_sal.deptno
where emp.sal > avg_sal


--select ename, deptno, sal
--from emp
--where exists  (
--	select *
--	from emp emp_sub
--	group by deptno
--	having emp.sal > avg(sal)
--	and emp.deptno = emp_sub.deptno
--)
--order by sal desc


/*
	for (i = 0; i < length(emp); i ++){
		sal_list = []
		for (j = 0; j < length(sub_emp); j ++){
			if (sub_emp[j].deptno == emp[i].deptno){
				sal_list.add(sub_emp[j].sal)
			}
		}
		avg_sal = avg(sal_list)
		if (emp[i].sal > avg_sal){
			print emp[i]
		}
	}
*/

with emp_sal as
		(select deptno, avg(sal) avg_sal
		from emp
		group by deptno)

select ename, sal, emp.deptno
from emp join emp_sal on emp.deptno=emp_sal.deptno
where emp.sal > emp_sal.avg_sal


/*
	给出员工信息，包括：
	员工姓名，工资，所在部门平均工资。
	标量子查询
*/

select ename, sal, (
	select avg(sal)
	from emp emp_sub
	where emp.deptno = emp_sub.deptno
	) avg_sal
from emp


select ename, sal, (select avg(sal)
					from emp emp_sub
					where emp_sub.deptno=emp.deptno) avg_sal
from emp


/*
	在所有非20号部门的员工中
	工资比20号部门中的员工高的
	员工信息：员工姓名，部门号，员工工资
*/

select ename, deptno, sal
from emp
where sal > some (
	select sal
	from emp
	where deptno=20
)
and deptno<>20


/*
	包含工资等级为4的员工部门信息：
	部门名称，部门所在地
*/


select dname, loc
from dept join (emp join salgrade
		on sal between losal and hisal)
		on dept.deptno=emp.deptno
where grade=5


select dname,loc
from dept
where deptno in (
	select deptno
	from emp join salgrade
		on sal between losal and hisal
	where grade=4
)


/*
	在所有非20号部门的员工中
	工资比20号部门中的所有的个员工高的
	员工信息：员工姓名，部门号，员工工资
*/
select ename, deptno, sal
from emp
where sal > all (
	select sal
	from emp
	where deptno=20
)
and deptno<>20


/*
	找出非20号部门的员工中
	没有一个20号部门的员工的工资是比他高的

*/
select ename, deptno, sal
from emp
where not exists(
	select *
	from emp emp_sub
	where emp_sub.deptno=20
		and emp_sub.sal > emp.sal
)
and emp.deptno!=20


select ename, deptno, sal
from emp
where not exists (
	select *
	from emp emp_sub
	where emp_sub.deptno=20
		and emp_sub.sal > emp.sal
)
and emp.deptno<>20
