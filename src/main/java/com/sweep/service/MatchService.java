package com.sweep.service;

import com.sweep.pojo.Match;
import com.sweep.pojo.MyMatch;

import java.util.List;

public interface MatchService {
    public int insertMatch(Match math);
    public List<Match> selectAllMatch();
    public  int deleteMatches(String ids);
    public  Match selectMatchByPrimaryKey(int matchid);
    public int updateMatch(Match match);

    List<Match> selectMatchByKey(String param);

    List<MyMatch> getMatchUserid(int userid);
}
