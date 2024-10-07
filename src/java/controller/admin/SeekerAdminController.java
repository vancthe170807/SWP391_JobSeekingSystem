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
import java.util.List;
import model.Account;

@WebServlet(name="SeekerAdminController", urlPatterns={"/seekers"})
public class SeekerAdminController extends HttpServlet {
    AccountDAO dao = new AccountDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ///get ve action 
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        // get ve danh sach list seeker
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
        List<Account> listSeekers;
        switch (filter) {
            
            case "all":
                listSeekers = dao.findAllUserByRoleId(3);
                break;
            case "active":
                listSeekers = dao.filterSeekerByStatus(true);
                break;
            case "inactive":
                listSeekers = dao.filterSeekerByStatus(false);
                break;
            default:
                 listSeekers = dao.findAllUserByRoleId(3);
        }
        request.setAttribute("listSeekers", listSeekers);
        // Handle GET requests based on the action
        
        switch (action) {
            case "view-list-seekers":
                url = "view/admin/listSeeker.jsp";
                break;
            default:
                url = "view/admin/listSeeker.jsp";
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
        
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        int id = Integer.parseInt(request.getParameter("id-seeker"));
        Account account = dao.findUserById(id);
        switch (action) {
            case "deactive":
                url = deactive(request, response, account);
                break;
            case "active":
                url = active(request, response, account);
                break;
            case "view-detail":
                url = viewDetail(request, response, account);
                break;
            default:
                url = "view/admin/listSeeker.jsp";
        }
       response.sendRedirect(url);
    }

    private String deactive(HttpServletRequest request, HttpServletResponse response, Account account) {
        dao.deactiveAccount(account);
        return "seekers";
    }

    private String active(HttpServletRequest request, HttpServletResponse response, Account account) {
        dao.activeAccount(account);
        return "seekers";
    }

    private String viewDetail(HttpServletRequest request, HttpServletResponse response, Account account) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

   
    

}