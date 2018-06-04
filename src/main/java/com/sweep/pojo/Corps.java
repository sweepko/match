package com.sweep.pojo;

public class Corps {
    private Integer corpsId;

    private String corpsName;

    private String corpsPersons;

    private String corpsIntroduce;

    private String corpsImage;

    private Integer matchid;

    private String score;

    private String describes;

    private int corpsstate;//0为未处理
    private String leader;

    public Corps(Integer corpsId, String corpsName, String corpsPersons, String corpsIntroduce, String corpsImage, Integer matchid, String score, String describes,int corpsstate,String leader) {
        this.corpsId = corpsId;
        this.corpsName = corpsName;
        this.corpsPersons = corpsPersons;
        this.corpsIntroduce = corpsIntroduce;
        this.corpsImage = corpsImage;
        this.matchid = matchid;
        this.score = score;
        this.describes = describes;
        this.corpsstate=corpsstate;
        this.leader=leader;
    }

    public int getCorpsstate() {
        return corpsstate;
    }

    public void setCorpsstate(int corpsstate) {
        this.corpsstate = corpsstate;
    }

    public Corps() {
        super();
    }

    public Integer getCorpsId() {
        return corpsId;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }

    public void setCorpsId(Integer corpsId) {
        this.corpsId = corpsId;
    }

    public String getCorpsName() {
        return corpsName;
    }

    public void setCorpsName(String corpsName) {
        this.corpsName = corpsName == null ? null : corpsName.trim();
    }

    public String getCorpsPersons() {
        return corpsPersons;
    }

    public void setCorpsPersons(String corpsPersons) {
        this.corpsPersons = corpsPersons == null ? null : corpsPersons.trim();
    }

    public String getCorpsIntroduce() {
        return corpsIntroduce;
    }

    public void setCorpsIntroduce(String corpsIntroduce) {
        this.corpsIntroduce = corpsIntroduce == null ? null : corpsIntroduce.trim();
    }

    public String getCorpsImage() {
        return corpsImage;
    }

    public void setCorpsImage(String corpsImage) {
        this.corpsImage = corpsImage == null ? null : corpsImage.trim();
    }

    public Integer getMatchid() {
        return matchid;
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