/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.sql.*;
import model.Account;

/**
 *
 * @author Admin
 */
public class AccountDAO extends GenericDAO<Account> {

    @Override
    public List<Account> findAll() {
        return queryGenericDAO(Account.class);
    }

    @Override
    public int insert(Account t) {
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[email]\n"
                + "           ,[phone]\n"
                + "           ,[firstName]\n"
                + "           ,[lastName]\n"
                + "           ,[dob]\n"
                + "           ,[address]\n"
                + "           ,[avatar]\n"
                + "           ,[roleId]\n"
                + "           ,[isActive]\n"
                + "           ,[createAt]\n"
                + "           ,[updatedAt]\n"
                + "           ,[gender])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", t.getUsername());
        parameterMap.put("password", t.getPassword());
        parameterMap.put("email", t.getEmail());
        parameterMap.put("phone", t.getPhone());
        parameterMap.put("firstName", t.getFirstName());
        parameterMap.put("lastName", t.getLastName());
        parameterMap.put("dob", t.getDob());
        parameterMap.put("address", t.getAddress());
        parameterMap.put("avatar", t.getAvatar());
        parameterMap.put("roleId", t.getRoleId());
        parameterMap.put("isActive", true);
        parameterMap.put("createAt", t.getCreateAt());
        parameterMap.put("updatedAt", t.getUpdatedAt());
        parameterMap.put("gender", t.isGender());
        
        return insertGenericDAO(sql, parameterMap);
    }
//    danh sach tat ca cac account

    public List<Account> findAllAccounts() {
        return findAll();
    }
    
//  tim kiem user theo id
    public Account findUserById(int id) {
        String sql = "SELECT * FROM [dbo].[Account] where id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("id", id);
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
//  tim kiem user theo ten dang nhap va mat khau

    public Account findUserByUsernameAndPassword(Account account) {
        String sql = "SELECT * FROM [dbo].[Account] where username = ? and password = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        parameterMap.put("password", account.getPassword());
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
    
    public Account findUserByUsername(Account account) {
        String sql = "select * from Account where username = '?'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
       
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
//    hiển thi các user theo role
    public List<Account> findAllUserByRoleId(int roleId){
        String sql = "SELECT * FROM [dbo].[Account] where roleId = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("roleId", roleId);
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list;
    }
//    update thong tin cua account

    public void updateAccount(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [username] = ?\n"
                + "      ,[password] = ?\n"
                + "      ,[email] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[firstName] = ?\n"
                + "      ,[lastName] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[avatar] = ?\n"
                + "      ,[roleId] = ?\n"
                + "      ,[isActive] = ?\n"
                + "      ,[createAt] = ?\n"
                + "      ,[updatedAt] = getDate()\n"
                + "      ,[gender] = ?\n"
                + " WHERE id = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        parameterMap.put("password", account.getPassword());
        parameterMap.put("email", account.getEmail());
        parameterMap.put("phone", account.getPhone());
        parameterMap.put("firstName", account.getFirstName());
        parameterMap.put("lastName", account.getLastName());
        parameterMap.put("dob", account.getDob());
        parameterMap.put("address", account.getAddress());
        parameterMap.put("avatar", account.getAvatar());
        parameterMap.put("roleId", (Integer) account.getRoleId());
        parameterMap.put("isActive", account.isIsActive());
        parameterMap.put("createAt", account.getCreateAt());
        parameterMap.put("gender", account.isGender());
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql, parameterMap);
    }
        

//    tat hoat dong mot account

    public void deactiveAccount(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [isActive] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isActive", 0);
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql, parameterMap);
    }

//    update password
    public void updatePassword(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [password] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("password", account.getPassword());
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql, parameterMap);
    }
    
    public void updatePasswordByUsername(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [password] = ?\n, [updatedAt] = (getDate())"
                + " WHERE username = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("password", account.getPassword());
        parameterMap.put("username", account.getUsername());
        updateGenericDAO(sql, parameterMap);
    }

    public boolean checkUsernameExist(Account account) {
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Account]\n"
                + "  where username = ? ";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("username", account.getUsername());
        return !queryGenericDAO(Account.class, sql, parameterMap).isEmpty();
    }
    
    public boolean checkUserEmailExist(Account account) {
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Account]\n"
                + "  where email = ? ";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("email", account.getEmail());
        return !queryGenericDAO(Account.class, sql, parameterMap).isEmpty();
    }
    
   public Account checkUserExistByEmail(String email) {
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Account]\n"
                + "  where email = ? ";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("email", email);
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }
    public static void main(String[] args) {
//        Account account = new Account("nam", "xcvxcvx",
//                "vxcvxcvx@gmail.com",
//                "vcxvcxvxc", "vcxvcxvxc", "vcxvcxvxc",
//                "vcxvcxvxc", null,
//                "vcxvcxvxc",
//                "vcxvcxvxc", 1, true, null, null);
//        new AccountDAO().insert(account);
//        System.out.println(new AccountDAO().checkUsernameExist(account));

    }

    //    update password
    public void updatePasswordbyEmail(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [password] = ?\n"
                + " WHERE email = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("password", account.getPassword());
        parameterMap.put("email", account.getEmail());
        updateGenericDAO(sql, parameterMap);
    }
    
    //    get active, inactive account
    public List<Account> filterSeekerByStatus(boolean status) {
        String sql = "SELECT * FROM [dbo].[Account] where isActive = ? and roleId = 3";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isActive", status);
        List<Account> list = queryGenericDAO(Account.class, sql, parameterMap);
        return list;
    }

    
    //    active account
    public void activeAccount(Account account) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [isActive] = ?\n"
                + " WHERE id = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("isActive", 1);
        parameterMap.put("id", account.getId());
        updateGenericDAO(sql, parameterMap);
    }

}
