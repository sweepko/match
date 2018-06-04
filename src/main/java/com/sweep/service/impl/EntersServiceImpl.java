package com.sweep.service.impl;

import com.sweep.dao.EntersMapper;
import com.sweep.pojo.Enters;
import com.sweep.pojo.ExEnters;
import com.sweep.pojo.User;
import com.sweep.service.EntersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EntersServiceImpl implements EntersService{
    @Autowired
    private EntersMapper entersMapper;
    @Override
    public boolean insertEnters(Enters enters) {
        return entersMapper.insertSelective(enters)>0;
    }

    @Override
    public List<Enters> selectUntreated() {
        return entersMapper.selectUntreated();
    }

    @Override
    public List<ExEnters> selectExEnters() {
        return entersMapper.selectExEnters();
    }

    @Override
    public boolean setReject(int id) {
        return entersMapper.setReject(id)>0;
    }

    @Override
    public boolean setPass(int id) {
        return entersMapper.setPass(id)>0;
    }

    @Override
    public boolean addEnters(int userid, int matchid) {
        return entersMapper.addEnters(userid,matchid)>0;
    }

    @Override
    public List<User> selectEnters() {
        return entersMapper.selectEnters();
    }

    @Override
    public List<ExEnters> getEnters() {
        return entersMapper.getEnters();
    }

    @Override
    public boolean updateEnters(int id, String score, String describe) {
        return entersMapper.updateEnters(id,score,describe)>0;
    }

    @Override
    public Enters selectExEnter(Integer userid,int matchid) {
        return entersMapper.selectEnter(userid,matchid);
    }

    @Override
    public boolean cancle(Integer userid, int matchid) {
        return entersMapper.cancel(userid,matchid)>0;
    }
}
