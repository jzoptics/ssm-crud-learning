package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Message;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emps")
    public String getEmp(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);
        model.addAttribute("pageInfo",pageInfo);
        return "index";
    }

    /**
     * 员工查询
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/empss")
    public Msg getEmpJosn(@RequestParam Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);
        return Msg.success().add("pageInfo",pageInfo);
//        return new Message().success().addPage(pageInfo);
    }

    /**
     * 员工新增
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveEmp")
    public int saveEmp(@RequestBody  Employee employee){
        return employeeService.saveEmp(employee);
    }


    /**
     * 员工修改
     * @param
     * @return
     */
    @RequestMapping(value = "/empUpdate/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public int updateEmp(@RequestBody Employee employee){
        return employeeService.updateEmp(employee);
    }


    /**
     * 员工删除
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.DELETE)
    public int delEmp(@PathVariable("id") Integer id){
        return employeeService.delEmp(id);
    }
}
