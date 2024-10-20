/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.recruiter;

import constant.CommonConst;
import dao.CompanyDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Company;
import model.JobPostings;
import model.Recruiters;

@WebServlet(name = "VerifyRecruiter", urlPatterns = {"/verifyRecruiter"})
public class VerifyRecruiter extends HttpServlet {

    RecruitersDAO reDAO = new RecruitersDAO();
    CompanyDAO companyDao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        //Recruiters recruiters = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        //List<Company> companies = companyDao.getCompanyNameByAccountId(account.getId());
        List<Company> companies = companyDao.findAll();
        request.setAttribute("companyList", companies);
        request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID công ty và vị trí từ form
        int companyId;
        try {
            companyId = Integer.parseInt(request.getParameter("companyId"));
        } catch (NumberFormatException e) {
            // Nếu companyId không hợp lệ, gửi thông báo lỗi
            request.setAttribute("error", "Invalid company ID format.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        }
        String position = request.getParameter("position");

        // Kiểm tra nếu companyId có tồn tại trong database
        if (!companyDao.isCompanyExist(companyId)) {
            // Nếu không tồn tại, gửi thông báo lỗi
            request.setAttribute("error", "Company ID does not exist.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        }

        // Lấy account từ session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        // Kiểm tra nếu recruiter đã xác nhận chưa
        Recruiters recruiter = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiter != null && recruiter.isIsVerify()) {
            // Nếu đã xác nhận, quay về dashboard
            response.sendRedirect("Dashboard");
        } else {
            // Nếu chưa, tạo request mới
            Recruiters re = new Recruiters();
            re.setAccountID(account.getId());
            re.setCompanyID(companyId);
            re.setPosition(position);
            re.setIsVerify(false); // Đặt trạng thái là chưa xác minh
            reDAO.insert(re);

            // Gửi thông báo xác nhận thành công
            request.setAttribute("verify", "Your verification request has been sent.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);

        }
    }

}
