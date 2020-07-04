package crud.service;

import crud.bean.Employee;
import crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        return employees;
    }

    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    public Employee getEmpById(int id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public int delEmp(int id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }
}
