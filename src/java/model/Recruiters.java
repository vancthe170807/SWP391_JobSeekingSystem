/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author nhanh
 */
public class Recruiters {
    private int RecruiterID;
    private boolean isVerify;
    private int AccountID;
    private int CompanyID;
    private String Position;

    public Recruiters() {
    }

    public Recruiters(int RecruiterID, boolean isVerify, int AccountID, int CompanyID, String Position) {
        this.RecruiterID = RecruiterID;
        this.isVerify = isVerify;
        this.AccountID = AccountID;
        this.CompanyID = CompanyID;
        this.Position = Position;
    }

    public int getRecruiterID() {
        return RecruiterID;
    }

    public void setRecruiterID(int RecruiterID) {
        this.RecruiterID = RecruiterID;
    }

    public boolean isIsVerify() {
        return isVerify;
    }

    public void setIsVerify(boolean isVerify) {
        this.isVerify = isVerify;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public int getCompanyID() {
        return CompanyID;
    }

    public void setCompanyID(int CompanyID) {
        this.CompanyID = CompanyID;
    }

    public String getPosition() {
        return Position;
    }

    public void setPosition(String Position) {
        this.Position = Position;
    }
    
    
}
