/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Education;

/**
 *
 * @author vanct
 */
public class EducationDAO extends GenericDAO<Education> {

    @Override
    public List<Education> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Nhap thong tin Dao tao
    @Override
    public int insert(Education t) {
        String sql = "INSERT INTO Education(JobSeekerID, Institution, Degree, FieldOfStudy, StartDate, EndDate) values \n"
                + "  (?, ?, ?, ?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", t.getJobSeekerID());
        parameterMap.put("Institution", t.getInstitution());
        parameterMap.put("Degree", t.getDegree());
        parameterMap.put("FieldOfStudy", t.getFieldOfStudy());
        parameterMap.put("StartDate", t.getStartDate());
        parameterMap.put("EndDate", t.getEndDate());
        
        return insertGenericDAO(sql, parameterMap);
    }
    
    //Tim CV cho Job Seeker
    public Education findEducationbyJobSeekerID(int JobSeekerID) {
        String sql = "select * from Education where JobSeekerID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", JobSeekerID);
        List<Education> list = queryGenericDAO(Education.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
        
    }
    
    //Update thong tin hoc van
    public void updateEducation(Education education) {
        String sql = "UPDATE [dbo].[Education]\n"
                + "   SET [Institution] = ?\n"
                + "      ,[Degree] = ?\n"
                + "      ,[FieldOfStudy] = ?\n"
                + "      ,[StartDate] = ?\n"
                + "      ,[EndDate] = ?\n"
                + " WHERE JobSeekerID = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Institution", education.getInstitution());
        parameterMap.put("Degree", education.getDegree());
        parameterMap.put("FieldOfStudy", education.getFieldOfStudy());
        parameterMap.put("StartDate", education.getStartDate());
        parameterMap.put("EndDate", education.getEndDate());
        parameterMap.put("JobSeekerID", education.getJobSeekerID());
        
        updateGenericDAO(sql, parameterMap);
    }

}
