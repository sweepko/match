package com.sweep.service;

import com.sweep.dao.UserMapper;
import com.sweep.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {
    public User selectUserByName(String name);
    public boolean insertUser(User user);
    public User selectUserByNameAndPass(String username,String password);
    public User selectByEmail(String email);
    public void updataPassByKey(String password,int userid);

    List<User> selectAllUser();

    void updateImage(Integer userid, String img);

    boolean updateUser(Integer userid, User user);

    User selectById(int userid);
}
