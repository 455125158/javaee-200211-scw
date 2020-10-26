package com.atguigu.scw.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

//全局上下文监听器

public class AppStartupListener implements ServletContextListener {
    // 全局上下文对象创建后立即调用
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("PATH",
                sce.getServletContext().getContextPath());
    }

//    全局上下文销毁前立即调用
    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
