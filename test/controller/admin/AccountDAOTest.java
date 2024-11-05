package controller.admin;

import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import java.util.List;
import java.util.ArrayList;
import model.Account;
import dao.AccountDAO;

public class AccountDAOTest {
    
    private AccountDAO accountDAO;
    
    @Before
    public void setUp() {
        accountDAO = new AccountDAO();
    }
    
    @Test
    public void testFindAllUserByRoleId() {
        // Test với role seeker (roleId = 3) và page 1
        List<Account> seekers = accountDAO.findAllUserByRoleId(3, 1);
        
        // Kiểm tra list không null
        assertNotNull("List seekers should not be null", seekers);
        
        // Kiểm tra mỗi account trong list có roleId đúng
        for (Account seeker : seekers) {
            assertEquals("All accounts should have roleId = 3", 3, seeker.getRoleId());
        }
    }
    
    
    
    @Test
    public void testSearchUserByName() {
        String searchName = "0"; // Thay đổi theo dữ liệu thực tế trong DB
        List<Account> results = accountDAO.searchUserByName(searchName, 3, 1);
        if (results.size() == 0) {
            results = null;
        }
        assertNotNull("Search results should not be null", results);
        
        // Kiểm tra kết quả tìm kiếm có chứa từ khóa
        for (Account account : results) {
            assertTrue("Account name should contain search term",
                    account.getFullName().toLowerCase().contains(searchName.toLowerCase()));
        }
    }
    
    
    
    
    
    
    
    @Test
    public void testFilterUserByStatus() {
        boolean status = true;
        List<Account> results = accountDAO.filterUserByStatus(status, 3, 1);
        
        assertNotNull("Filter results should not be null", results);
        
        // Kiểm tra status của mỗi kết quả
        for (Account account : results) {
            assertEquals("Account status should match", status, account.isIsActive());
        }
    }
    
   
    @Test
    public void testActiveAccount() {
        // Tạo một account test mới hoặc lấy một account có sẵn
        Account testAccount = accountDAO.findUserById(1); // Thay đổi ID theo dữ liệu thực tế
        if (testAccount != null) { 
            // Test active
            accountDAO.activeAccount(testAccount);
            Account activatedAccount = accountDAO.findUserById(testAccount.getId());
            assertTrue("Account should be activated", activatedAccount.isIsActive());
        }
    }
    
    @Test
    public void testFindUserById() {
        // Test với một ID hợp lệ
        int validId = 1; // Thay đổi theo dữ liệu thực tế
        Account account = accountDAO.findUserById(validId);
        assertNotNull("Should find an account with valid ID", account);
        assertEquals("Account ID should match", validId, account.getId());
        
        // Test với một ID không tồn tại
        int invalidId = -1;
        Account nullAccount = accountDAO.findUserById(invalidId);
        assertNull("Should return null for invalid ID", nullAccount);
    }
}