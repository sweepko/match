package com.sweep.pojo;

public class Enters {
    private Integer entersid;

    private Integer userid;

    private Integer matchid;

    private String score;

    private String describes;

    private int state;

    public Enters(Integer entersid, Integer userid, Integer matchid, String score, String describes,int state) {
        this.entersid = entersid;
        this.userid = userid;
        this.matchid = matchid;
        this.score = score;
        this.describes = describes;
        this.state=state;
    }

    public Enters() {
        super();
    }

    public Integer getEntersid() {
        return entersid;
    }

    public void setEntersid(Integer entersid) {
        this.entersid = entersid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getMatchid() {
        return matchid;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public void setMatchid(Integer matchid) {
        this.matchid = matchid;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score == null ? null : score.trim();
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes == null ? null : describes.trim();
    }
}