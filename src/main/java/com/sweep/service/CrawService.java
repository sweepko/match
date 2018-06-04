package com.sweep.service;

import com.sweep.pojo.CrawMatch;

import java.util.List;

public interface CrawService {
    public List<CrawMatch> getAllCraw();
    public List<CrawMatch> getCraw(String keyword);
    public int deleteCrawMatches(String ids);
}
