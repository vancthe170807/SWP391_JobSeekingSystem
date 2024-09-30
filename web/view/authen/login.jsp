<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                padding: 60px;
                border-radius: 10px;
                box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                text-align: left;
                position: relative;
            }

            /* X Icon styling */
            .close-icon {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 24px;
                cursor: pointer;
                color: #dc3545; /* Màu đỏ cho biểu tượng X */
            }

            .close-icon:hover {
                color: #c82333; /* Màu đậm hơn khi hover */
            }

            h4 {
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: bold;
                text-align: center;
            }

            h4 span {
                color: #28a745;
            }

            .form-group input {
                border-radius: 5px;
                height: 50px;
                font-size: 16px;
            }

            input::placeholder {
                font-size: 14px;
            }

            label {
                font-weight: bold;
                font-size: 14px;
                color: #000;
            }

            .form-check-label {
                font-size: 14px;
                color: #6c757d;
            }

            .btn-primary {
                background-color: #28a745;
                border: none;
                height: 50px;
                font-size: 18px;
                width: 100%;
                border-radius: 5px;
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
                top: 55%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 14px;
                color: #007bff;
            }

            .g-recaptcha {
                transform: scale(0.85);
                transform-origin: 0 0;
                margin-bottom: 15px;
            }

            .footer {
                font-size: 12px;
                color: #6c757d;
                margin-top: 20px;
            }

            .footer a {
                color: #007bff;
            }

            .error-message {
                color: #f08080;
                background-color: #ffecec;
                border: 1px solid #f5c6cb;
                padding: 15px;
                border-radius: 5px;
                font-size: 16px;
                margin-bottom: 20px;
            }

            .success-message {
                color: #30ac20;
                background-color: #d3f9d8;
                border: 1px solid #b1e0ac;
                padding: 15px;
                border-radius: 5px;
                font-size: 16px;
                margin-bottom: 20px;
            }

            .back-btn {
                background-color: #6c757d;
                border: none;
                height: 50px;
                font-size: 18px;
                width: 100%;
                border-radius: 5px;
                font-weight: bold;
                margin-top: 15px;
            }

            .back-btn:hover {
                background-color: #5a6268;
            }
        </style>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
        <!-- Login Container -->
        <div class="login-container">
            <!-- X Icon to go back to Home -->
            <i class="fas fa-times close-icon" onclick="window.location.href = '${pageContext.request.contextPath}/view/home.jsp'"></i>

            <!-- Login Heading -->
            <h4>Login to Job<span>Path</span></h4>

            <!-- Display error message if login fails -->
            <c:if test="${requestScope.messLogin != null}">
                <div class="error-message">
                    ${requestScope.messLogin}
                </div>
            </c:if>

            <!-- Display success message if password change was successful -->
            <c:if test="${not empty requestScope.changePWsuccess}">
                <div class="success-message">${requestScope.changePWsuccess}</div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/authen?action=login" method="post" id="login-form">
                <!-- Username Input -->
                <div class="form-group position-relative">
                    <label for="username" class="fw-medium text-dark mb-2">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" value="${cookie.cu.value}" required>
                    
                </div>

                <!-- Password Input -->
                <div class="form-group position-relative">
                    <label for="password" class="fw-medium text-dark mb-2">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" value="${cookie.cp.value}" required>
                    <span class="password__icon" onclick="togglePassword('password')">Show</span>
                    
                </div>

                <!-- Forgot Password and Remember Me -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" ${(cookie.cr != null ? 'checked':'')}>
                        <label class="form-check-label" for="rememberMe">Remember Me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/view/authen/forgotPassword.jsp">Forgot Password?</a>
                </div>

                <!-- Google reCAPTCHA -->
                <div class="g-recaptcha" data-sitekey="6LeVFEsqAAAAAFK_7xKTrV798KMOrnTYcVgfeMIa"></div>
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
