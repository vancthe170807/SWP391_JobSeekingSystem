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
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Company;
import model.PageControl;

@WebServlet(name = "CompanyAdminController", urlPatterns = {"/companies"})
public class CompanyAdminController extends HttpServlet {

    CompanyDAO dao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve error đã xử lí ở doPost
        String error = request.getParameter("error") != null ? request.getParameter("error") : "";
        request.setAttribute("error", error);
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
        //get ve url
        String requestURL = request.getRequestURL().toString();
        int totalRecord = 0;
        if (!searchQuery.isEmpty()) {
            switch (filter) {
                case "all":
                    // Tìm tất cả các công ty theo từ khóa
                    listCompanies = dao.searchCompaniesByName(searchQuery, page);
                    totalRecord = dao.findTotalRecordByName(searchQuery);
                    pageControl.setUrlPattern(requestURL + "?searchQuery=" + searchQuery + "&");
                    break;
                case "accept":
                    // Tìm các công ty đã được chấp nhận theo từ khóa
                    listCompanies = dao.searchCompaniesByNameAndStatus(searchQuery, true, page);
                    totalRecord = dao.findTotalRecordByNameAndStatus(searchQuery, true);
                    pageControl.setUrlPattern(requestURL + "?filter=accept&searchQuery=" + searchQuery + "&");
                    break;
                case "violate":
                    // Tìm các công ty vi phạm theo từ khóa
                    listCompanies = dao.searchCompaniesByNameAndStatus(searchQuery, false, page);
                    totalRecord = dao.findTotalRecordByNameAndStatus(searchQuery, false);
                    pageControl.setUrlPattern(requestURL + "?filter=violate&searchQuery=" + searchQuery + "&");
                    break;
                default:
                    // Mặc định sẽ tìm tất cả các công ty theo từ khóa
                    listCompanies = dao.searchCompaniesByName(searchQuery, page);
                    totalRecord = dao.findTotalRecordByName(searchQuery);
                    pageControl.setUrlPattern(requestURL + "?searchQuery=" + searchQuery + "&");
            }
        } else {
            //get ve request URL
            //total record

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
        response.setContentType("application/json");
        switch (action) {
            case "violate":
                url = violateCompany(request);
                break;
            case "accept":
                url = accepetCompany(request);
                break;
            case "add-company":
                url = addCompany(request, response);
                break;
            case "edit-company":
                url = editCompany(request, response);
                break;
            default:
                url = "companies";
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

    private String addCompany(HttpServletRequest request, HttpServletResponse response) {
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
        if (dao.checkExistNameCompany(name)) {
            try {
                return "companies?error=" + URLEncoder.encode("Exist company name!", "UTF-8");
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(CompanyAdminController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else{
        dao.insert(company);
        return "companies";
        }
        return "companies";
        
    }

    private String editCompany(HttpServletRequest request, HttpServletResponse response) {
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
        if (dao.checkExistOther(name, companyEdit.getId())) {
             try {
                return "companies?error=" + URLEncoder.encode("Exist company name!", "UTF-8");
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(CompanyAdminController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        dao.updateCompany(companyEdit);
        return "companies";
    }
}
