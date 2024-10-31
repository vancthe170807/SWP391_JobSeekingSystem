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
                + "[JobSeekerID],[CVID],[Status])"
                + "VALUES (?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", t.getJobPostingID());
        parameterMap.put("JobSeekerID", t.getJobSeekerID());
        parameterMap.put("CVID", t.getCVID());
        parameterMap.put("Status", t.getStatus());

        return insertGenericDAO(sql, parameterMap);
    }

    //Danh sach don xin viec tu seeker
    public List<Applications> findApplicationByJobSeekerID(int id, int page, int pageSize) {
        String sql = "select * from Applications where JobSeekerID = ? ORDER BY ApplicationID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("JobSeekerID", id);
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }
    
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

    // Danh sach don xin viec tu Status = Appending
    public List<Applications> findApplicationByPending() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 3);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Agree
    public List<Applications> findApplicationByApproved() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 2);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Reject
    public List<Applications> findApplicationByReject() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 1);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Cancel
    public List<Applications> findApplicationByCancel() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 4);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }
    
    public List<Applications> findApplicationByJobSeekerIDAndStatus(int jobSeekerID, int status, int page, int pageSize) {
        String sql = "SELECT * FROM Applications WHERE JobSeekerID = ? AND Status = ? ORDER BY ApplicationID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", jobSeekerID);
        parameterMap.put("Status", status);
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    public Applications getDetailApplication(int applicationID) {
        String sql = "select * from Applications where ApplicationID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ApplicationID", applicationID);
        List<Applications> list = queryGenericDAO(Applications.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    //Update Status of Application
    public void cancelApplication(int applicationId, int status) {
        String sql = "UPDATE [Applications] SET [Status] = ? WHERE [ApplicationID] = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("ApplicationID", applicationId);
        updateGenericDAO(sql, parameterMap);
    }

    public Applications findPendingApplication(int jobSeekerID, int jobPostingID) {
        String sql = "SELECT * FROM Applications WHERE JobSeekerID = ? AND JobPostingID = ? AND Status = 1";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", jobSeekerID);
        parameterMap.put("JobPostingID", jobPostingID);
        List<Applications> list = queryGenericDAO(Applications.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
    
    public int countTotalApplicationsByJSIDAndStatus(int jobSeekerID, int status) {
        String sql = "SELECT count(*) FROM [dbo].[Applications] WHERE JobSeekerID = ? AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", jobSeekerID);
        parameterMap.put("Status", status);
        return findTotalRecordGenericDAO(Applications.class, sql, parameterMap);
    }
    
    public int countTotalApplicationsByJSID(int jobSeekerID) {
        String sql = "SELECT count(*) FROM [dbo].[Applications] WHERE JobSeekerID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", jobSeekerID);
        return findTotalRecordGenericDAO(Applications.class, sql, parameterMap);
    }
}
