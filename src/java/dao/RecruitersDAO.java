/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Recruiters;

/**
 *
 * @author nhanh
 */
public class RecruitersDAO extends GenericDAO<Recruiters> {

    @Override
    public List<Recruiters> findAll() {
        return queryGenericDAO(Recruiters.class);
    }

    @Override
    public int insert(Recruiters t) {
        String sql = "INSERT INTO [dbo].[Recruiters]\n"
                + "           ,[AccountID]\n"
                + "           ,[CompanyID]\n"
                + "           ,[Position])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", t.getAccountID());
        parameterMap.put("CompanyID", t.getCompanyID());
        parameterMap.put("Position", t.getPosition());

        return insertGenericDAO(sql, parameterMap);
    }

    public Recruiters findRecruitersbyAccountID(String AccountID) {
        String sql = "SELECT [RecruiterID]\n"
                + "      ,[isVerify]\n"
                + "      ,[AccountID]\n"
                + "      ,[CompanyID]\n"
                + "      ,[Position]\n"
                + "  FROM [dbo].[Recruiters]\n"
                + "  where AccountID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", AccountID);
        List<Recruiters> list = queryGenericDAO(Recruiters.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    //Update thong tin hoc van
    public void updateRecruiters(Recruiters t) {
        String sql = "UPDATE [dbo].[Recruiters]\n"
                + "   SET [isVerify] = ?\n"
                + "      ,[AccountID] = ?\n"
                + "      ,[CompanyID] = ?\n"
                + "      ,[Position] = ?\n"
                + " WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isVerify", t.isIsVerify());
        parameterMap.put("AccountID", t.getAccountID());
        parameterMap.put("CompanyID", t.getCompanyID());
        parameterMap.put("Position", t.getPosition());
        updateGenericDAO(sql, parameterMap);
    }

    public void updateVerification(String recruiterId, boolean verify) {
        String sql = "UPDATE [dbo].[Recruiters]\n"
                + "   SET [isVerify] = ?\n"
                + " WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isVerify", verify);
        parameterMap.put("RecruiterID", recruiterId);
        updateGenericDAO(sql, parameterMap);
    }

}