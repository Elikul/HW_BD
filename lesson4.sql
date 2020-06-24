-- Создать VIEW на основе запроса "Посчитать количество сотрудников во всех отделах"
CREATE VIEW EmployeersInDepartments
		AS SELECT departments.dept_name, COUNT(dept_emp.emp_no) AS count_employees 
        FROM employees.dept_emp
        JOIN employees.departments
        ON dept_emp.dept_no = departments.dept_no
        GROUP BY dept_emp.dept_no;
        
SELECT * FROM EmployeersInDepartments;


-- Создать функцию, которая найдет менеджера по имени и фамилии
delimiter //

CREATE PROCEDURE findManager (IN first_nameM VARCHAR(14), last_nameM VARCHAR(16))
	BEGIN 
		SELECT * FROM employees.dept_manager 
        JOIN employees.employees
        ON dept_manager.emp_no = employees.emp_no
        WHERE employees.first_name = first_nameM AND employees.last_name = last_nameM;
    END //

delimiter ;

CALL findManager('Karsten', 'Sigstam');

-- Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

CREATE TRIGGER bonus AFTER INSERT ON employees.salaries
     FOR EACH ROW SET @sum = @sum + NEW.salary;
