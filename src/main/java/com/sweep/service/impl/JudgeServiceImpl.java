package com.sweep.service.impl;

import com.sweep.dao.JudgeMapper;
import com.sweep.pojo.Judge;
import com.sweep.service.JudgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class JudgeServiceImpl implements JudgeService{
    @Autowired
    private JudgeMapper judgeMapper;
    @Override
    public List<Judge> selectAllJudge() {
        return judgeMapper.getAllJudge();
    }

    @Override
    public boolean updateByPrimaryKeySelective(Judge judge) {
        return judgeMapper.updateByPrimaryKeySelective(judge)>0;
    }

    @Override
    public boolean delJudgeByPrimaryKey(Integer judgeid) {
        return judgeMapper.deleteByPrimaryKey(judgeid)>0;
    }

    @Override
    public boolean addJudge(Judge judge) {
        return judgeMapper.addJudge(judge)>0;
    }
}
