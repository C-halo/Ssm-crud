package com.halo.service;

import com.halo.bean.Department;
import com.halo.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        //按照条件查询,传入Null则会查询出所有部门信息
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
