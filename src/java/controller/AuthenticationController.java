package controller;

import utils.Email;
import constant.CommonConst;
import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.MessagingException;
import model.Account;

@WebServlet(name = "AuthenticationController", urlPatterns = {"/authen"})
public class AuthenticationController extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url;

        // Handle GET requests based on the action
        switch (action) {
            case "login":
                url = "view/authen/login.jsp";
                break;
            case "log-out":
                url = logOut(request, response);
                break;       
            case "change-password":
                url = "view/authen/changePassword.jsp";
                break;
            case "sign-up":
                url = "view/authen/register.jsp";
                break;
            case "view-profile":
                url = "view/user/userProfile.jsp";
                break;
            case "edit-profile":
                url = "view/user/editUserProfile.jsp";
                break;    
            default:
                url = "view/authen/login.jsp";
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get action parameter
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url = null;

        // Handle POST requests based on the action
        switch (action) {
            case "login":
                url = loginDoPost(request, response);
                break;
            case "sign-up":
                try {
                url = signUp(request, response);
            } catch (MessagingException ex) {
                Logger.getLogger(AuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
            }
            break;
            case "verify-otp":  // Handle OTP verification
                url = verifyOtp(request, response);
                break;
            case "forgot-password":
            try {
                url = sendResetOtp(request, response); // Handle OTP for password reset
            } catch (MessagingException ex) {
                Logger.getLogger(AuthenticationController.class.getName()).log(Level.SEVERE, null, ex);
            }
            break;
            case "verify-reset-otp": // Handle OTP verification for password reset
                url = verifyResetOtp(request, response);
                break;  
            case "reset-password":
                url = resetPassword(request, response);
                break;
            case "log-out":
                url = logOut(request, response);
            case "change-password":
                url = changePassword(request, response);

                break;
            default:
                url = "home";
        }
        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    }

    private String loginDoPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = null;

        // Get login credentials from request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");


        // Create cookies for username, password, and remember me
        Cookie cUser = new Cookie("cu", username);
        Cookie cPass = new Cookie("cp", password);
        Cookie cRem = new Cookie("cr", remember);

        // Set cookie max age (persistent for 1 day if "remember me" is checked)
        if (remember != null) {
            cUser.setMaxAge(60);
            cPass.setMaxAge(60);
            cRem.setMaxAge(60);
        } else {
            cUser.setMaxAge(0);
            cPass.setMaxAge(0);
            cRem.setMaxAge(0);
        }

        // Add cookies to the response
        response.addCookie(cUser);
        response.addCookie(cPass);
        response.addCookie(cRem);

        // Check credentials in the database
        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        Account accFound = accountDAO.findUserByUsernameAndPassword(account);

        HttpSession session = request.getSession();

        if (accFound != null) {
            if (accFound.getRoleId() == 1) {
                session.setAttribute("account",
                        accFound);
                url = "view/admin/adminHome.jsp";
            } else if (accFound.getRoleId() == 2) {
                session.setAttribute("account",
                        accFound);
                url = "view/recruiter/recruiterHome.jsp";
            } else if (accFound.getRoleId() == 3) {
                session.setAttribute("account",
                        accFound);
                url = "view/user/userHome.jsp";

            }
        } else {
            // Invalid credentials: display error message and go back to login
            request.setAttribute("mess", "Username or password incorrect!!");
            //request.getRequestDispatcher("view/authen/login.jsp").forward(request, response);
            url = "view/authen/login.jsp";
        }
        return url;
    }

    private String logOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute("account");
        //session.invalidate();
        //response.sendRedirect("${pageContext.request.contextPath}/view/home.jsp");
        return "view/home.jsp";
    }

    private String signUp(HttpServletRequest request, HttpServletResponse response) throws MessagingException, ServletException, IOException {
        String url;

        // Get sign-up information
        int roleId = Integer.parseInt(request.getParameter("role"));
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Create account object
        Account account = new Account();
        account.setRoleId(roleId);
        account.setLastName(lastname);
        account.setFirstName(firstname);
        account.setUsername(username);
        account.setEmail(email);
        account.setPassword(password);

        // Check if username or email already exists
        boolean isExistUsername = accountDAO.checkUsernameExist(account);
        boolean isExistUserEmail = accountDAO.checkUserEmailExist(account);

        // Handle validation errors
        if (isExistUsername) {
            request.setAttribute("error", "Username exists!!");
            url = "view/authen/register.jsp";
        } else if (isExistUserEmail) {
            request.setAttribute("error", "Email exists!!");
            url = "view/authen/register.jsp";
        } else {
            // Generate OTP and send email
            int sixDigitNumber = 100000 + new Random().nextInt(900000);
            Email.sendEmail(email, "OTP Register Account", "Hello, your OTP code is: " + sixDigitNumber);

            // Store OTP and account info in session
            HttpSession session = request.getSession();
            session.setAttribute("OTPCode", sixDigitNumber);
            session.setAttribute("userRegister", account);

            // Forward to OTP confirmation page
            return "view/authen/ConfirmOTP.jsp";  // Forward to OTP page after registration
        }
        return url;
    }


    private String changePassword(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute("account");
        //session.invalidate();
        //response.sendRedirect("${pageContext.request.contextPath}/view/home.jsp");
        return "view/home.jsp";
    }

    private String verifyOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the OTP entered by the user and the OTP stored in session
        int enteredOtp = Integer.parseInt(request.getParameter("otp"));
        int sessionOtp = (int) session.getAttribute("OTPCode");

        if (enteredOtp == sessionOtp) {
            // OTP is correct, complete the registration process
            Account account = (Account) session.getAttribute("userRegister");
            accountDAO.insert(account);  // Save the user account to the database

            // Clear the OTP from the session
            session.removeAttribute("OTPCode");
            session.removeAttribute("userRegister");

            // Redirect to the login page
            return "view/authen/login.jsp";
        } else {
            // OTP is incorrect, set an error message and stay on the OTP page
            request.setAttribute("error", "Invalid OTP. Please try again.");
            return "view/authen/ConfirmOTP.jsp";
        }
    }

    private String sendResetOtp(HttpServletRequest request, HttpServletResponse response) throws MessagingException, ServletException, IOException {
        String url;

        // Get user email from the request
        String email = request.getParameter("email");
        Account account = new Account();
        account.setEmail(email);

        // Check if the email exists in the database
        boolean isExistUserEmail = accountDAO.checkUserEmailExist(account); // Pass the email to check

        if (!isExistUserEmail) {
            // Email does not exist, set error message and stay on the forgot password page
            request.setAttribute("error", "Email does not exist. Please try again.");
            url = "view/authen/forgotPassword.jsp"; // Stay on forgot password page
        } else {
            // Generate a 6-digit OTP and send it to the user's email
            int sixDigitNumber = 100000 + new Random().nextInt(900000);
            Email.sendEmail(email, "OTP Reset Password", "Your OTP code is: " + sixDigitNumber);

            // Store OTP and account info in the session
            HttpSession session = request.getSession();
            session.setAttribute("ResetOTPCode", sixDigitNumber);
            session.setAttribute("userResetEmail", email); // Store email for verification later

            // Forward to OTP confirmation page for password reset
            url = "view/authen/ForgotPasswordOTP.jsp"; // OTP page
        }

        return url;
    }

    private String verifyResetOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the OTP entered by the user and the OTP stored in session
        int enteredOtp = Integer.parseInt(request.getParameter("otp"));
        int sessionOtp = (int) session.getAttribute("ResetOTPCode");

        if (enteredOtp == sessionOtp) {
            // OTP is correct, forward to the reset password page
            return "view/authen/ResetPassword.jsp"; // Let the user reset their password
        } else {
            // OTP is incorrect, set an error message and stay on the OTP page
            request.setAttribute("error", "Invalid OTP. Please try again.");
            return "view/authen/ForgotPasswordOTP.jsp";
        }
    }

    private String resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy email từ session (đã lưu trong quá trình gửi OTP)
        String email = (String) session.getAttribute("userResetEmail");

        // Lấy mật khẩu và mật khẩu xác nhận từ request
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra xem mật khẩu mới và mật khẩu xác nhận có khớp nhau không
        if (newPassword.equals(confirmPassword)) {
            // Get user email from the request
            Account account = new Account();
            account.setEmail(email);

            // Check if the email exists in the database
            boolean isExistUserEmail = accountDAO.checkUserEmailExist(account); // Pass the email to check

            if (isExistUserEmail) {
                // Mã hóa mật khẩu mới nếu cần (tuỳ thuộc vào cơ chế mã hóa của bạn)
                account.setPassword(newPassword);

                // Cập nhật mật khẩu vào cơ sở dữ liệu
                accountDAO.updatePasswordbyEmail(account);

                // Xóa thông tin liên quan đến reset password trong session
                session.removeAttribute("userResetEmail");
                session.removeAttribute("ResetOTPCode");

                // Chuyển hướng đến trang đăng nhập với thông báo thành công
                request.setAttribute("message", "Password successfully updated! Please login with your new password.");
                return "view/authen/login.jsp";
            } else {
                // Không tìm thấy tài khoản, báo lỗi
                request.setAttribute("error", "User not found. Please try again.");
                return "view/authen/ResetPassword.jsp";
            }
        } else {
            // Mật khẩu và xác nhận mật khẩu không khớp
            request.setAttribute("error", "Passwords do not match. Please try again.");
            return "view/authen/ResetPassword.jsp";
        }
    }

}
