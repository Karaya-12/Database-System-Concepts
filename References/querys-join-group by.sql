/*
   所有的员工和他所在的部门名和部门ID
   所有的部门和该部门工作的员工姓名
   测试在外链接的时候，on和where的不同 1=2问题
*/

--select ename, dname, emp.deptno, dept.deptno
--from dept right join emp on 1=2

/*
	每个员工的姓名，员工的部门名称，员工的工资等级
*/

--select ename, dname, sal, grade sal_grade
--from (emp join dept on emp.deptno=dept.deptno) join salgrade on sal between losal and hisal
--from (emp join salgrade on emp.sal between losal and hisal) join dept on emp.deptno=dept.deptno
--from emp, dept, salgrade
--where emp.deptno=dept.deptno and emp.sal between salgrade.losal and salgrade.hisal

/*
	员工姓名，员工工资，上级领导姓名，上级领导工资
*/

--select top 3 emp.ename, emp.sal, mgr.ename, mgr.sal
--from emp join emp mgr on emp.mgr = mgr.empno

--select empno, ename, mgr, sal
--from emp

/*
	group by 每个系的平均工资,平均补助，等
	聚集函数对null的理解
*/

--select deptno, avg(sal) avg_sal, avg(comm) avg_comm, count(*) cnt_comm
--from emp
--group by deptno

--select ename, sal, comm, deptno
--from emp
--where deptno=30

/*
	查询每个人的总收入：工资+佣金
	isnull
*/

--select ename, sal, comm, sal+isnull(comm,0) income
--from emp

/*
	查询每个员工的工资比上佣金的倍数 sal/comm
	nullif
*/

--select ename, sal, comm, sal/nullif(comm,0) rate
--from emp

--select ename, sal, comm
--from emp

/*
	佣金小于500块的员工的姓名和佣金
*/


select ename, comm
from emp
where comm < 500 or comm is null

/*
	部门的名称和对应的平均工资,多属性
	having 平均工资 oder by
	顺序强调一下，avg(sal) 与 avg_sal
*/

select dname, avg(sal) avg_sal
from emp join dept on emp.deptno=dept.deptno
group by dept.dname
order by avg_sal desc