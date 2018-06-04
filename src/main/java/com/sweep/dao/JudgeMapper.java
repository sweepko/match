package com.sweep.dao;

import com.sweep.pojo.Judge;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JudgeMapper {
    int deleteByPrimaryKey(Integer judgeid);

    int insert(Judge record);

    int insertSelective(Judge record);

    Judge selectByPrimaryKey(Integer judgeid);

    int updateByPrimaryKeySelective(Judge record);

    int updateByPrimaryKey(Judge record);
    List<Judge> getAllJudge();

    int addJudge(Judge judge);
}