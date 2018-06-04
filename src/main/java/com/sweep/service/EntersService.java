package com.sweep.service;

import com.sweep.pojo.Enters;
import com.sweep.pojo.ExEnters;
import com.sweep.pojo.User;

import java.util.List;

public interface EntersService {
    public boolean insertEnters(Enters enters);

    public List<Enters> selectUntreated();

    List<ExEnters> selectExEnters();

    boolean setReject(int id);

    boolean setPass(int id);

    boolean addEnters(int userid, int matchid);

    List<User> selectEnters();

    List<ExEnters> getEnters();

    boolean updateEnters(int id, String score, String describe);

    Enters selectExEnter(Integer userid,int matchid);

    boolean cancle(Integer userid, int matchid);
}
