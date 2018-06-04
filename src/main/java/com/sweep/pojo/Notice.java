package com.sweep.pojo;

public class Notice {
    private Integer noticeid;

    private String noticetitle;

    private String noticecontent;

    private String noticedate;
    private String noticeperson;

    public Notice(Integer noticeid, String noticetitle, String noticecontent, String noticedate,String noticeperson) {
        this.noticeid = noticeid;
        this.noticetitle = noticetitle;
        this.noticecontent = noticecontent;
        this.noticedate = noticedate;
        this.noticeperson=noticeperson;
    }

    public Notice() {
        super();
    }

    public Integer getNoticeid() {
        return noticeid;
    }

    public void setNoticeid(Integer noticeid) {
        this.noticeid = noticeid;
    }

    public String getNoticeperson() {
        return noticeperson;
    }

    public void setNoticeperson(String noticeperson) {
        this.noticeperson = noticeperson;
    }

    public String getNoticetitle() {
        return noticetitle;
    }

    public void setNoticetitle(String noticetitle) {
        this.noticetitle = noticetitle == null ? null : noticetitle.trim();
    }

    public String getNoticecontent() {
        return noticecontent;
    }

    public void setNoticecontent(String noticecontent) {
        this.noticecontent = noticecontent == null ? null : noticecontent.trim();
    }

    public String getNoticedate() {
        return noticedate;
    }

    public void setNoticedate(String noticedate) {
        this.noticedate = noticedate == null ? null : noticedate.trim();
    }
}