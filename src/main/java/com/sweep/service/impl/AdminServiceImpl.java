package com.sweep.service.impl;

import com.sun.javafx.css.PseudoClassState;
import com.sweep.dao.AdminMapper;
import com.sweep.pojo.Admin;
import com.sweep.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{
    @Autowired
    private AdminMapper adminMapper;
    @Override
    public Admin selectAdminByNameAndPass(String username, String password) {
        return adminMapper.selectAdminByNameAndPass(username, password);
    }

    @Override
    public int addAdmin(Admin admin) {
        return adminMapper.insert(admin);
    }

    @Override
    public List<Admin> selectAdmin() {
        return adminMapper.getAdmins();
    }
}
