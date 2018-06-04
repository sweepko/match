package com.sweep.pojo;

import sun.nio.cs.ext.TIS_620;

public class Judge {
    private Integer judgeid;//裁判id

    private String judgename;//裁判姓名

    private String judgeemail;//裁判邮箱

    private String matchnum;//裁判过的比赛次数

    private Integer judgeage;//裁判年龄

    private String judgesex; //裁判性别
    private String judgetype;//裁判比赛类型
    private String judgeimage;//裁判头像
    public Judge(Integer judgeid, String judgename,String matchnum, String judgeemail,Integer judgeage,String judgesex,String judgetype,String judgeimage) {
        this.judgeid = judgeid;
        this.judgename = judgename;
        this.judgeemail = judgeemail;
        this.matchnum=matchnum;
        this.judgeage=judgeage;
        this.judgesex=judgesex;
        this.judgetype=judgetype;
        this.judgeimage=judgeimage;
    }

    public Judge() {
        super();
    }

    public String getJudgeimage() {
        return judgeimage;
    }

    public void setJudgeimage(String judgeimage) {
        this.judgeimage = judgeimage;
    }

    public Integer getJudgeid() {
        return judgeid;
    }

    public void setJudgeid(Integer judgeid) {
        this.judgeid = judgeid;
    }

    public String getJudgename() {
        return judgename;
    }

    public void setJudgename(String judgename) {
        this.judgename = judgename == null ? null : judgename.trim();
    }

    public String getJudgeemail() {
        return judgeemail;
    }

    public void setJudgeemail(String judgeemail) {
        this.judgeemail = judgeemail == null ? null : judgeemail.trim();
    }

    public String getMatchnum() {
        return matchnum;
    }
    public void setMatchnum(String matchnum) {
        this.matchnum = matchnum;
    }

    public Integer getJudgeage() {
        return judgeage;
    }

    public void setJudgeage(Integer judgeage) {
        this.judgeage = judgeage;
    }

    public String getJudgesex() {
        return judgesex;
    }

    public void setJudgesex(String judgesex) {
        this.judgesex = judgesex;
    }

    public String getJudgetype() {
        return judgetype;
    }

    public void setJudgetype(String judgetype) {
        this.judgetype = judgetype;
    }
}