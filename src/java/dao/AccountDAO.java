/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import model.Account;

/**
 *
 * @author Admin
 */
public class AccountDAO extends GenericDAO_HOLA<Account> {

    @Override
    public List<Account> findAll() {
        return queryGenericDAO();
    }

    @Override
    public int insert(Account t) {
        return 0;
    }
//    danh sach tat ca cac account

    public List<Account> findAllAccounts() {
        return findAll();
    }

    public void insertAccount(Account t) {
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[phone]\n"
                + "           ,[citizenId]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]\n"
                + "           ,[dob]\n"
                + "           ,[address]\n"
                + "           ,[avatar]\n"
                + "           ,[roleId]\n"
                + "           ,[isActive]\n"
                + "           ,[createAt]\n"
                + "           ,[updatedAt])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", t.getUsername());
        parameterMap.put("password", t.getPassword());
        parameterMap.put("email", t.getEmail());
        parameterMap.put("phone", t.getPhone());
        parameterMap.put("citizenId", t.getCitizenId());
        parameterMap.put("firstName", t.getFirstName());
        parameterMap.put("lastName", t.getLastName());
        parameterMap.put("dob", t.getDob());
        parameterMap.put("address", t.getAddress());
        parameterMap.put("avatar", t.getAvatar());
        parameterMap.put("roleId", t.getRoleId());
        parameterMap.put("isActive", t.isIsActive());
        parameterMap.put("createAt", t.getCreatAt());
        parameterMap.put("updatedAt", t.getUpdateAt());
        insertGenericDAO(sql);
    }
//  tim kiem user theo id

    public Account findUserById(Account account) {
        String sql = "SELECT [id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[email]\n"
                + "      ,[phone]\n"
                + "      ,[citizenId]\n"
                + "      ,[firstName]\n"
                + "      ,[lastName]\n"
                + "      ,[dob]\n"
                + "      ,[address]\n"
                + "      ,[avatar]\n"
                + "      ,[roleId]\n"
                + "      ,[isActive]\n"
                + "      ,[createAt]\n"
                + "      ,[updatedAt]\n"
                + "  FROM [dbo].[Account] where id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", account.getId());
        List<Account> list = queryGenericDAO(sql);
        return list.isEmpty() ? null : list.get(0);
    }
//  tim kiem user theo ten dang nhap va mat khau

    public Account findUserByUsernameAndPassword(Account account) {
        String sql = "SELECT [id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[email]\n"
                + "      ,[phone]\n"
                + "      ,[citizenId]\n"
                + "      ,[firstName]\n"
                + "      ,[lastName]\n"
                + "      ,[dob]\n"
                + "      ,[address]\n"
                + "      ,[avatar]\n"
                + "      ,[roleId]\n"
                + "      ,[isActive]\n"
                + "      ,[createAt]\n"
                + "      ,[updatedAt]\n"
                + "  FROM [dbo].[Account] where username = ? and password = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        parameterMap.put("password", account.getPassword());
        List<Account> list = queryGenericDAO(sql);
        return list.isEmpty() ? null : list.get(0);
    }
//    tim kiem theo roleId

    public Account findUserByRoleId(Account account) {
        String sql = "SELECT [id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[email]\n"
                + "      ,[phone]\n"
                + "      ,[citizenId]\n"
                + "      ,[firstName]\n"
                + "      ,[lastName]\n"
                + "      ,[dob]\n"
                + "      ,[address]\n"
                + "      ,[avatar]\n"
                + "      ,[roleId]\n"
                + "      ,[isActive]\n"
                + "      ,[createAt]\n"
                + "      ,[updatedAt]\n"
                + "  FROM [dbo].[Account] where roleId = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        parameterMap.put("password", account.getPassword());
        List<Account> list = queryGenericDAO(sql);
        return list.isEmpty() ? null : list.get(0);
    }
//    update thong tin cua account

    public void updateAccount(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[citizenId] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[avatar] = ?\n"
                + "      ,[roleId] = ?\n"
                + "      ,[isActive] = ?\n"
                + "      ,[createAt] = ?\n"
                + "      ,[updatedAt] = ?\n"
                + " WHERE id = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        parameterMap.put("password", account.getPassword());
        parameterMap.put("email", account.getEmail());
        parameterMap.put("phone", account.getPhone());
        parameterMap.put("citizenId", account.getCitizenId());
        parameterMap.put("firstName", account.getFirstName());
        parameterMap.put("lastName", account.getLastName());
        parameterMap.put("dob", account.getDob());
        parameterMap.put("address", account.getAddress());
        parameterMap.put("avatar", account.getAvatar());
        parameterMap.put("roleId", (Integer) account.getRoleId());
        parameterMap.put("createAt", account.getCreatAt());
        parameterMap.put("updatedAt", account.getUpdateAt());
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql);

    }
//    tat hoat dong mot account

    public void deactiveAccount(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [isActive] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isActive", 0);
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql);
    }

//    update password
    public void updatePassword(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [password] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("password", account.getPassword());
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql);
    }

}
