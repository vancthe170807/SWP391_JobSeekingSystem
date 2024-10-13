/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import static constant.CommonConst.RECORD_PER_PAGE;
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
import model.PageControl;

@WebServlet(name = "SeekerAdminController", urlPatterns = {"/seekers"})
public class SeekerAdminController extends HttpServlet {

    AccountDAO dao = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve page
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
        ///get ve action 
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;
        //lay ve id de view profile
        // get ve danh sach list seeker
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";
        List<Account> listSeekers;
        //get ve request URL
        String requestURL = request.getRequestURL().toString();
        //total record
        int totalRecord = 0;
        switch (filter) {
            case "all":
                listSeekers = dao.findAllUserByRoleId(3, page);
                totalRecord = dao.findAllTotalRecord(3);
                pageControl.setUrlPattern(requestURL + "?");
                break;
            case "active":
                listSeekers = dao.filterUserByStatus(true, 3, page);
                totalRecord = dao.findTotalRecordByStatus(true, 3);
                pageControl.setUrlPattern(requestURL + "?filter=active" + "&");
                break;
            case "inactive":
                listSeekers = dao.filterUserByStatus(false, 3, page);
                totalRecord = dao.findTotalRecordByStatus(false, 3);
                pageControl.setUrlPattern(requestURL + "?filter=inactive" + "&");
                break;
            default:
                listSeekers = dao.findAllUserByRoleId(3, page);
                totalRecord = dao.findAllTotalRecord(3);
                pageControl.setUrlPattern(requestURL + "?");
        }
        request.setAttribute("listSeekers", listSeekers);
        //total page
        int totalPage = (totalRecord % RECORD_PER_PAGE) == 0 ? (totalRecord / RECORD_PER_PAGE) : (totalRecord / RECORD_PER_PAGE) + 1;
        //set total record, total page, page to pageControl
        pageControl.setPage(page);
        pageControl.setTotalRecord(totalRecord);
        pageControl.setTotalPages(totalPage);
        //set attribute pageControl 
        request.setAttribute("pageControl", pageControl);
        // Handle GET requests based on the action

        switch (action) {
            case "view-list-seekers":
                url = "view/admin/seekerManagement.jsp";
                break;
            default:
                url = "view/admin/seekerManagement.jsp";
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
            case "deactive":
                url = deactive(request);
                break;
            case "active":
                url = active(request);
                break;
            case "view-detail":
                url = viewDetail(request);
                request.getRequestDispatcher(url).forward(request, response);
                break;

            default:
                url = "view/admin/seekerManagement.jsp";
        }
        response.sendRedirect(url);
    }

    private String deactive(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id-seeker"));
        Account account = dao.findUserById(id);
        dao.deactiveAccount(account);
        return "seekers";
    }

    private String active(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id-seeker"));
        Account account = dao.findUserById(id);
        dao.activeAccount(account);
        return "seekers";
    }

    private String viewDetail(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id-seeker"));
        Account account = dao.findUserById(id);
        request.setAttribute("accountView", account);
        return "view/admin/viewDetailUser.jsp";
    }

}
