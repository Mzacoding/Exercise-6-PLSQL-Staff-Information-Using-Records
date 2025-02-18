SET VERIFY OFF
SET SERVEROUTPUT ON 
-- Declaring varable 
DECLARE 

TYPE emp_record IS RECORD
(staff_name O_EMP.ENAME%TYPE,
job_title       O_EMP.JOB%TYPE,
monthly_salary     O_EMP.SAL%TYPE,
hiredate O_EMP.HIREDATE%TYPE,
department_name O_dept.DNAME%TYPE,
commission O_EMP.COMM%TYPE,
location O_dept.LOC%TYPE,
salary_grade     O_SALGRADE.GRADE%TYPE);

emp_data emp_record ;
number_years     NUMBER;
Annual_salary  O_EMP.SAL%TYPE;
SAL_INCREASE_RATE CONSTANT NUMBER:=1.25;
salary_adjestment  O_EMP.SAL%TYPE;
staff_no O_EMP.EMPNO%TYPE:='&STAFF_Number';
 
BEGIN

SELECT   e.ENAME,e.JOB,e.SAL,e.HIREDATE,d.DNAME,e.COMM,d.LOC,s.GRADE
INTO emp_data 
FROM O_SALGRADE s,O_dept d, O_EMP e
WHERE e.DEPTNO=d.DEPTNO AND 
e.SAL BETWEEN LOSAL AND HISAL
AND e.EMPNO=staff_no;


Annual_salary:=(emp_data.monthly_salary +NVL(emp_data.commission,0))*12;
salary_adjestment :=Annual_salary*SAL_INCREASE_RATE;
number_years:=TO_CHAR(SYSDATE,'YYYY')-TO_CHAR(emp_data.hiredate,'YYYY');

DBMS_OUTPUT.PUT_LINE('=================================================');
DBMS_OUTPUT.PUT_LINE('Staff_No: '|| staff_no);
DBMS_OUTPUT.PUT_LINE(emp_data.staff_name||'('||emp_data.job_title ||') works in '||emp_data.department_name ||'/' ||emp_data.location  ||' for about '||number_years||' Years now earning ' || TRIM(TO_CHAR(emp_data.monthly_salary ,'L999.99')) || ' on grade ' ||emp_data.salary_grade );
DBMS_OUTPUT.PUT_LINE('Annual salary: '|| TRIM(TO_CHAR(Annual_salary,'L99,999.99')));
DBMS_OUTPUT.PUT_LINE('25% Salary Adjustment: '|| TRIM(TO_CHAR(salary_adjestment,'L99,999.99')));
DBMS_OUTPUT.PUT_LINE('=================================================');
END;
/
