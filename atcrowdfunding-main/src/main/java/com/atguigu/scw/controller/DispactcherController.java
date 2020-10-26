package com.atguigu.scw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispactcherController {

    @RequestMapping(value = {"/index", "/", "index.html"})
    public String toIndexPage(){
        return "index";
    }

    @GetMapping("/login.html")
    public String toLoginPage(){ return "login";}

}
