package com.sweep.pojo;

import com.sweep.pojo.Match;
import com.sweep.pojo.User;

public class ExEnters {
    private int entersid;
    private User user;

    private Match match;

    public int getEntersid() {
        return entersid;
    }

    public void setEntersid(int entersid) {
        this.entersid = entersid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Match getMatch() {
        return match;
    }

    public void setMatch(Match match) {
        this.match = match;
    }
}