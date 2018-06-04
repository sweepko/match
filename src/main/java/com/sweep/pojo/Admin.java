package com.sweep.pojo;

public class Admin {
    private Integer adminId;

    private String adminUsername;

    private String adminPassword;

    public Admin(Integer adminId, String adminUsername, String adminPassword) {
        this.adminId = adminId;
        this.adminUsername = adminUsername;
        this.adminPassword = adminPassword;
    }

    public Admin() {
        super();
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public String getAdminUsername() {
        return adminUsername;
    }

    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername == null ? null : adminUsername.trim();
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword == null ? null : adminPassword.trim();
    }
}