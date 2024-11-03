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
        List<Applications> applications = queryGenericDAO(Applications.class, sql, parameterMap);
        JobSeekerDAO jobSeekerDao = new JobSeekerDAO();
        for (Applications application : applications) {
            application.setJobSeeker(jobSeekerDao.findJobSeekerIDByJobSeekerID(application.getJobSeekerID() + ""));
        }
        return applications;
    }

    // Danh sach don xin viec tu Status = Appending
    public List<Applications> findApplicationByAppending() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 1);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Agree
    public List<Applications> findApplicationByAgree() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 2);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Reject
    public List<Applications> findApplicationByReject() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 3);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    // Danh sach don xin viec tu Status = Cancel
    public List<Applications> findApplicationByCancel() {
        String sql = "select * from Applications where Status = ?";
        parameterMap = new LinkedHashMap<>();

        parameterMap.put("Status", 4);
        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    public Applications getDetailApplication(int applicationID) {
        String sql = "select * from Applications where ApplicationID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("ApplicationID", applicationID);
        List<Applications> applications = queryGenericDAO(Applications.class, sql, parameterMap);
        JobSeekerDAO jobSeekerDao = new JobSeekerDAO();
        for (Applications application : applications) {
            application.setJobSeeker(jobSeekerDao.findJobSeekerIDByJobSeekerID(application.getJobSeekerID() + ""));
        }
        return applications.isEmpty() ? null : applications.get(0);
    }

    //Update Status of Application
    public void cancelApplication(int applicationId, int status) {
        String sql = "update [Applications] set[Status] = ?"
                + "WHERE [ApplicationID] = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("ApplicationID", applicationId);

        updateGenericDAO(sql, parameterMap);
    }

    public void ChangeStatusApplication(int applicationId, int status) {
        String sql = "update [Applications] set[Status] = ? "
                + "WHERE [ApplicationID] = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("ApplicationID", applicationId);

        updateGenericDAO(sql, parameterMap);
    }

    //
    public List<Applications> getApplicationsWithJobPostingStatus() {
        // Define the SQL query
        String sql = "SELECT Applications.*, JobPostings.Status AS JobPostingStatus "
                + "FROM Applications "
                + "JOIN JobPostings ON Applications.JobPostingID = JobPostings.JobPostingID";

        // Initialize parameter map (no parameters in this query, but we follow the pattern)
        parameterMap = new LinkedHashMap<>();
        return queryGenericDAO(Applications.class, sql, parameterMap);

    }

    public List<Applications> findApplicationsByJobPostingIDWithPagination(int jobPostId, int offset, int pageSize) {
        String sql = "SELECT * FROM Applications WHERE JobPostingID = ? ORDER BY AppliedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostId);
        parameterMap.put("offset", offset);
        parameterMap.put("pageSize", pageSize);

        return queryGenericDAO(Applications.class, sql, parameterMap);
    }

    public int countApplicationsByJobPostingID(int jobPostId) {
        String sql = "SELECT COUNT(*) FROM Applications WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostId);

         return findTotalRecordGenericDAO(Applications.class, sql, parameterMap);
    }

    
    
   
}
