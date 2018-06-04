package com.sweep.dao;

import com.sweep.pojo.Enters;
import com.sweep.pojo.ExEnters;
import com.sweep.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EntersMapper {
    int deleteByPrimaryKey(Integer entersid);

    int insert(Enters record);

    int insertSelective(Enters record);

    Enters selectByPrimaryKey(Integer entersid);

    int updateByPrimaryKeySelective(Enters record);

    int updateByPrimaryKey(Enters record);

    List<Enters> selectUntreated();

    List<ExEnters> selectExEnters();

    int setReject(@Param("entersid") int entersid);

    int setPass(@Param("entersid") int id);

    int addEnters(@Param("userid") int userid, @Param("matchid") int matchid);

    List<User> selectEnters();

    List<ExEnters> getEnters();

    int updateEnters(@Param("entersid") int id,@Param("score") String score,@Param("describe") String describe);

    Enters selectEnter(@Param("userid") Integer userid,@Param("matchid") int matchid);

    int cancel(@Param("userid") Integer userid, @Param("matchid") int matchid);
}