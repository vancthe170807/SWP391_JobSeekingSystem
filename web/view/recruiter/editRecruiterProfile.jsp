<%-- 
    Document   : editRecruiterProfile
    Created on : Oct 4, 2024, 3:00:11 PM
    Author     : TuanTVHE173048
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .profile-container {
                display: flex;
                max-width: 1000px;
                margin: 50px auto;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .profile-sidebar {
                flex: 1;
                padding: 20px;
                text-align: center;
                border-right: 1px solid #ddd;
            }

            .profile-sidebar img {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 10px;
            }

            .profile-content {
                flex: 3;
                padding: 20px;
            }

            .profile-content h2 {
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>   
        <div class="row">
            <div class="col-md-3">
                <jsp:include page="../common/recruiter/sidebar-recruiter.jsp"></jsp:include>
                </div>

                <div class="col-md-9">
                    <div class="container mt-4">
                        <!-- Hiển thị thông báo thành công -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            ${successMessage}
                        </div>
                    </c:if>

                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${not empty errorsMessage}">
                        <div class="alert alert-danger" role="alert">
                            <ul>
                                <c:forEach var="error" items="${errorsMessage}">
                                    <li>${errorsMessage}</li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div>
                <div class="profile-container">
                    <!-- Sidebar with avatar and introduction -->
                    <div class="profile-sidebar">
                        <c:if test="${empty sessionScope.account.getAvatar()}">
                            <!-- Đường dẫn ảnh trống -->
                            <img id="avatar-preview" src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="User Avatar">
                        </c:if>
                        <c:if test="${!empty sessionScope.account.getAvatar()}">
                            <!-- Đường dẫn ảnh không trống -->
                            <img id="avatar-preview" src="${sessionScope.account.getAvatar()}" alt="User Avatar">
                        </c:if>
                        <h4>${sessionScope.account.getFullName()}</h4>
                        <p>Recruiter Information</p>
                        <button class="btn btn-secondary" onclick="history.back()">Back</button>
                    </div>
                    <!-- Profile content -->
                    <div class="profile-content">
                        <h2>Edit Profile</h2>
                        <form action="${pageContext.request.contextPath}/authen?action=edit-recruiter-profile" method="POST" enctype="multipart/form-data">
                            <!-- Avatar Upload -->
                            <div class="form-group">
                                <label for="avatar">Change Avatar</label>
                                <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" onchange="previewAvatar(event)">
                            </div>
                            <!-- Full Name -->
                            <div class="form-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.account.getLastName()}" required>
                            </div>
                            <div class="form-group">
                                <label for="firstName">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.account.getFirstName()}" required>
                            </div>
                            <!-- Email (Read-only) -->
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.account.getEmail()}" required>
                            </div>
                            <!-- Phone -->
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.account.getPhone()}" required>
                            </div>
                            <!-- Gender -->
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select class="form-control" id="gender" name="gender">
                                    <option value="male" ${sessionScope.account.isGender() == 'male' ? 'selected' : ''}>Male</option>
                                    <option value="female" ${sessionScope.account.isGender() == 'female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <!-- Address -->
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${sessionScope.account.getAddress()}" required>
                            </div>
                            <!-- Date of Birth -->
                            <div class="form-group">
                                <label for="dob">Date of birth</label>
                                <input type="date" class="form-control" id="dob" name="date" value="${sessionScope.account.getDob()}" required>
                            </div>
                            <!-- Save Button -->
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-success">Update Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div> 
        </div>


        <!-- JavaScript to preview the uploaded avatar image -->
        <script>
            function previewAvatar(event) {
                var reader = new FileReader();
                reader.onload = function () {
                    var output = document.getElementById('avatar-preview');
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </body>
</html>