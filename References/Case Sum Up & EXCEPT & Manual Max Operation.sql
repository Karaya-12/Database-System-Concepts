-- Sum Up CASE WHEN
WITH TEMP AS (SELECT EMPNO, DEPTNO,
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


-- NOT EXISTS & EXCEPT
SELECT DNAME
FROM DEPT
WHERE NOT EXISTS(SELECT JOB
                 FROM EMP
                 WHERE SAL > 2000 AND SAL < 5000
                 EXCEPT
                 SELECT JOB
                 FROM EMP
                 WHERE EMP.DEPTNO = DEPT.DEPTNO)


-- Manual Order by Salary
SELECT e1.ENAME, e1.SAL
FROM EMP e1, EMP e2
WHERE e1.SAL >= e2.SAL  -- Aliase of Itself
GROUP BY e1.ENAME, e1.SAL


-- Manual Highest Salary
/*
SELECT e1.SAL
FROM EMP e1, EMP e2
WHERE e1.SAL < e2.SAL
 */

SELECT SAL
FROM EMP
EXCEPT
SELECT e1.SAL
FROM EMP e1, EMP e2
WHERE e1.SAL < e2.SAL