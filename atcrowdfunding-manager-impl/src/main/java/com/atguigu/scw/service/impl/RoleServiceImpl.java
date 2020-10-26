package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.*;
import com.atguigu.scw.mapper.TAdminRoleMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import com.atguigu.scw.service.RoleService;
import com.atguigu.scw.wtils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    TRoleMapper roleMapper;

    @Autowired
    TAdminRoleMapper adminRoleMapper;

    @Override
    public List<Integer> getAssignedRoleIds(Integer id) {
        TAdminRoleExample exa = new TAdminRoleExample();
        exa.createCriteria().andAdminidEqualTo(id);
        List<TAdminRole> adminRoles = adminRoleMapper.selectByExample(exa);
        List<Integer> roleIds = new ArrayList<Integer>();;
        if(!CollectionUtils.isEmpty(adminRoles)){
            for (TAdminRole adminRole : adminRoles){
                roleIds.add(adminRole.getRoleid());
            }
        }

        return roleIds;
    }

    @Override
    public void updateRole(TRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void delRole(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDelRole(List<Integer> ids) {
        TRoleExample exa = new TRoleExample();
        exa.createCriteria().andIdIn(ids);
        roleMapper.deleteByExample(exa);
    }

    @Override
    public TRole getRole(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void addRole(TRole role) {
        roleMapper.insertSelective(role);
    }

    @Override
    public List<TRole> getRoles(String condition) {
        if(!StringUtil.isEmpty(condition)){
            TRoleExample exa = new TRoleExample();
            exa.createCriteria().andNameLike("%"+condition+"%");
            return roleMapper.selectByExample(exa);
        }

        return roleMapper.selectByExample(null);
    }
}
