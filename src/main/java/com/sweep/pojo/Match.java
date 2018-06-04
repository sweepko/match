package com.sweep.pojo;

import java.io.Serializable;

public class Match {
    private Integer matchid;

    private String matchname;

    private String matchtype;

    private String matchdetails;

    private String createdate;

    private String startdate;

    private String enddate;

    @Override
    public String toString() {
        return "Match{" +
                "matchid=" + matchid +
                ", matchname='" + matchname + '\'' +
                ", matchtype='" + matchtype + '\'' +
                ", matchdetails='" + matchdetails + '\'' +
                ", createdate='" + createdate + '\'' +
                ", startdate='" + startdate + '\'' +
                ", enddate='" + enddate + '\'' +
                ", sponsor='" + sponsor + '\'' +
                ", address='" + address + '\'' +
                ", judges='" + judges + '\'' +
                ", enters='" + enters + '\'' +
                ", instruction='" + instruction + '\'' +
                ", maxenters=" + maxenters +
                ", officialphone='" + officialphone + '\'' +
                ", matchimage='" + matchimage + '\'' +
                '}';
    }

    private String sponsor;

    private String address;

    private String judges;

    private String enters;

    private String instruction;

    private Integer maxenters;

    private String officialphone;

    private String matchimage;

    public Match(Integer matchid, String matchname, String matchtype, String matchdetails, String createdate, String startdate, String enddate, String sponsor, String address, String judges, String enters, String instruction, Integer maxenters, String officialphone,String matchimage) {
        this.matchid = matchid;
        this.matchname = matchname;
        this.matchtype = matchtype;
        this.matchdetails = matchdetails;
        this.createdate = createdate;
        this.startdate = startdate;
        this.enddate = enddate;
        this.sponsor = sponsor;
        this.address = address;
        this.judges = judges;
        this.enters = enters;
        this.instruction = instruction;
        this.maxenters = maxenters;
        this.officialphone = officialphone;
        this.matchimage=matchimage;
    }

    public Match() {
        super();
    }

    public Integer getMatchid() {
        return matchid;
    }

    public void setMatchid(Integer matchid) {
        this.matchid = matchid;
    }

    public String getMatchname() {
        return matchname;
    }

    public void setMatchname(String matchname) {
        this.matchname = matchname == null ? null : matchname.trim();
    }

    public String getMatchtype() {
        return matchtype;
    }

    public void setMatchtype(String matchtype) {
        this.matchtype = matchtype == null ? null : matchtype.trim();
    }

    public String getMatchdetails() {
        return matchdetails;
    }

    public void setMatchdetails(String matchdetails) {
        this.matchdetails = matchdetails == null ? null : matchdetails.trim();
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = createdate == null ? null : createdate.trim();
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate == null ? null : startdate.trim();
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate == null ? null : enddate.trim();
    }

    public String getSponsor() {
        return sponsor;
    }

    public void setSponsor(String sponsor) {
        this.sponsor = sponsor == null ? null : sponsor.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getJudges() {
        return judges;
    }

    public void setJudges(String judges) {
        this.judges = judges == null ? null : judges.trim();
    }

    public String getEnters() {
        return enters;
    }

    public void setEnters(String enters) {
        this.enters = enters == null ? null : enters.trim();
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction == null ? null : instruction.trim();
    }

    public Integer getMaxenters() {
        return maxenters;
    }

    public void setMaxenters(Integer maxenters) {
        this.maxenters = maxenters;
    }

    public String getOfficialphone() {
        return officialphone;
    }

    public void setOfficialphone(String officialphone) {
        this.officialphone = officialphone == null ? null : officialphone.trim();
    }

    public String getMatchimage() {
        return matchimage;
    }

    public void setMatchimage(String matchimage) {
        this.matchimage = matchimage;
    }
}