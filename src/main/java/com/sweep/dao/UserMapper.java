package com.sweep.dao;

import com.sweep.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);
    List<User> selectAllUsers();
    int updateByPrimaryKey(User record);
    User selectByName(String name);
    User selectByNameAndPass(@Param("username") String username, @Param("password") String password);
    User selectByEmail(String email);

    void updatePassByID(@Param("password")String password, @Param("userid") int userid);

    void updateImage(@Param("userid") Integer userid, @Param("img") String img);

    int updateUser(User user);

    User selectById(int userid);
}