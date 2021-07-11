package com.halo.service;

import com.halo.bean.Employee;
import com.halo.bean.EmployeeExample;
import com.halo.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpolyeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /***
     * 保存员工
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /***
     * 检查员工名是否重复
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /***
     * 根据id查返回员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /***
     * 更新员工信息
     * @param employee
     * @return
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /***
     * 根据ID删除单个员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /***
     * 批量删除方法
     * 1-2-3
     * @param del_ids
     */
    public void delBatch(List<Integer> del_ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        //创建一个例子，包含这些id就删除
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(employeeExample);

    }
}
