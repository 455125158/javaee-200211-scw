package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    RoleService roleService;

//    7.修改角色
    @ResponseBody
    @PostMapping("/updateRole")
    public String updateRole(TRole role){
        roleService.updateRole(role);
        return "ok";
    }

    //    6.查询指定角色
    @ResponseBody
    @GetMapping("/getRole")
    public TRole getRole(Integer id){
        TRole role = roleService.getRole(id);
        return role;
    }

//    5.批量删除角色
    @ResponseBody
    @GetMapping("/batchDelRole")
    public String batchDelRole(@RequestParam("ids")List<Integer> ids){
        roleService.batchDelRole(ids);
        return "ok";
    }

//    4.删除角色
    @ResponseBody
    @GetMapping("/delRole")
    public String delRole(Integer id){
        roleService.delRole(id);
        return "ok";
    }

//    3.新增角色，异步
    @ResponseBody
    @PostMapping("/addRole")
    public String addRole(TRole role){
        roleService.addRole(role);
        return "ok";
    }

//    2.异步查询角色分页数据
    @ResponseBody
    @GetMapping("/getRoles")
    public PageInfo<TRole> getRoles(String condition, @RequestParam(defaultValue = "1", required = false) Integer pageNum){
        //启动分页
        PageHelper.startPage(pageNum, 3);
        List<TRole> roles = roleService.getRoles(condition);
        PageInfo<TRole> pageInfo = new PageInfo<>(roles, 3);
        return pageInfo;

    }

//    1.转发到role
    @GetMapping("/index")
    public String toRolePage(){
        return "role/role";
    }

}

