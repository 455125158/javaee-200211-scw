package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    @Autowired
    RoleService roleService;

//    12.分配角色
    @ResponseBody
    @PostMapping("/assginRoleToAdmin")
    public String assginRoleToAdmin(Integer adminId, @RequestParam("roleIds") List<Integer> roleIds){
        adminService.assginRoleToAdmin(adminId, roleIds);

        return "ok";
    }


//    11.转发到分配角色的页面
    @GetMapping("/toAssignRolePage")
    public String toAssignRolePage(Model model,  Integer id){
        List<TRole> roles = roleService.getRoles(null);
        // 已分配id集合
        List<Integer> assginedRoleIds = roleService.getAssignedRoleIds(id);

        List<TRole> assginedRoles = new ArrayList<TRole>();         // 已分配
        List<TRole> unAssginedRoles = new ArrayList<TRole>();       // 未分配

        for(TRole role : roles){
            if(assginedRoleIds.contains(role.getId())){
                assginedRoles.add(role);
            } else {
                unAssginedRoles.add(role);
            }
        }

        model.addAttribute("assginedRoles",assginedRoles);
        model.addAttribute("unAssginedRoles",unAssginedRoles);

        return "admin/assginRole";
    }

//    10.批量删除管理员
    @GetMapping("/batchDelAdmins")
    public String batchDelAdmins(@RequestParam("ids") List<Integer>ids){
        adminService.batchDelAdmins(ids);
        return "redirect:/admin/index";
    }

//    9.更新管理员数据
    @PostMapping("/updateAdmin")
    public String updateAdmin(HttpSession session, TAdmin admin){
        adminService.updateAdminById(admin);
        String ref = (String) session.getAttribute("ref");
        return "redirect:" + ref;
    }
//    8.修改管理员
    @GetMapping("/toEditPage")
    public String toEditpage(HttpSession session, @RequestHeader("referer") String referer, Model model, Integer id){
//        储存之前的页面
        session.setAttribute("ref",referer);

        TAdmin admin = adminService.getAdmin(id);
        model.addAttribute("admin", admin);
        return "admin/edit";
    }

//    7.新增管理员
    @PostMapping("/saveAdmin")
    public String saveAdmin(HttpSession session, Model model, TAdmin admin){
        try {
            adminService.saveAdmin(admin);
        } catch (Exception e) {
            e.printStackTrace();
            // 添加失败
            model.addAttribute("errorMsg", e.getMessage());
            return "admin/add";
        }
        Integer pages = (Integer) session.getAttribute("pages");
        return "redirect:/admin/index?pageNum=" + (pages+1);
    }

//    6.转发到添加页面
    @GetMapping("/add.html")
    public String toAddPage(){
        return "admin/add";
    }

//    5.删除管理员
    @GetMapping("/deleteAdmin")
    public String deleteAdmin(Integer id){
        adminService.deleteAdmin(id);

        return "redirect:/admin/index";
    }

////    4.注销方法
//    @GetMapping("/logout")
//    public String logout(HttpSession session){
//        session.invalidate();
//        return "redirect:/index";
//    }

    // 3.查询管理员列表
    @GetMapping("/index")
    public String getAdmins(HttpSession session, String condition, Model model ,@RequestParam(defaultValue = "1", required = false) Integer pageNum){
        PageHelper.startPage(pageNum, 5);

        List<TAdmin> admins = adminService.getAdmins(condition);

        PageInfo pageInfo = new PageInfo<TAdmin>(admins, 3);

//        最大页码
        session.setAttribute("pages", pageInfo.getPages());
        model.addAttribute("pageInfo", pageInfo);
        return "admin/user";
    }


//    @PostMapping("/login")
//    public String doLogin(Model model, HttpSession session, String loginacct, String userpswd){
//        TAdmin admin = adminService.doLogin(loginacct, userpswd);
//        if (admin == null){
//            model.addAttribute("errorMsg","账号或者密码错误");
//            // 转发到登入页面
//            return "login";
//        }
//
//        session.setAttribute("admin", admin);
////      重定向到 管理员页面,地址栏地址变成成功页面的地址
//        return "redirect:/admin/main.html";
//    }

    // 转发到main
    @GetMapping("/main.html")
    public String toMainPage(HttpSession session){
        // 查询菜单集合
        List<TMenu> pmenus = adminService.getPMenus();
        //System.out.println(pmenus);
        session.setAttribute("pmenus", pmenus);

        return "admin/main";
    }
}
