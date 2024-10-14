<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                background-color: #f8f9fa;
                display: flex;
                flex-direction: column;
            }

            .profile-container {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
                padding: 30px;
            }

            .profile-card {
                background-color: white;
                padding: 80px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 750px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }

            .profile-sidebar {
                text-align: center;
                margin-right: 40px;
            }

            .profile-sidebar img {
                width: 160px;
                height: 160px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px;
            }

            .profile-sidebar h4 {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .form-section {
                flex: 1;
                max-width: 600px;
            }

            .form-section h2 {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .form-control {
                padding: 10px;
                height: 45px;
            }

            .btn-success {
                padding: 12px 20px;
                font-size: 18px;
                width: 100%;
            }

            .alert {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Profile Container -->
        <div class="profile-container">
            <div class="profile-card">
                <!-- Sidebar with avatar and introduction -->
                <div class="profile-sidebar">
                    <c:if test="${empty sessionScope.account.getAvatar()}">
                        <img id="avatar-preview" src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="User Avatar">
                    </c:if>
                    <c:if test="${!empty sessionScope.account.getAvatar()}">
                        <img id="avatar-preview" src="${sessionScope.account.getAvatar()}" alt="User Avatar">
                    </c:if>
                    <h4>${sessionScope.account.getFullName()}</h4>
                    <p>Recruiter Information</p>
                </div>

                <!-- Profile content (Form) -->
                <div class="form-section">
                    <h2>Edit Profile</h2>
                    <form action="${pageContext.request.contextPath}/authen?action=edit-recruiter-profile" method="POST" enctype="multipart/form-data">
                        <!-- Avatar Upload -->
                        <div class="form-group">
                            <label for="avatar">Change Avatar</label>
                            <input type="file" class="form-control" id="avatar" name="avatar" accept="image/*" onchange="previewAvatar(event)">
                        </div>

                        <!-- Full Name (Two fields on one row) -->
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${sessionScope.account.getLastName()}" required>
                            </div>
                            <div class="col-md-6 form-group">
                                <label for="firstName">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${sessionScope.account.getFirstName()}" required>
                            </div>
                        </div>

                        <!-- Email (Read-only) -->
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${sessionScope.account.getEmail()}" readonly>
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
                        <div class="form-group">
                            <button type="submit" class="btn btn-success">Update Profile</button>
                        </div>
                    </form>

                    <!-- Display success or error messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorsMessage}">
                        <div class="alert alert-danger" role="alert">
                            <ul>
                                <c:forEach var="error" items="${errorsMessage}">
                                    <li>${error}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
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

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>
