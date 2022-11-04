package com.ilyarudenko.weblab2;

public class TableRow {
    public double X;
    public double Y;
    public double R;
    public boolean hitFact;
    public String scriptTime;
    public String time;

    public TableRow (double X, double Y, double R, boolean hitFact, String scriptTime, String time){
        this.X=X;
        this.Y=Y;
        this.R=R;
        this.hitFact=hitFact;
        this.scriptTime=scriptTime;
        this.time=time;
    }
}
