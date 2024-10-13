/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import static constant.CommonConst.RECORD_PER_PAGE;
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
import model.PageControl;

@WebServlet(name = "CompanyAdminController", urlPatterns = {"/companies"})
public class CompanyAdminController extends HttpServlet {

    CompanyDAO dao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get ve pageNumber
        PageControl pageControl = new PageControl();
        String pageRaw = request.getParameter("page");
        //valid page
        int page;
        try {
            page = Integer.parseInt(pageRaw);
            if (page <= 1) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
//        get ve gia tri cua drop-down filter
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
//        get ve gia tri tu thanh search
        String searchQuery = request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "";
        List<Company> listCompanies;
        //get ve request URL
        String requestURL = request.getRequestURL().toString();
        //total record
        int totalRecord = 0;
        if (!searchQuery.isEmpty()) {
            // Tìm kiếm công ty dựa trên từ khóa
            listCompanies = dao.searchCompaniesByName(searchQuery, page);  // Thực hiện tìm kiếm
            totalRecord = dao.findTotalRecordByName(searchQuery);
            if(filter == null){
                pageControl.setUrlPattern(requestURL + "?");
            }else if(filter.equalsIgnoreCase("all")){
                pageControl.setUrlPattern(requestURL + "?filter=all" + "&" + "searchQuery=" + searchQuery + "&");
            }else if (filter.equalsIgnoreCase("accept")) {
                pageControl.setUrlPattern(requestURL + "?filter=accept" + "&" + "searchQuery=" + searchQuery + "&");
            }else if (filter.equalsIgnoreCase("violate")) {
                pageControl.setUrlPattern(requestURL + "?filter=violate" + "&" + "searchQuery=" + searchQuery + "&");
            }
        } else {       
            switch (filter) {
                case "all":
                    listCompanies = dao.findAllCompany(page);
                    totalRecord = dao.findAllTotalRecord();
                    pageControl.setUrlPattern(requestURL + "?");
                    break;
                case "accept":
                    listCompanies = dao.filterCompanyByStatus(true, page);
                    totalRecord = dao.findTotalRecordByStatus(true);
                    pageControl.setUrlPattern(requestURL + "?filter=accept" + "&");
                    break;
                case "violate":
                    listCompanies = dao.filterCompanyByStatus(false, page);
                    totalRecord = dao.findTotalRecordByStatus(false);
                    pageControl.setUrlPattern(requestURL + "?filter=violate" + "&");
                    break;
                default:
                    listCompanies = dao.findAllCompany(page);
                    totalRecord = dao.findAllTotalRecord();
                    pageControl.setUrlPattern(requestURL + "?");
            }
        }
        request.setAttribute("listCompanies", listCompanies);
        // Handle GET requests based on the action
        //total page
        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0 ? (totalRecord / RECORD_PER_PAGE) : (totalRecord / RECORD_PER_PAGE) + 1;
        //set total record, total page, page to pageControl
        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);
        //set attribute pageControl 
        request.setAttribute("pageControl", pageControl);
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
