package com.sweep.dao;

import com.sweep.pojo.CrawMatch;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CrawMapper {
    public List<CrawMatch> selectAllCrawMatch();
    public List<CrawMatch> selectCrawMatch();
    public List<CrawMatch> selectCrawMatchByKeyWords(String crawTitle);
    public int deleteByPrimaryKeys(@Param("ids") String ids);
}
