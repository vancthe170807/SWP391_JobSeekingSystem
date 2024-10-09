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
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
                + "   SET [verificationStatus] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", 0);
        parameterMap.put("id", company.getId());
        updateGenericDAO(sql, parameterMap);
    }

    public void acceptCompany(Company company) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [verificationStatus] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isActive", 1);
        parameterMap.put("id", company.getId());
        updateGenericDAO(sql, parameterMap);
    }

}
