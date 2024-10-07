/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author vanct
 */
public class JobSeekers {
    private int JobSeekerID;
    private int AccountID;

    public JobSeekers() {
    }

    public JobSeekers(int JobSeekerID, int AccountID) {
        this.JobSeekerID = JobSeekerID;
        this.AccountID = AccountID;
    }

    public int getJobSeekerID() {
        return JobSeekerID;
    }

    public void setJobSeekerID(int JobSeekerID) {
        this.JobSeekerID = JobSeekerID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }
}
