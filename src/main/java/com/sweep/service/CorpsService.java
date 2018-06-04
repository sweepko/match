package com.sweep.service;

import com.sweep.pojo.Corps;
import com.sweep.pojo.ExCorps;

import java.util.List;

public interface CorpsService {
    public boolean insertCorps(Corps corps);

    boolean isDuplicateName(String corpsName);

    List<Corps> getMyCorps(String myid);

    Corps selectCorps(int corpid);

    boolean signCorps(int corpid,int matchid);

    List<Corps> selectUntreated();

    List<ExCorps> selectExCorps();

    boolean setReject(int id);

    boolean setPass(int corpsid);
    boolean addEnters(int corpsid, int matchid);

    List<ExCorps> getCorps();

    boolean updateCorps(int corpsid, String score, String describe);

    Corps getMyCorp(String email, int matchid);

    boolean cancel(String email, int matchid);
}
