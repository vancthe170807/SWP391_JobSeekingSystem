<%-- 
    Document   : Login
    Created on : Sep 15, 2024, 9:29:22 PM
    Author     : TuanTVHE173048
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <!-- Bootstrap for responsiveness -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body, html {
                height: 100%;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f4f6f9;
            }

            .login-container {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 500px;
                text-align: center;
                position: relative;
            }

            /* Close Icon */
            .close-icon {
                position: absolute;
                top: 20px;
                right: 20px;
                font-size: 24px;
                cursor: pointer;
                color: #dc3545;
            }

            .close-icon:hover {
                color: #c82333;
            }

            h4 {
                margin-bottom: 30px;
                font-size: 32px;
                font-weight: bold;
                color: #000;
            }

            h4 span {
                color: #28a745;
            }

            .form-group input {
                border-radius: 6px;
                height: 45px;
                font-size: 16px;
                padding-right: 40px;
            }

            input::placeholder {
                font-size: 14px;
            }

            label {
                font-weight: bold;
                font-size: 16px;
                color: #000;
                text-align: left;
                display: block;
            }

            .btn-primary {
                background-color: #28a745;
                border: none;
                height: 50px;
                font-size: 20px;
                width: 100%;
                border-radius: 6px;
                font-weight: bold;
            }

            .btn-primary:hover {
                background-color: #218838;
            }

            a {
                font-size: 14px;
                color: #007bff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }

            .password__icon {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 14px;
                color: #007bff;
            }

            .form-check-label {
                font-size: 14px;
                color: #6c757d;
                margin-left: 5px;
            }

            .form-check {
                display: flex;
                align-items: center;
            }

            .footer {
                font-size: 14px;
                color: #6c757d;
                margin-top: 30px;
            }

            .footer a {
                color: #007bff;
            }

            .form-group.position-relative {
                position: relative;
            }

            .error-message {
                color: #f08080;
                background-color: #ffecec;
                border: 1px solid #f5c6cb;
                padding: 15px;
                border-radius: 5px;
                font-size: 13px;
                margin-bottom: 20px;
                font-weight: bold;
            }

            .error-changePW {
                color: #218838;
                background-color: #FFFFFF;
                border: 1px solid #f5c6cb;
                padding: 15px;
                border-radius: 5px;
                font-size: 15px;
                margin-bottom: 20px;
                font-weight: bold;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .d-flex.justify-content-between {
                margin-bottom: 20px;
            }

            .scale-recaptcha {
                transform: scale(0.75); /* 0.75 là mức thu nhỏ 75% kích thước ban đầu */
                transform-origin: 0 0; /* Đặt góc trên bên trái làm điểm gốc để không bị lệch */
            }

            /* Tùy chọn: Bạn cũng có thể điều chỉnh kích thước bao quanh để không chiếm quá nhiều không gian */
            .g-recaptcha {
                width: 100% !important;
                height: auto !important;
            }

        </style>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
        <!-- Login Container -->
        <div class="login-container">
            <!-- X Icon to go back to Home -->
            <i class="fas fa-times close-icon" onclick="window.location.href = '${pageContext.request.contextPath}/home'"></i>
            <!-- Login Heading -->
            <h4>Login to Job<span>Path</span></h4>

            <!-- Display error message if login fails -->
            <c:if test="${requestScope.messLogin != null}">
                <div class="error-message">
                    ${requestScope.messLogin}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.changePWsuccess}">
                <div class="error-changePW">${requestScope.changePWsuccess}</div>
            </c:if>
            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/authen?action=login" method="post" id="login-form" onsubmit="return validateForm()">
                <!-- Username Input -->
                <div class="form-group position-relative text-left">
                    <label for="username" class="fw-medium text-dark mb-2">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" value="${cookie.cu.value}" required>
                </div>

                <!-- Password Input -->
                <div class="form-group position-relative text-left">
                    <label for="password" class="fw-medium text-dark mb-2">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" value="${cookie.cp.value}" required>
                    <span class="password__icon" onclick="togglePassword('password')">Show</span>
                </div>

                <!-- Forgot Password and Remember Me -->
                <div class="d-flex justify-content-between align-items-center">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" ${(cookie.cr != null ? 'checked':'')}>
                        <label class="form-check-label" for="rememberMe">Remember Me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/view/authen/forgotPassword.jsp">Forgot Password?</a>
                </div>
                <!-- Login Button -->
                <!--                <div class="form-group my-3">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>-->

                <!-- Google reCAPTCHA -->
                <div class="g-recaptcha scale-recaptcha" data-sitekey="6LeVFEsqAAAAAFK_7xKTrV798KMOrnTYcVgfeMIa"></div>
                <div id="error" style="color: red;"></div> <!-- Div để hiển thị lỗi reCAPTCHA -->


                <!-- Login Button -->
                <div class="form-group my-3">
                    <button type="button" onclick="checkCapCha()" class="btn btn-primary">Login</button>
                </div>
            </form>
            <!-- Register Link -->
            <p class="text-center">Don’t have an account? <a href="${pageContext.request.contextPath}/authen?action=sign-up">Register</a></p>
        </div>

        <!-- JS logic -->
        <script type="text/javascript">
            function togglePassword(id) {
                var input = document.getElementById(id);
                var icon = document.querySelector('.password__icon');
                if (input.type === "password") {
                    input.type = "text";
                    icon.textContent = 'Hide';
                } else {
                    input.type = "password";
                    icon.textContent = 'Show';
                }
            }

            // Prevent entering spaces in username and password fields
            function preventSpaces(event) {
                if (event.key === " ") {
                    event.preventDefault();
                    alert("Username and Password cannot contain spaces!");
                }
            }

            // Loại bỏ khoảng trắng khi nhập liệu vào trường username
            document.getElementById("username").addEventListener("input", function () {
                this.value = this.value.replace(/\s/g, "");  // Loại bỏ tất cả khoảng trắng
            });

// Loại bỏ khoảng trắng khi nhập liệu vào trường password
            document.getElementById("password").addEventListener("input", function () {
                this.value = this.value.replace(/\s/g, "");  // Loại bỏ tất cả khoảng trắng
            });

            function validateForm() {
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;

                // Loại bỏ khoảng trắng ở đầu và cuối (nếu có)
                username = username.trim();
                password = password.trim();

                // Kiểm tra nếu có khoảng trắng ở bất kỳ vị trí nào trong username hoặc password
                if (/\s/.test(username) || /\s/.test(password)) {
                    alert("Username and Password cannot contain spaces!");
                    return false;  // Ngăn việc submit form
                }

                return true;  // Cho phép submit nếu không có lỗi
            }

            document.getElementById("login-form").onsubmit = function () {
                return validateForm();
            };

            // Attach event listeners to prevent space input
            document.getElementById("username").addEventListener("keydown", preventSpaces);
            document.getElementById("password").addEventListener("keydown", preventSpaces);

            function checkCapCha() {
                var form = document.getElementById("login-form");
                var error = document.getElementById("error");
                const response = grecaptcha.getResponse();
                if (response) {
                    form.submit();
                } else {
                    error.textContent = "Please verify that you are not a robot";
                }
            }
        </script>
    </body>
</html>
