package com.sweep.dao;

import com.sweep.pojo.Corps;
import com.sweep.pojo.ExCorps;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CorpsMapper {
    int deleteByPrimaryKey(Integer corpsId);

    int insert(Corps record);

    int insertSelective(Corps record);

    Corps selectByPrimaryKey(Integer corpsId);

    int updateByPrimaryKeySelective(Corps record);

    int updateByPrimaryKey(Corps record);

    Corps doubleName(String corpsName);

    List<Corps> getMyCorps(@Param("myemail") String myemail);

    int setstate(@Param("corpsid") int corpsid, @Param("matchid") int matchid);

    List<Corps> selectUntreated();

    List<ExCorps> selectExCorps();

    int setReject(@Param("corpsid") int id);

    int setPass(@Param("corpsid")int corpsid);

    int addEnters(@Param("corpsid") int corpsid, @Param("matchid") int matchid);

    List<ExCorps> getCorps();

    int updateCorps(@Param("corpsid") int corpsid, @Param("score") String score,@Param("describe") String describe);

    Corps getMyCorp(@Param("email") String email,@Param("matchid")int matchid);

    int cancel(String email, int matchid);
}