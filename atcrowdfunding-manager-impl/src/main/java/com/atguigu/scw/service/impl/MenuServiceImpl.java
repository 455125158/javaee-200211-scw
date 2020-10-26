package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    TMenuMapper menuMapper;

    @Override
    public List<TMenu> getMenus() {
        return menuMapper.selectByExample(null);
    }
}
