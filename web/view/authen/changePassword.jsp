<%-- 
    Document   : change password
    Created on : Sep 15, 2024, 9:29:22 PM
    Author     : TuanTVHE173048
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fc;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                padding: 20px;
            }

            .password-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
            }

            .password-box {
                background-color: white;
                padding: 60px; /* Tăng thêm padding để tăng chiều cao */
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 500px;
                text-align: center;
            }

            h2 {
                margin-bottom: 40px; /* Tăng khoảng cách dưới tiêu đề */
                font-size: 26px;
                color: #28a745;
            }

            .highlight {
                color: #28a745;
            }

            .welcome {
                margin-bottom: 40px; /* Tăng khoảng cách dưới phần welcome */
                font-size: 18px;
                text-align: left;
            }

            .welcome strong {
                font-weight: bold;
            }

            .logout-btn {
                float: right;
                padding: 8px 15px;
                background-color: #dc3545;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
            }

            .logout-btn:hover {
                background-color: #c82333;
            }

            .input-group {
                margin-bottom: 30px; /* Tăng khoảng cách giữa các nhóm input */
                text-align: left;
                position: relative;
            }

            label {
                display: block;
                font-size: 16px;
                margin-bottom: 10px;
            }

            input[type="password"], input[type="text"] {
                width: 100%;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
            }

            .toggle-password {
                position: absolute;
                right: 10px;
                top: 40px;
                cursor: pointer;
                color: #007bff;
                font-size: 14px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 30px; /* Tăng khoảng cách giữa các nút */
            }

            .btn {
                padding: 18px 40px;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                font-size: 18px;
            }

            .update-btn {
                background-color: #28a745;
                color: white;
            }

            .update-btn:hover {
                background-color: #218838;
            }

            .cancel-btn {
                background-color: #6c757d;
                color: white;
                text-decoration: none;
                line-height: 20px;
            }

            .cancel-btn:hover {
                background-color: #5a6268;
            }

            .error-message {
                color: #f08080;
                background-color: #ffecec;
                border: 1px solid #f5c6cb;
                padding: 20px; /* Tăng padding cho thông báo lỗi */
                border-radius: 5px;
                font-size: 16px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="password-container">
            <div class="password-box">
                <h2>Change Password</h2>

                <div class="welcome">
                    Welcome <strong>${sessionScope.account.getFullName()}</strong>
                </div>
                <form action="${pageContext.request.contextPath}/authen?action=change-password" method="POST">
                    <div class="input-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('currentPassword', this)">Show</span>
                    </div>
                    <div class="input-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('newPassword', this)">Show</span>
                    </div>
                    <div class="input-group">
                        <label for="retypePassword">Retype Password</label>
                        <input type="password" id="retypePassword" name="retypePassword" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('retypePassword', this)">Show</span>
                    </div>

                    <c:if test="${not empty requestScope.changePWfail}">
                        <div class="error-message">${requestScope.changePWfail}</div>
                    </c:if>
                    <div class="button-group">
                        <button type="submit" class="btn update-btn">Update</button>
                        <a class="btn cancel-btn" onclick="cancelChangePassword()">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- JavaScript function for Cancel and Toggle Password -->
        <script>
            function cancelChangePassword() {
                var role = ${sessionScope.account.getRoleId()};
                if (role === 1) {
                    window.location.href = "${pageContext.request.contextPath}/view/admin/adminHome.jsp";
                } else if (role === 2) {
                    window.location.href = "${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp";
                } else if (role === 3) {
                    window.location.href = "${pageContext.request.contextPath}/view/user/userHome.jsp";
                }
            }

            function togglePasswordVisibility(id, element) {
                var input = document.getElementById(id);
                if (input.type === "password") {
                    input.type = "text";
                    element.textContent = "Hide";
                } else {
                    input.type = "password";
                    element.textContent = "Show";
                }
            }
        </script>
    </body>
</html>
