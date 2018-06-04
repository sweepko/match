package com.sweep.pojo;

public class MyMatch {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private Enters enters;
    private Match match;

    public Enters getEnters() {
        return enters;
    }

    public void setEnters(Enters enters) {
        this.enters = enters;
    }

    public Match getMatch() {
        return match;
    }

    public void setMatch(Match match) {
        this.match = match;
    }
}
