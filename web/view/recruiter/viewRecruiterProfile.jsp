<%-- 
    Document   : viewRecruiterProfile
    Created on : Oct 4, 2024, 5:10:00 PM
    Author     : TuanTVHE173048
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .profile-container {
                display: flex;
                max-width: 1000px;
                margin: 50px auto;
                padding: 20px;
                justify-content: center; /* Căn giữa toàn bộ nội dung */
            }

            .profile-sidebar {
                flex: 1;
                padding: 20px;
                text-align: center;
                border-right: 1px solid #ddd;
            }

            .profile-sidebar img {
                width: 220px; /* Tăng kích thước avatar */
                height: 220px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 10px;
            }

            .profile-sidebar button {
                margin-top: 10px;
            }

            .profile-content {
                flex: 3;
                padding: 20px;
            }

            .profile-content h2 {
                margin-bottom: 10px;
                text-align: center;
                font-size: 24px; /* Tăng kích thước tiêu đề */
            }

            .profile-info {
                margin-top: 20px;
            }

            .profile-info table {
                width: 100%;
                font-size: 18px; /* Tăng kích thước văn bản */
                border-collapse: collapse; /* Bỏ viền bảng */
            }

            .profile-info table td {
                padding: 15px; /* Tăng khoảng cách giữa các trường */
                vertical-align: top;
                border: none; /* Bỏ khung viền */
            }

            .profile-info td:first-child {
                font-weight: bold;
                width: 30%; /* Tăng độ rộng của nhãn */
            }

            .nav-tabs {
                margin-bottom: 20px;
                justify-content: center; /* Căn giữa các tab */
            }

            .nav-tabs .nav-item .nav-link {
                font-size: 18px; /* Tăng kích thước chữ của tab */
            }

            .nav-tabs .nav-link.active {
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <div class="profile-container">
            <!-- Sidebar with avatar and introduction -->
            <div class="profile-sidebar">
                <c:if test="${empty sessionScope.account.getAvatar()}">
                    <!-- Đường dẫn ảnh trống -->
                    <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="">
                </c:if>

                <c:if test="${!empty sessionScope.account.getAvatar()}">
                    <!-- Đường dẫn ảnh không trống -->
                    <img src="${sessionScope.account.getAvatar()}" alt="">
                </c:if>

                <h4>${sessionScope.account.getFullName()}</h4>
                <p>Recruiter information</p>
                <button class="btn btn-secondary" onclick="history.back()">Back</button>
            </div>

            <!-- Profile content -->
            <div class="profile-content">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/view/recruiter/editRecruiterProfile.jsp" id="editProfileBtn">Edit Profile</a>
                    </li>
                </ul>

                <div class="profile-info">
                    <table>
                        <tr>
                            <td>Fullname:</td>
                            <td>${sessionScope.account.getFullName()}</td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>${sessionScope.account.getEmail()}</td>
                        </tr>
                        <tr>
                            <td>Phone:</td>
                            <td>${sessionScope.account.getPhone()}</td>
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td>${sessionScope.account.isGender() == true ? 'Male' : 'Female'}</td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td>${sessionScope.account.getAddress()}</td>
                        </tr>
                        <tr>
                            <td>Date of birth:</td>
                            <td>${sessionScope.account.getDob()}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </body>

</html>
