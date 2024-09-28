<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Confirm Logout</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
        <!-- Custom CSS -->
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: rgba(0, 0, 0, 0.5); /* Màu nền mờ bao phủ toàn bộ trang */
            }
            .logout-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                height: 100%;
                position: fixed; /* Đảm bảo container phủ kín toàn màn hình */
                top: 0;
                left: 0;
            }
            .logout-card {
                background-color: #ffffff;
                border-radius: 10px;
                padding: 40px;
                width: 80%;
                max-width: 1000px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .logout-card h2 {
                font-size: 36px; /* Phóng to chữ Confirm Logout */
                margin-bottom: 20px;
                font-weight: bold;
            }
            .jobpath-logo {
                font-size: 50px;
                margin-bottom: 20px;
            }
            .jobpath-logo .job {
                color: black;
            }
            .jobpath-logo .path {
                color: #28a745; /* Màu xanh lá cây */
            }
            .btn-primary {
                background-color: #28a745;
                border: none;
                padding: 10px 30px;
            }
            .btn-primary:hover {
                background-color: #218838;
            }
            .btn-secondary {
                background-color: #6c757d;
                border: none;
                padding: 10px 30px;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
            }
            .footer {
                margin-top: 20px;
                font-size: 14px;
                color: #6c757d;
                text-align: center;
                padding-top: 10px;
                border-top: 1px solid #e9ecef;
            }
        </style>
    </head>
    <body>
        <!-- Main Container -->
        <div class="logout-container">
            <div class="logout-card">
                <!-- Logo JobPath -->
                <div class="jobpath-logo">
                    <img class="logo__image" src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
                </div>

                <h2>Confirm Logout</h2>
                <p>Are you sure you want to log out?</p>
                <div>
                    <button class="btn btn-secondary mr-3" onclick="cancelLogout()">Cancel</button>
                    <button class="btn btn-primary" id="confirmLogout">Continue</button>
                </div>

                <!-- Footer -->
                <p class="text-center fw-medium py-4">
                Copyright &copy; 2024 All Rights Reserved by Group 4 - SE1868-NJ
            </p>
            </div>
        </div>
        <!-- Bootstrap JS, jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            // Khi người dùng nhấn nút "Continue" để xác nhận logout
            document.getElementById("confirmLogout").addEventListener("click", function() {
                window.location.href = "${pageContext.request.contextPath}/authen?action=log-out";
            });

            // Nếu người dùng nhấn "Cancel", quay lại trang trước đó
            function cancelLogout() {
                window.history.back();
            }
        </script>                       
    </body>
</html>
