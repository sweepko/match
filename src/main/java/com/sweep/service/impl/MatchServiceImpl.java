package com.sweep.service.impl;

import com.sweep.dao.MatchMapper;
import com.sweep.pojo.Match;
import com.sweep.pojo.MyMatch;
import com.sweep.service.MatchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MatchServiceImpl implements MatchService {
    @Autowired
    private MatchMapper matchMapper;

    @Override
    public int insertMatch(Match match) {
        return matchMapper.insertSelective(match);
    }

    @Override
    public List<Match> selectAllMatch() {
        return matchMapper.selectAllMatch();
    }

    @Override
    public int deleteMatches(String ids) {
        return matchMapper.deleteByPrimaryKeys(ids);
    }

    @Override
    public Match selectMatchByPrimaryKey(int matchid) {
        return matchMapper.selectByPrimaryKey(matchid);
    }

    @Override
    public int updateMatch(Match match) {
        return matchMapper.updateByPrimaryKeySelective(match);
    }

    @Override
    public List<Match> selectMatchByKey(String keyword) {
        return matchMapper.selectMatchByKey(keyword);
    }

    @Override
    public List<MyMatch> getMatchUserid(int userid) {
        return matchMapper.selectMatchByUserid(userid);
    }
}
