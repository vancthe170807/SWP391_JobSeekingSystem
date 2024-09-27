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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import model.Account;
import utils.Validation;

@MultipartConfig
@WebServlet(name = "AuthenticationController", urlPatterns = {"/authen"})
public class AuthenticationController extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();
    Validation va  = new Validation();

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
            case "deactivate-account":  // Thêm hành động để xóa tài khoản
                url = deactivateAccount(request, response);
                break;
            case "log-out":
                url = logOut(request, response);
            case "change-password":
                url = changePassword(request, response);

                break;
            case "edit-profile":
                url = editProfile(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");

        // Create cookies for username, password, and remember me
        Cookie cEmail = new Cookie("ce", email);
        Cookie cPass = new Cookie("cp", password);
        Cookie cRem = new Cookie("cr", remember);

        // Set cookie max age (persistent for 1 day if "remember me" is checked)
        if (remember != null) {
            cEmail.setMaxAge(60 * 60 * 24);
            cPass.setMaxAge(60 * 60 * 24);
            cRem.setMaxAge(60 * 60 * 24);
        } else {
            cEmail.setMaxAge(0);
            cPass.setMaxAge(0);
            cRem.setMaxAge(0);
        }

        // Add cookies to the response
        response.addCookie(cEmail);
        response.addCookie(cPass);
        response.addCookie(cRem);

        // Check credentials in the database
        Account account = new Account();
        account.setEmail(email);
        account.setPassword(password);
        Account accFound = accountDAO.findUserByEmailAndPassword(account);
        //boolean activeAccount = account.isIsActive();

        HttpSession session = request.getSession();

        if (accFound == null) {
            // If no account is found, show the incorrect username/password message
            request.setAttribute("messLogin", "Email or Password Incorrect!");
            url = "view/authen/login.jsp";
        } else if (!accFound.isIsActive()) {
            // If the account is found but inactive
            request.setAttribute("messLogin", "Your account is deactivated. Please contact Admin by email to resolve this.");
            url = "view/authen/login.jsp";
        } else {
            // If the account is found and active
            session.setAttribute(CommonConst.SESSION_ACCOUNT, accFound);
            switch (accFound.getRoleId()) {
                case 1:
                    url = "view/admin/adminHome.jsp";
                    break;
                case 2:
                    url = "view/recruiter/recruiterHome.jsp";
                    break;
                case 3:
                    url = "view/user/userHome.jsp";
                    break;
            }
        }
        return url;
    }

    private String logOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute("account");
        return "view/authen/login.jsp";
    }

    private String signUp(HttpServletRequest request, HttpServletResponse response) throws MessagingException, ServletException, IOException {
        String url;

        // Get sign-up information
        int roleId = Integer.parseInt(request.getParameter("role"));
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String gender = request.getParameter("gender");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Create account object
        Account account = new Account();
        account.setRoleId(roleId);
        account.setLastName(lastname);
        account.setFirstName(firstname);
        switch (gender) {
            case "male":
                account.setGender(true);
                break;
            case "female":
                account.setGender(false);
                break;
            default:
                account.setGender(true);
        }
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

    private String changePassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String currPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String retypePass = request.getParameter("retypePassword");

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        String url = null;

        // Trạng thái của việc thay đổi mật khẩu
        int status = 0;

        // Kiểm tra trường hợp mật khẩu cũ, mật khẩu mới và xác nhận mật khẩu mới
        if (!currPass.equals(acc.getPassword()) && !newPass.equals(retypePass)) {
            // Cả mật khẩu cũ sai và mật khẩu mới không khớp
            status = 3;
        } else if (!currPass.equals(acc.getPassword())) {
            // Mật khẩu cũ sai
            status = 1;
        } else if (!newPass.equals(retypePass)) {
            // Mật khẩu mới và xác nhận mật khẩu không khớp
            status = 2;
        } else if (!va.checkPassword(newPass)) {
            // Mật khẩu mới không đạt yêu cầu (không thỏa mãn yêu cầu về độ mạnh)
            status = 4;
        } else {
            status = 5;
        }

        // Xử lý từng trạng thái theo logic yêu cầu
        switch (status) {
            case 1:
                // Mật khẩu cũ sai
                request.setAttribute("changePWfail", "Incorrect current password.");
                url = "view/authen/changePassword.jsp";
                break;
            case 2:
                // Mật khẩu mới và xác nhận mật khẩu không khớp
                request.setAttribute("changePWfail", "New password and retype password do not match.");
                url = "view/authen/changePassword.jsp";
                break;
            case 3:
                // Cả mật khẩu cũ sai và mật khẩu mới không khớp
                request.setAttribute("changePWfail", "Both current password is incorrect and new password does not match.");
                url = "view/authen/changePassword.jsp";
                break;
            case 4:
                // Mật khẩu mới không thỏa mãn yêu cầu của checkPassword()
                request.setAttribute("changePWfail", "The new password must be 8-20 characters long, and include at "
                        + "least one letter and one special character.");
                url = "view/authen/changePassword.jsp";
                break;
            case 5:
                // Nếu không có lỗi, thực hiện cập nhật mật khẩu
                acc.setPassword(newPass);
                accountDAO.updatePasswordByUsername(acc);
                request.setAttribute("changePWsuccess", "Password Changed Successfully. Please Login Again.");
                url = "view/authen/login.jsp";
                break;
        }
        return url;
    }

    private String verifyOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve the OTP entered by the user and the OTP stored in session
        try {
            int enteredOtp = Integer.parseInt(request.getParameter("otp"));
            int sessionOtp = (int) session.getAttribute("OTPCode");
//            parse sang string và so sanh hai chuỗi
            String inputOtp = Integer.toString(enteredOtp).trim();
            String storedOtp = Integer.toString(sessionOtp).trim();
            if (inputOtp.equals(storedOtp)) {
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
        } catch (Exception e) {
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
        try {
            int enteredOtp = Integer.parseInt(request.getParameter("otp"));
            int sessionOtp = (int) session.getAttribute("ResetOTPCode");
//            parse sang string và so sanh hai chuỗi
            String inputOtp = Integer.toString(enteredOtp).trim();
            String storedOtp = Integer.toString(sessionOtp).trim();
            if (inputOtp.equals(storedOtp)) {
                // OTP is correct, forward to the reset password page
                return "view/authen/ResetPassword.jsp";
            } else {
                // OTP is incorrect, set an error message and stay on the OTP page
                request.setAttribute("error", "Invalid OTP. Please try again.");
                return "view/authen/ForgotPasswordOTP.jsp";
            }
        } catch (Exception e) {
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

    private String editProfile(HttpServletRequest request, HttpServletResponse response) {
        String url = "";
//        get ve cac parameter
        try {
            String lastName = request.getParameter("lastName");
            String firstName = request.getParameter("firstName");
            String phone = request.getParameter("phone");
            Date dob = Date.valueOf(request.getParameter("date"));
            String gender = request.getParameter("gender");
            String citizenId = request.getParameter("citizenid");
            String address = request.getParameter("address");
//        get về image
            Part part = request.getPart("image");
            String imagePath = null;
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty() || part == null) {
                imagePath = null;
            } else {
//        duong dan lưu ảnh
                String path = request.getServletContext().getRealPath("images");
                File dir = new File(path);
//        xem duong dan nay ton tai chua
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File image = new File(dir, part.getSubmittedFileName());
//        ghi file vao trong duong dan
                part.write(image.getAbsolutePath());
//        lay ra contextPath cua project
                imagePath = request.getContextPath() + "/" + "/images/" + image.getName();
            }

//        tạo đối tượng session và set các thuộc tính
            HttpSession session = request.getSession();

            Account accountEdit = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
            accountEdit.setLastName(lastName);
            accountEdit.setFirstName(firstName);
            accountEdit.setPhone(phone);
            accountEdit.setDob(dob);
            accountEdit.setGender(gender.equalsIgnoreCase("male") ? true : false);
            accountEdit.setCitizenId(citizenId);
            accountEdit.setAddress(address);
            accountEdit.setAvatar(imagePath);
            accountDAO.updateAccount(accountEdit);
            url = "view/user/userProfile.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            url = "view/user/editUserProfile.jsp";
        }
        return url;
    }

    // Vo hieu hoa tai khoan
    private String deactivateAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tài khoản từ session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        if (account != null) {
            // Lấy mật khẩu mà người dùng đã nhập từ request
            String currentPassword = request.getParameter("currentPassword");

            // Kiểm tra xem mật khẩu nhập vào có trùng với mật khẩu của tài khoản hiện tại không
            if (account.getPassword().equals(currentPassword)) {  // So sánh mật khẩu đã lưu với mật khẩu nhập vào
                // Nếu mật khẩu đúng, xóa tài khoản khỏi cơ sở dữ liệu
                accountDAO.deactiveAccount(account);

                // Chuyển hướng đến trang đăng nhập sau khi vô hiệu hoá thành công
                request.setAttribute("message", "Your account has deactive successfully.");
                return "view/authen/login.jsp";
            } else {
                // Nếu mật khẩu không đúng, yêu cầu người dùng nhập lại
                request.setAttribute("error", "Incorrect password. Please try again.");
                return "view/authen/deactivteAccount.jsp"; // Trở lại trang yêu cầu nhập lại mật khẩu
            }
        } else {
            // Nếu không có tài khoản trong session, quay lại trang chủ
            return "home";
        }
    }

}
