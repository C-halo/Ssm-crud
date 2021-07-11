package com.halo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.halo.bean.Employee;
import com.halo.bean.Msg;
import com.halo.service.EmpolyeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class EmpolyeeController {

    @Autowired
    EmpolyeeService employeeService;


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);

        List<Employee> emps = employeeService.getAll();

        //设置连续显示的页数和起始页
        PageInfo pageInfo = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);//会返回code,message,extend(包含pageinfo信息)
    }


    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入分页插件,在查询之前传入当前页码和每页显示条数
        PageHelper.startPage(pn, 5);

        List<Employee> emps = employeeService.getAll();

        //设置连续显示的页数和起始页
        PageInfo pageInfo = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("ok", "ok");
        return "list";
    }

    //保存员工
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("error", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(String empName) {
        String regx = "[\u4e00-\u9fa5_a-zA-Z0-9_]{4,12}";
//        先检测用户名是否合法
        if (!empName.matches(regx)) {
            return Msg.fail().add("imsg", "用户名不合法，可以是4-12位的中文，英文，数字和_的组合");
        }
//        判断用户名是否已经存在
        boolean flag = employeeService.checkUser(empName);
        if (flag) {
            return Msg.success();
        } else {
            return Msg.fail().add("imsg", "用户已存在");
        }
    }


    //根据id查询员工
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    //    更新员工信息
    @RequestMapping(value = "emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee, HttpServletRequest request) {
        System.out.println(request.getParameter("gender"));
        System.out.println("将要更新的员工数据" + employee);
        employeeService.updateEmp(employee);
        System.out.println("调用成功");
        return Msg.success();
    }

    /***
     * 删除员工，支持单个或者多个员工的删除
     * 批量1-2-3
     * 单个1
     * @param ids
     * @return
     */
    @RequestMapping(value = "emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg DeleteEmp(@PathVariable String ids) {
        //判断是否包含字符-选择批量和单个删除方法
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] strings = ids.split("-");
            for (String string : strings) {
                del_ids.add(Integer.parseInt(string));
            }
            //调用批量删除方法
            employeeService.delBatch(del_ids);
        } else {
            //单个删除方法
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}

