/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Job_Posting_Category;

/**
 *
 * @author nhanh
 */
public class Job_Posting_CategoryDAO extends GenericDAO<Job_Posting_Category> {

    @Override
    public List<Job_Posting_Category> findAll() {
        return queryGenericDAO(Job_Posting_Category.class);
    }

    @Override
    public int insert(Job_Posting_Category t) {
        String sql = "INSERT INTO [dbo].[Job_Posting_Category]\n"
                + "           ([name])\n"
                + "     VALUES (?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", t.getName());
        return insertGenericDAO(sql, parameterMap);
    }

    public void updateJobPosting(Job_Posting_Category t) {
        String sql = "UPDATE [dbo].[Job_Posting_Category]\n"
                + "   SET [name] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", t.getName());
        updateGenericDAO(sql, parameterMap);
    }

    public Job_Posting_Category findJob_Posting_CategoryByID(int id) {
        String sql = "SELECT * FROM [dbo].[Job_Posting_Category] where id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", id);
        List<Job_Posting_Category> list = queryGenericDAO(Job_Posting_Category.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }


    public List<Job_Posting_Category> getNameById(int id) {
        String sql = "  select a.name from Job_Posting_Category a join JobPostings b \n"
                + "  on a.id = b.Job_Posting_CategoryID where a.id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", id);
        return queryGenericDAO(Job_Posting_Category.class, sql, parameterMap);
    }
}
