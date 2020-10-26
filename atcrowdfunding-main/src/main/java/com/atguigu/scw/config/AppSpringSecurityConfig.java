package com.atguigu.scw.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
public class AppSpringSecurityConfig extends WebSecurityConfigurerAdapter {

//    授权 12
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //1、授权首页+静态资源+登录页面 任何人都可以访问
        http.authorizeRequests()
                //permitAll() 所有人都可以访问
                .antMatchers("/" , "/index","/static/**" , "/login.html").permitAll() //配置浏览器访问首页的地址
                .anyRequest().authenticated();//配置其他的任意请求都需要授权认证

        http.formLogin()
                .loginPage("/login.html")
                .loginProcessingUrl("/admin/login")
                .usernameParameter("loginacct")
                .passwordParameter("userpswd")
                .defaultSuccessUrl("/admin/main.htm");

//        http.csrf().disable();  // 取消csrf
    }

//    认证
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        super.configure(auth);
    }
}
