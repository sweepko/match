package com.sweep.service.impl;

import com.sweep.dao.CorpsMapper;
import com.sweep.pojo.Corps;
import com.sweep.pojo.ExCorps;
import com.sweep.service.CorpsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CorpsServiceImpl implements CorpsService{
    @Autowired
    private CorpsMapper corpsMapper;
    @Override
    public boolean insertCorps(Corps corps) {
        return corpsMapper.insertSelective(corps)>0;
    }

    @Override
    public boolean isDuplicateName(String corpsName) {
        Corps corps=corpsMapper.doubleName(corpsName);
        return corps==null;
    }

    @Override
    public List<Corps> getMyCorps(String myemail) {
        return corpsMapper.getMyCorps(myemail);
    }

    @Override
    public Corps selectCorps(int corpid) {
        return corpsMapper.selectByPrimaryKey(corpid);
    }

    @Override
    public boolean signCorps(int corpid,int matchid) {

        return corpsMapper.setstate(corpid,matchid)>0;
    }

    @Override
    public List<Corps> selectUntreated() {
        return corpsMapper.selectUntreated();
    }

    @Override
    public List<ExCorps> selectExCorps() {
        return corpsMapper.selectExCorps();
    }

    @Override
    public boolean setReject(int id) {
        return corpsMapper.setReject(id)>0;
    }

    @Override
    public boolean setPass(int corpsid) {
        return corpsMapper.setPass(corpsid)>0;
    }

    @Override
    public boolean addEnters(int corpsid, int matchid) {
        return corpsMapper.addEnters(corpsid,matchid)>0;
    }

    @Override
    public List<ExCorps> getCorps() {
        return corpsMapper.getCorps();
    }

    @Override
    public boolean updateCorps(int corpsid, String score, String describe) {
        return corpsMapper.updateCorps(corpsid,score,describe)>0;
    }

    @Override
    public Corps getMyCorp(String email, int matchid) {
        return corpsMapper.getMyCorp(email,matchid);
    }

    @Override
    public boolean cancel(String email, int matchid) {
        return corpsMapper.cancel(email,matchid)>0;
    }
}
