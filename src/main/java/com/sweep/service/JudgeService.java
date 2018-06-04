package com.sweep.service;

import com.sweep.pojo.Judge;

import java.util.List;

public interface JudgeService {
    public List<Judge> selectAllJudge();
    public boolean updateByPrimaryKeySelective(Judge judge);
    public boolean delJudgeByPrimaryKey(Integer judgeid);

    boolean addJudge(Judge judge);
}
