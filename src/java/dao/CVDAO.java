/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.CV;

/**
 *
 * @author vanct
 */
public class CVDAO extends GenericDAO<CV> {

    @Override
    public List<CV> findAll() {
        return queryGenericDAO(CV.class);
    }

    //Nhap CV
    @Override
    public int insert(CV t) {
        String sql = "insert into CVs (JobSeekerID, FilePath, UploadDate) values (?, ?, ?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", t.getJobSeekerID());
        parameterMap.put("FilePath", t.getFilePath());
        parameterMap.put("UploadDate", t.getUploadDate());
        
        return insertGenericDAO(sql, parameterMap);
    }
    
    //Tim CV cho Job Seeker
    public CV findCVbyJobSeekerID(int JobSeekerID) {
        String sql = "select * from CVs by JobSeekerID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobSeekerID", JobSeekerID);
        List<CV> list = queryGenericDAO(CV.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
        
    }
    
    public void updateCV(CV cv) {
        String sql = "update CVs set FilePath = ?, LastUpdated = ? WHERE JobSeekerID = ?";
        
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("FilePath", cv.getFilePath());
        parameterMap.put("JobSeekerID", cv.getJobSeekerID());
        parameterMap.put("LastUpdated", cv.getLastUpdated());
        
        updateGenericDAO(sql, parameterMap);
    }
    
    

}
