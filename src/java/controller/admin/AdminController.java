/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import validate.Validation;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    AccountDAO dao = new AccountDAO();
    Validation validate = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/admin/createAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        switch (action) {
            case "create":
                url = createAdmin(request);
                break;
            case "view-list":
                url = viewListAdmin(request);
                break;
            case "delete":
                url = deleteAdmin(request);
                break;
            default:
                throw new AssertionError();
        }
        
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String createAdmin(HttpServletRequest request) {
//get ve cac parameter trong form create
        String lastName = request.getParameter("lastname");
        String firstName = request.getParameter("firstname");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        //set data to fill the form
        request.setAttribute("lname", lastName);
        request.setAttribute("fname", firstName);
        request.setAttribute("phone", phone);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        //set vao doi tuong account
        Account account = new Account();
        account.setLastName(lastName);
        account.setFirstName(firstName);
        account.setPhone(phone);
        account.setUsername(username);
        account.setPassword(password);
        account.setRoleId(1);
        //bien check validate username
        boolean checkExistUsername = dao.checkUsernameExist(account);
        Map<String, String> errorMessages = new HashMap<>();
        //check valid cac field
        if (!validate.checkName(lastName)) {
            errorMessages.put("errorLname", "Last name is not valid!");
        }
        if (!validate.checkName(firstName)) {
            errorMessages.put("errorFname", "First name is not valid!");
        }
        if (!validate.CheckPhoneNumber(phone)) {
            errorMessages.put("errorPhone", "Phone number is not valid!");
        }
        if (!validate.checkUserName(username)) {
            errorMessages.put("errorUsername", "Username is not valid!");
        }
        if (checkExistUsername) {
            errorMessages.put("errorDuplicateUsername", "The username is exist!");
        }
        if (!validate.checkPassword(password)) {
            errorMessages.put("errorPassword", "Password must follow the convention!");
        }
//        set cac error vao trong map
        if (!errorMessages.isEmpty()) {
            // Set error messages in request attributes
            for (Map.Entry<String, String> entry : errorMessages.entrySet()) {
                request.setAttribute(entry.getKey(), entry.getValue());
            }
        } else {
            dao.insert(account);
            request.setAttribute("success", "Create successfully !");
        }
        return "view/admin/createAdmin.jsp";
    }

    private String viewListAdmin(HttpServletRequest request) {
        List<Account> listAdmin = dao.findAllUserByRoleId(1, 1);
        request.setAttribute("listAdmin", listAdmin);
        return "view/admin/createAdmin.jsp";
    }

    private String deleteAdmin(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        Account account = dao.findUserById(id);;
        
        dao.deactiveAccount(account);
        return "view/admin/createAdmin.jsp";
    }

}
