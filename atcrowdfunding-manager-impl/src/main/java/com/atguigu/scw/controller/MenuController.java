package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("menu")
public class MenuController {
    @Autowired
    MenuService menuService;

//    查询菜单
    @ResponseBody
    @GetMapping("/getMenus")
    public List<TMenu> getMenus(){
        List<TMenu> menus = menuService.getMenus();
        return menus;
    }


    @GetMapping("index")
    public String toMenuPage(){
        return "menus/menu";
    }
}
