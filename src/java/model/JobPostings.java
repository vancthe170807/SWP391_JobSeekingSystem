package model;

import java.util.Date;

public class JobPostings {
    private int JobPostingID;
    private int RecruiterID;
    private String Title;
    private String Description;
    private String Requirements;
    private double Salary;
    private String Location;
    private Date PostedDate;
    private Date ClosingDate;
    private String Status;

    public JobPostings() {
    }

    public JobPostings(int JobPostingID, int RecruiterID, String Title, String Description, String Requirements, double Salary, String Location, Date PostedDate, Date ClosingDate, String Status) {
        this.JobPostingID = JobPostingID;
        this.RecruiterID = RecruiterID;
        this.Title = Title;
        this.Description = Description;
        this.Requirements = Requirements;
        this.Salary = Salary;
        this.Location = Location;
        this.PostedDate = PostedDate;
        this.ClosingDate = ClosingDate;
        this.Status = Status;
    }

    public int getJobPostingID() {
        return JobPostingID;
    }

    public void setJobPostingID(int JobPostingID) {
        this.JobPostingID = JobPostingID;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getRequirements() {
        return Requirements;
    }

    public void setRequirements(String Requirements) {
        this.Requirements = Requirements;
    }

    public double getSalary() {
        return Salary;
    }

    public void setSalary(double Salary) {
        this.Salary = Salary;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String Location) {
        this.Location = Location;
    }

    public Date getPostedDate() {
        return PostedDate;
    }

    public void setPostedDate(Date PostedDate) {
        this.PostedDate = PostedDate;
    }

    public Date getClosingDate() {
        return ClosingDate;
    }

    public void setClosingDate(Date ClosingDate) {
        this.ClosingDate = ClosingDate;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public int getRecruiterID() {
        return RecruiterID;
    }

    public void setRecruiterID(int RecruiterID) {
        this.RecruiterID = RecruiterID;
    }
    
}
