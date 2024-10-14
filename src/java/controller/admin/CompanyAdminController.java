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

@WebServlet(name = "CompanyAdminController", urlPatterns = {"/companies"})
public class CompanyAdminController extends HttpServlet {

    CompanyDAO dao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
//        get ve gia tri cua drop-down filter
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
//        get ve gia tri tu thanh search
        String searchQuery = request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "";
        List<Company> listCompanies;
        if (!searchQuery.isEmpty()) {
            // Tìm kiếm công ty dựa trên từ khóa
            listCompanies = dao.searchCompaniesByName(searchQuery);  // Thực hiện tìm kiếm
        } else {
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
        switch (action) {
            case "violate":
                url = violateCompany(request);
                break;
            case "accept":
                url = accepetCompany(request);
                break;
            case "add-company":
                url = addCompany(request);
                break;
            case "edit-company":
                url = editCompany(request);
                break;
            default:
                url = "view/admin/companyManagement.jsp";
        }
        response.sendRedirect(url);
    }

    private String violateCompany(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id-company"));
        Company company = dao.findCompanyById(id);
        dao.violateCompany(company);
        return "companies";
    }

    private String accepetCompany(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id-company"));
        Company company = dao.findCompanyById(id);
        dao.acceptCompany(company);
        return "companies";
    }

    private String addCompany(HttpServletRequest request) {
//        get ve cac thuoc tinh cua company
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String verificationStatus = request.getParameter("verificationStatus");
//        tao doi tuong company va set cac thuoc tinh
        Company company = new Company();
        company.setName(name);
        company.setDescription(description);
        company.setLocation(location);
        switch (verificationStatus) {
            case "accept":
                company.setVerificationStatus(true);
                break;
            case "violate":
                company.setVerificationStatus(false);
                break;
            default:
                company.setVerificationStatus(true);
        }
        dao.insert(company);
        return "companies";
    }

    private String editCompany(HttpServletRequest request) {
//        get ve cac gia tri cua company de edit
        int id = Integer.parseInt(request.getParameter("id-company"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
//        tim company theo id 
        Company companyEdit = dao.findCompanyById(id);
//        set cac gia tri moi
        companyEdit.setName(name);
        companyEdit.setDescription(description);
        companyEdit.setLocation(location);
        dao.updateCompany(companyEdit);
        return "companies";
    }
}
