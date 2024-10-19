/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Applications;

/**
 *
 * @author vanct
 */
public class ApplicationDAO extends GenericDAO<Applications> {

    @Override
    public List<Applications> findAll() {
        return queryGenericDAO(Applications.class);
    }

    @Override
    public int insert(Applications t) {
        String sql = "INSERT INTO [dbo].[Applications] ([JobPostingID],"
                + "[JobSeekerID],[CVID],[Status],[AppliedDate])"
                + "VALUES (?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", t.getJobPostingID());
        parameterMap.put("CVID", t.getCVID());
        parameterMap.put("Status", t.getStatus());
        parameterMap.put("AppliedDate", t.getAppliedDate());

        return insertGenericDAO(sql, parameterMap);
    }

    //Danh sach don xin viec tu seeker
    public List<Applications> findApplicationByJobSeekerID(int id) {
        String sql = "select * from Applications where JobSeekerID = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("JobSeekerID", id);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    //Danh sach don xin viec tu JobPosting
    public List<Applications> findApplicationByJobPostingID(int id) {
        String sql = "select * from Applications where JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("JobPostingID", id);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Pending
    public List<Applications> findApplicationByPending() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", "Pending");
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Accept
    public List<Applications> findApplicationByAccept() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", "Accept");
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Reject
    public List<Applications> findApplicationByReject() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", "Reject");
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }
    
    //Update Status of Application
    public void updateStatus(Applications application) {
        String sql = "update [Applications] set [Status] = ?"
                + "WHERE [ApplicationID] = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", application.getStatus());
        parameterMap.put("ApplicationID", application.getApplicationID());
        
        updateGenericDAO(sql, parameterMap);
    }

}
