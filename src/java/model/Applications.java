/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author vanct
 */
public class Applications {
    private int ApplicationID;
    private int JobPostingID;
    private int JobSeekerID;
    private int CVID;
    private String Status;
    private LocalDateTime AppliedDate;

    public Applications() {
    }

    public Applications(int ApplicationID, int JobPostingID, int JobSeekerID, int CVID, String Status, LocalDateTime AppliedDate) {
        this.ApplicationID = ApplicationID;
        this.JobPostingID = JobPostingID;
        this.JobSeekerID = JobSeekerID;
        this.CVID = CVID;
        this.Status = Status;
        this.AppliedDate = AppliedDate;
    }

    public int getApplicationID() {
        return ApplicationID;
    }

    public void setApplicationID(int ApplicationID) {
        this.ApplicationID = ApplicationID;
    }

    public int getJobPostingID() {
        return JobPostingID;
    }

    public void setJobPostingID(int JobPostingID) {
        this.JobPostingID = JobPostingID;
    }

    public int getJobSeekerID() {
        return JobSeekerID;
    }

    public void setJobSeekerID(int JobSeekerID) {
        this.JobSeekerID = JobSeekerID;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public LocalDateTime getAppliedDate() {
        return AppliedDate;
    }

    public void setAppliedDate(LocalDateTime AppliedDate) {
        this.AppliedDate = AppliedDate;
    }
    
    
    
}
