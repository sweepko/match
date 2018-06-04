package com.sweep.service.impl;

import com.sweep.dao.UserMapper;
import com.sweep.pojo.User;
import com.sweep.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{
    @Autowired
    private UserMapper userMapper;
    @Override
    public User selectUserByName(String name) {
        User user=userMapper.selectByName(name);
        return user;
    }

    @Override
    public boolean insertUser(User user) {
        int count=userMapper.insert(user);
        return count>0;
    }

    @Override
    public User selectUserByNameAndPass(String username, String password) {
        return userMapper.selectByNameAndPass(username,password);
    }

    @Override
    public User selectByEmail(String email) {
        User user=userMapper.selectByEmail(email);
        return user;
    }

    @Override
    public void updataPassByKey(String password,int userid) {
        userMapper.updatePassByID(password,userid);
    }

    @Override
    public List<User> selectAllUser() {
        return userMapper.selectAllUsers();
    }

    @Override
    public void updateImage(Integer userid, String img) {
        userMapper.updateImage(userid,img);
    }

    @Override
    public boolean updateUser(Integer userid, User user) {
        user.setUserid(userid);
        return userMapper.updateUser(user)>0;
    }

    @Override
    public User selectById(int userid) {
        return userMapper.selectById(userid);
    }
}
