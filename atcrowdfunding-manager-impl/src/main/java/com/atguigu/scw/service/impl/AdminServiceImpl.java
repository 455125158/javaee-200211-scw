package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TAdminRoleMapper;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.wtils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    TAdminMapper adminMapper;

    @Autowired
    TMenuMapper menuMapper;

    @Autowired
    TAdminRoleMapper adminRoleMapper;

    @Override
    public void batchDelAdmins(List<Integer> ids) {
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andIdIn(ids);
        adminMapper.deleteByExample(exa);
    }

    @Override
    public void assginRoleToAdmin(Integer adminId, List<Integer> roleIds) {
        adminRoleMapper.batchInsertAdminIdAndRoleIds(adminId, roleIds);
    }

    @Override
    public void updateAdminById(TAdmin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public TAdmin getAdmin(Integer id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    @Override
    public void saveAdmin(TAdmin admin) {
//        验证账号的唯一性
        String loginacct = admin.getLoginacct();
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(loginacct);
        long count = adminMapper.countByExample(exa);
        if (count>0){
//            账号被占用
            throw new RuntimeException("账号被占用！");
        }

//        邮箱唯一性
        exa.clear();
        exa.createCriteria().andEmailEqualTo(admin.getEmail());
        count = adminMapper.countByExample(exa);
        if(count>0){
            throw new RuntimeException("邮箱被占用！");
        }

        admin.setUserpswd(MD5Util.digest(admin.getUserpswd()));

        adminMapper.insertSelective(admin);
    }

    @Override
    public void deleteAdmin(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<TAdmin> getAdmins(String condition) {
        if(!StringUtils.isEmpty(condition)){
            //查询条件不为空，使用条件查询分页数据
            TAdminExample exa = new TAdminExample();
            //只要账号邮箱姓名包含条件的数据都查询
            TAdminExample.Criteria criteria = exa.createCriteria();
            criteria.andLoginacctLike("%"+condition+"%");
            TAdminExample.Criteria criteria2 = exa.createCriteria();
            criteria2.andEmailLike("%"+condition+"%");
            TAdminExample.Criteria criteria3 = exa.createCriteria();
            criteria3.andUsernameLike("%"+condition+"%");
            exa.or(criteria2);
            exa.or(criteria3);
            return  adminMapper.selectByExample(exa);
        }
        //传入null时，代表查询条件为空
        return  adminMapper.selectByExample(null);
    }

    @Override
    // 管理员登入
    public TAdmin doLogin(String loginacct, String userpswd) {
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(MD5Util.digest(userpswd));
        List<TAdmin> admins = adminMapper.selectByExample(exa);
        if(CollectionUtils.isEmpty(admins)|| admins.size()>1){
            return  null;
        }
        return admins.get(0);
    }

    @Override
    public List<TMenu> getPMenus() {
        List<TMenu> menus = menuMapper.selectByExample(null);
        // 父菜单集合
        Map<Integer,TMenu> pmenus = new HashMap<Integer,TMenu>();
        for (TMenu menu : menus){
            if (menu.getPid() == 0){
                menu.setChildren(new ArrayList<TMenu>());
                pmenus.put(menu.getId(), menu);
            }
        }

        // 讲子菜单设置给父菜单对象
        for(TMenu menu : menus){
            TMenu pMenu = pmenus.get(menu.getPid()); // 父菜单
            if(menu.getPid() != 0 && pMenu != null){
                pMenu.getChildren().add(menu);
            }
        }
        return new ArrayList<TMenu>(pmenus.values());
    }
}
