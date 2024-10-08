/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.CompanyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Account;
import model.Company;

@WebServlet(name="CompanyAdminController", urlPatterns={"/companies"})
public class CompanyAdminController extends HttpServlet {
    CompanyDAO dao = new CompanyDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
        List<Company> listCompanies;
        switch (filter) {
            
            case "all":
                listCompanies = dao.findAll();
                break;
            case "accept":
                listCompanies = dao.filterCompanyByStatus(true);
                break;
            case "violate":
                listCompanies = dao.filterCompanyByStatus(false);
                break;
            default:
                 listCompanies = dao.findAll();
        }
        request.setAttribute("listCompanies", listCompanies);
        // Handle GET requests based on the action
        // SWT: CRITICAL(CODE_SMELL)
        switch (action) {
            case "add-company":
                url = "view/admin/addCompany.jsp";
                break;
            default:
                url = "view/admin/companyManagement.jsp";
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        int id = Integer.parseInt(request.getParameter("id-company"));
        Company company = dao.findCompanyById(id);
        switch (action) {
            case "violate":
                url = violateCompany(request, response, company);
                break;
            case "accept":
                url = accepetCompany(request, response, company);
                break;    
            default:
                url = "view/admin/companyManagement.jsp";
        }
       response.sendRedirect(url);
    }

    private String violateCompany(HttpServletRequest request, HttpServletResponse response, Company company) {
        dao.violateCompany(company);
        return "companies";
    }

    private String accepetCompany(HttpServletRequest request, HttpServletResponse response, Company company) {
        dao.acceptCompany(company);
        return "companies";
    }

   
     

}