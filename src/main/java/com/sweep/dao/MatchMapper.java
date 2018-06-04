package com.sweep.dao;

import com.sweep.pojo.Match;
import com.sweep.pojo.MyMatch;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MatchMapper {

    int deleteByPrimaryKeys(@Param("idss") String idss);


    int insertSelective(Match record);

    Match selectByPrimaryKey(Integer matchid);

    int updateByPrimaryKeySelective(Match record);

    List<Match> selectAllMatch();

    List<Match> selectMatchByKey(@Param("keyword") String keyword);

    List<MyMatch> selectMatchByUserid(@Param("userid") int userid);
}