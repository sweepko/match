package com.sweep.service.impl;

import com.sweep.dao.CrawMapper;
import com.sweep.pojo.CrawMatch;
import com.sweep.service.CrawService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CrawServiceImpl implements CrawService{
    @Autowired
    private CrawMapper crawMapper;
    @Override
    public List<CrawMatch> getAllCraw() {
        return crawMapper.selectAllCrawMatch();
    }

    @Override
    public List<CrawMatch> getCraw(String keyword) {
        if (keyword==null){
            return crawMapper.selectCrawMatch();
        }else{
            return crawMapper.selectCrawMatchByKeyWords(keyword);
        }
    }

    @Override
    public int deleteCrawMatches(String ids) {

        return crawMapper.deleteByPrimaryKeys(ids);
    }
}
