package com.sweep.service;

import com.sweep.pojo.Admin;
import com.sweep.pojo.User;

import java.util.List;

public interface AdminService {
    public Admin selectAdminByNameAndPass(String username, String password);
    public int addAdmin(Admin admin);

    List<Admin> selectAdmin();
}
