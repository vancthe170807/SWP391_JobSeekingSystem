/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.LinkedHashMap;
import java.util.List;
import model.Account;
import model.Company;
import org.eclipse.jdt.internal.compiler.lookup.TypeConstants;

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

    public List<Company> filterCompanyByStatus(boolean status, int page) {
        String sql = "SELECT *\n"
                + "  FROM [JobSeeker].[dbo].[Company]\n"
                + "  where verificationStatus = ?\n"
                + "  order by id\n"
                + "  offset ? rows\n"
                + "  fetch next ? rows only";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", status);
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
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

    public List<Company> searchCompaniesByName(String searchQuery, int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[Company]\n"
                + "WHERE name LIKE ?\n"
                + "order by id\n"
                + "offset ? rows\n"
                + "fetch next ? rows only";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", "%" + searchQuery + "%");
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
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

    public int findAllTotalRecord() {
        String sql = "SELECT count(*) FROM [dbo].[Company]\n";
        parameterMap = new LinkedHashMap<>();
        return findTotalRecordGenericDAO(Company.class, sql, parameterMap);
    }

    public int findTotalRecordByStatus(boolean verificationStatus) {
        String sql = "SELECT count(*)\n"
                + "  FROM [dbo].[Company]\n"
                + "  where verificationStatus = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("verificationStatus", verificationStatus);
        return findTotalRecordGenericDAO(Company.class, sql, parameterMap);
    }

    public List<Company> findAllCompany(int page) {
        String sql = "SELECT *\n"
                + "  FROM [JobSeeker].[dbo].[Company]\n"
                + "  order by id\n"
                + "  offset ? rows\n"
                + "  fetch next ? rows only";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(Company.class, sql, parameterMap);
    }

    public int findTotalRecordByName(String searchQuery) {
        String sql = "SELECT count(*)\n"
                + "FROM [dbo].[Company]\n"
                + "WHERE name LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", "%" + searchQuery + "%");
        return findTotalRecordGenericDAO(Company.class, sql, parameterMap);
    }
    // Tìm công ty theo từ khóa và trạng thái (chấp nhận hoặc vi phạm)

    public List<Company> searchCompaniesByNameAndStatus(String searchQuery, boolean status, int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[Company]\n"
                + "WHERE name LIKE ? AND verificationStatus = ?\n"
                + "ORDER BY id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", "%" + searchQuery + "%");
        parameterMap.put("verificationStatus", status);
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(Company.class, sql, parameterMap);
    }

// Đếm tổng số bản ghi theo từ khóa và trạng thái
    public int findTotalRecordByNameAndStatus(String searchQuery, boolean status) {
        String sql = "SELECT count(*)\n"
                + "FROM [dbo].[Company]\n"
                + "WHERE name LIKE ? AND verificationStatus = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", "%" + searchQuery + "%");
        parameterMap.put("verificationStatus", status);
        return findTotalRecordGenericDAO(Company.class, sql, parameterMap);
    }

    public List<Company> getCompanyNameByAccountId(int id) {
        String sql = "select\n"
                + "	c.*\n"
                + "from \n"
                + "	Account as acc\n"
                + "	, Recruiters as rc\n"
                + "	, Company as c\n"
                + "where \n"
                + "	acc.id = rc.AccountID\n"
                + "	AND rc.CompanyID = c.id\n"
                + "	AND acc.id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("accId", id);
        return queryGenericDAO(Company.class, sql, parameterMap);
    }

    public static void main(String[] args) {
        CompanyDAO dao = new CompanyDAO();
        List<Company> companies = dao.getCompanyNameByAccountId(2);
        System.out.println(companies.size());
    }

    public boolean checkExistNameCompany(String name) {
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Company]\n"
                + "  where name = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("name", name);
        return !queryGenericDAO(Company.class, sql, parameterMap).isEmpty();
    }

    public boolean isCompanyExist(int companyId) {
        // Gọi phương thức findCompanyById để kiểm tra xem công ty có tồn tại không
        Company company = findCompanyById(companyId);

        // Nếu company khác null thì công ty tồn tại, ngược lại thì không
        return company != null;
    }

}
