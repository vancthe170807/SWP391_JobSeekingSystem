/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.CommonConst;
import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import model.Account;

@WebServlet(name = "AuthenticationController", urlPatterns = {"/authen"})
public class AuthenticationController extends HttpServlet {

    AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        //dua theo action set URL trang can chuyen den
        String url;
        switch (action) {
            case "login":
                url = "view/authen/login.jsp";
                break;
//            case "log-out":
//                url = logOut(request, response);
//                break;
            case "sign-up":
                url = "view/authen/register.jsp";
                break;
            default:
                url = "home";
        }

        //chuyen trang
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get ve action
        String action = request.getParameter("action") != null
                ? request.getParameter("action")
                : "";
        //dựa theo action để xử lí request
        String url;
        switch (action) {
            case "login":
                url = loginDoPost(request, response);
                break;
            case "sign-up":
                url = signUp(request, response);
                break;
            case "log-out":
                url = logOut(request, response);
            default:
                url = "home";
        }
        request.getRequestDispatcher(url).forward(request, response);

    }

    
    private String loginDoPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;
        //get về các thong tin người dung nhập
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        //kiểm tra thông tin có tồn tại trong DB ko
        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        Account accFoundByUsernamePass = accountDAO.findUserByUsernameAndPassword(account);

        HttpSession session = request.getSession();

        if (accFoundByUsernamePass != null) {
            if (accFoundByUsernamePass.getRoleId() == 1) {
                session.setAttribute(CommonConst.SESSION_ACCOUNT,
                        accFoundByUsernamePass);
                url = "view/admin/adminHome.jsp";
            } else if (accFoundByUsernamePass.getRoleId() == 2) {
                session.setAttribute(CommonConst.SESSION_ACCOUNT,
                        accFoundByUsernamePass);
                url = "view/recruiter/recruiterHome.jsp";
            } else if (accFoundByUsernamePass.getRoleId() == 3) {
                session.setAttribute(CommonConst.SESSION_ACCOUNT,
                        accFoundByUsernamePass);
                url = "view/user/userHome.jsp";
            }
        } else {
            request.setAttribute("mess", "Username or password incorrect!!");
            request.getRequestDispatcher("view/authen/login.jsp").forward(request, response);
            //url = "view/authen/login.jsp";
        }
        return url;
    }

    private String logOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute(CommonConst.SESSION_ACCOUNT);
        //session.invalidate();
        //response.sendRedirect("${pageContext.request.contextPath}/view/home.jsp");
        return "view/home.jsp";
    }

    private String signUp(HttpServletRequest request, HttpServletResponse response) {
        String url;
        //get ve cac thong tin nguoi dung nhpa
        int roleId = Integer.parseInt(request.getParameter("role"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        //kiem tra xem username da ton tai trong db
        Account account = new Account();
        account.setRoleId(roleId);
        account.setUsername(username);
        account.setEmail(email);
        account.setPassword(password);
        boolean isExistUsername = accountDAO.checkUsernameExist(account);
        boolean isExistUserEmail = accountDAO.checkUserEmailExist(account);
        //true => quay tro lai trang register (set thong bao loi )
        if (isExistUsername) {
            request.setAttribute("error", "Username exist !!");
            url = "view/authen/register.jsp";
            //false => quay tro lai trang home ( ghi tai khoan vao trong DB )
        } else if (isExistUserEmail) {
            request.setAttribute("error", "Email exist !!");
            url = "view/authen/register.jsp";
        } else {
            accountDAO.insert(account);
            url = "view/authen/login.jsp";
        }
        return url;
    }

}
