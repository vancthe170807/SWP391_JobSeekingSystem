/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Account;
import model.Company;

/**
 *
 * @author Admin
 */
public class CompanyDAO extends GenericDAO<Company> {

    @Override
    public List<Company> findAll() {
        return queryGenericDAO(Company.class);
    }

    @Override
    public int insert(Company t) {
        String sql = "INSERT INTO [dbo].[Company]\n"
                + "           ([name]\n"
                + "           ,[description]\n"
                + "           ,[location]\n"
                + "           ,[verificationStatus])\n"
                + "     VALUES(?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", t.getName());
        parameterMap.put("description", t.getDescription());
        parameterMap.put("location", t.getLocation());
        parameterMap.put("verificationStatus", t.isVerificationStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<Company> filterCompanyByStatus(boolean status) {
        String sql = "SELECT * FROM [dbo].[Company] where verificationStatus = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", status);
        List<Company> list = queryGenericDAO(Company.class, sql, parameterMap);
        return list;
    }

    public Company findCompanyById(int id) {
        String sql = "SELECT * FROM [dbo].[Company] where id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", id);
        List<Company> list = queryGenericDAO(Company.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public void violateCompany(Company company) {
        String sql = "UPDATE [dbo].[Company]\n"
                + "   SET \n"
                + "      [verificationStatus] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", 0);
        parameterMap.put("id", company.getId());
        updateGenericDAO(sql, parameterMap);
    }

    public void acceptCompany(Company company) {
        String sql = "UPDATE [dbo].[Company]\n"
                + "   SET \n"
                + "      [verificationStatus] = ?\n"
                + "      \n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", 1);
        parameterMap.put("id", company.getId());
        updateGenericDAO(sql, parameterMap);
    }

    public List<Company> searchCompaniesByName(String searchQuery) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[Company]\n"
                + "WHERE name LIKE '%' + ? + '%'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", searchQuery);
        return queryGenericDAO(Company.class, sql, parameterMap);
    }

    public void updateCompany(Company companyEdit) {
        String sql = "UPDATE [dbo].[Company]\n"
                + "   SET [name] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[location] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", companyEdit.getName());
        parameterMap.put("description", companyEdit.getDescription());
        parameterMap.put("location", companyEdit.getLocation());
        parameterMap.put("id", companyEdit.getId());
        updateGenericDAO(sql, parameterMap);
    }
}
