package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;

import java.util.List;

public interface AdminService {
    TAdmin doLogin(String loginacct, String userpswd);

    List<TMenu> getPMenus();

    List<TAdmin> getAdmins(String condition);

    public void deleteAdmin(Integer id);

    void saveAdmin(TAdmin admin);

    TAdmin getAdmin(Integer id);

    void updateAdminById(TAdmin admin);

    void batchDelAdmins(List<Integer> ids);

    void assginRoleToAdmin(Integer adminId, List<Integer> roleIds);
}
