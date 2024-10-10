/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.JobPostings;

/**
 *
 * @author nhanh
 */
public class JobPostingsDAO extends GenericDAO<JobPostings> {

    @Override
    public List<JobPostings> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int insert(JobPostings t) {
        String sql = "INSERT INTO [dbo].[JobPostings]\n"
                + "           ,[Title]\n"
                + "           ,[Description]\n"
                + "           ,[Requirements]\n"
                + "           ,[Salary]\n"
                + "           ,[Location]\n"
                + "           ,[PostedDate]\n"
                + "           ,[ClosingDate]\n"
                + "           ,[Status])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("Salary", t.getSalary());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
        parameterMap.put("Status", t.getStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public JobPostings findJobPostingById(int ID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] where JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", ID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public void updateJobPosting(JobPostings jobPostingEdit) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [Title] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Requirements] = ?\n"
                + "      ,[Salary] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[PostedDate] = ?\n"
                + "      ,[ClosingDate] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", jobPostingEdit.getTitle());
        parameterMap.put("Description", jobPostingEdit.getDescription());
        parameterMap.put("Requirements", jobPostingEdit.getRequirements());
        parameterMap.put("Salary", jobPostingEdit.getSalary());
        parameterMap.put("Location", jobPostingEdit.getLocation());
        parameterMap.put("PostedDate", jobPostingEdit.getPostedDate());
        parameterMap.put("ClosingDate", jobPostingEdit.getClosingDate());
        parameterMap.put("Status", jobPostingEdit.getStatus());
        parameterMap.put("JobPostingID", jobPostingEdit.getJobPostingID());
        updateGenericDAO(sql, parameterMap);
    }

    public void deleteJobPosting(JobPostings jobPostingEdit) {
        String sql = "DELETE FROM [dbo].[JobPostings]\n"
                + "      WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingEdit.getJobPostingID());
        deleteGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> searchJobPostingByTitle(String title) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "WHERE Title LIKE '%' + ? + '%'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", title);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

}
