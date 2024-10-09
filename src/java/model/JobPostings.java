/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author nhanh
 */
public class JobPostings {
    private int CompanyID;
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

    public JobPostings(int CompanyID, String Title, String Description, String Requirements, double Salary, String Location, Date PostedDate, Date ClosingDate, String Status) {
        this.CompanyID = CompanyID;
        this.Title = Title;
        this.Description = Description;
        this.Requirements = Requirements;
        this.Salary = Salary;
        this.Location = Location;
        this.PostedDate = PostedDate;
        this.ClosingDate = ClosingDate;
        this.Status = Status;
    }

    public int getCompanyID() {
        return CompanyID;
    }

    public void setCompanyID(int CompanyID) {
        this.CompanyID = CompanyID;
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

    @Override
    public String toString() {
        return "JobPostings{" + "CompanyID=" + CompanyID + ", Title=" + Title + ", Description=" + Description + ", Requirements=" + Requirements + ", Salary=" + Salary + ", Location=" + Location + ", PostedDate=" + PostedDate + ", ClosingDate=" + ClosingDate + ", Status=" + Status + '}';
    }
    
    
}
