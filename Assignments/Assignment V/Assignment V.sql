-- Question I
-- 查找10号部门的员工的所有信息
SELECT *
FROM EMP
WHERE DEPTNO = 10

-- Question II
-- 查找10号部门工资大于3500的员工姓名，工资
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 10
  AND SAL > 3500

-- Question III
-- 查询所有的名称，即员工名称及部门名称，要求最终查询结果中只有一列，所有名称都在该列中
SELECT ENAME AS Name
FROM EMP
UNION
SELECT DNAME AS Name
FROM DEPT

-- Question IV
-- 查询10号部门及20号部门的员工（两种方式）
-- Approach I
SELECT ENAME
FROM EMP
WHERE DEPTNO IN (10, 20)
-- Approach II
SELECT ENAME
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT ENAME
FROM EMP
WHERE DEPTNO = 20

-- Question V
-- 找到每个员工的姓名，所在部门的名称及工作地点（使用自然连接和theta连接两种方式。）
-- Approach I -> Natural Join
SELECT ENAME, DNAME, LOC
FROM EMP JOIN DEPT ON (EMP.DEPTNO = DEPT.DEPTNO)
-- Approach II -> Theta Join
SELECT ENAME, DNAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO

-- Question VI
-- 找到每个员工的员工姓名及其直接领导的姓名
SELECT e1.ENAME, ISNULL(e2.ENAME, 'NA') AS MGR
FROM EMP e1 LEFT JOIN EMP e2 ON (e1.MGR = e2.EMPNO)

-- Question VII
-- 查找平均工资大于2500的部门名称
SELECT DNAME
FROM DEPT JOIN EMP ON (DEPT.DEPTNO = EMP.DEPTNO)
GROUP BY DNAME
HAVING AVG(SAL) > 2500

-- Question VIII
-- 查找在平均工资大于2500的部门工作的员工
-- Approach I -> IN Clause (Suitable for SQL)
SELECT ENAME
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                GROUP BY DEPTNO
                HAVING AVG(SAL) > 2500)
-- Approach II -> Using JOIN Instead of IN (Suitable for Relational Algebra)
SELECT ENAME
FROM EMP JOIN (SELECT DEPTNO
                FROM EMP
                GROUP BY DEPTNO
                HAVING AVG(SAL) > 2500) Temp
         ON (EMP.DEPTNO = Temp.DEPTNO)

-- Question IX
-- 查询提供了平均工资高于2500的所有职位的部门
-- Appraoch I -> IN Clause (Suitable for SQL)
SELECT DEPT.DEPTNO, DNAME, JOB
FROM DEPT JOIN EMP ON (DEPT.DEPTNO = EMP.DEPTNO)
WHERE JOB IN (SELECT JOB
              FROM EMP
              GROUP BY JOB
              HAVING AVG(SAL) > 2500)
ORDER BY DEPT.DEPTNO
-- Approach II -> Using JOIN Instead of IN (Suitable for Relational Algebra)
SELECT DEPT.DEPTNO, DNAME, EMP.JOB
FROM (DEPT JOIN EMP ON (DEPT.DEPTNO = EMP.DEPTNO))
       JOIN (SELECT JOB
             FROM EMP
             GROUP BY JOB
             HAVING AVG(SAL) > 2500) Temp
         ON (EMP.JOB = Temp.JOB)
ORDER BY DEPT.DEPTNO

-- Question X
-- 查询所有部门的职工人数，平均工资。即使一个部门没有任何员工，也要在结果中包含该部门的记录元组
SELECT DEPT.DEPTNO, COUNT(ENAME) AS Clark, ISNULL(AVG(SAL), 0) AS Avg_Sal
FROM DEPT LEFT JOIN EMP ON (DEPT.DEPTNO = EMP.DEPTNO)
GROUP BY DEPT.DEPTNO