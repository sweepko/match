package com.sweep.pojo;

public class User {
    private Integer userid;

    private String username;

    private String password;

    private String sex;

    private Integer age;

    private String email;

    private String phone;

    private String createTime;

    private Integer credit;

    private String realname;

    private String userimage;

    private String motto;//座右铭

    public String getMotto() {
        return motto;
    }

    public void setMotto(String motto) {
        this.motto = motto;
    }

    public User(Integer userid, String username, String password, String sex, Integer age, String email, String phone, String createTime, Integer credit, String realname, String userimage, String motto) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.sex = sex;
        this.age = age;
        this.email = email;
        this.phone = phone;
        this.createTime = createTime;
        this.credit = credit;
        this.realname = realname;
        this.userimage = userimage;
        this.motto=motto;

    }

    public User() {
        super();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
    }

    public String getUserimage() {
        return userimage;
    }

    @Override
    public String toString() {
        return "User{" +
                "userid=" + userid +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", sex='" + sex + '\'' +
                ", age=" + age +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", createTime='" + createTime + '\'' +
                ", credit=" + credit +
                ", realname='" + realname + '\'' +
                ", userimage='" + userimage + '\'' +
                ", motto='" + motto + '\'' +
                '}';
    }


    public void setUserimage(String userimage) {
        this.userimage = userimage == null ? null : userimage.trim();
    }
}