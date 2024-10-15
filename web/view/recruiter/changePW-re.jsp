<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recruiter Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Container for the password change form */
            .password-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - 80px); /* Adjust for full height excluding header */
                padding: 20px;
                margin-left: 260px; /* Ensure it does not overlap the sidebar */
                padding-top: 80px; /* Ensure it does not overlap the header */
                background-color: #f8f9fa; /* Light background to differentiate the form */
            }

            /* Card styling for the password form */
            .password-card {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
                max-width: 400px; /* Reduced width for smaller input fields */
                width: 100%;
            }

            /* Centering the title */
            .password-card h2 {
                text-align: center;
                margin-bottom: 30px;
                color: red;
            }

            /* Styling for form labels */
            .password-card label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            /* General form input styling */
            .password-card .form-control {
                border: 1px solid #ced4da;
                border-radius: 5px;
                padding: 8px;
                font-size: 14px;
                width: 100%; /* Ensure the input fills the width */
            }

            /* Button styling */
            .password-card .btn {
                padding: 8px;
                font-size: 14px;
                border-radius: 5px;
            }

            /* Primary button style */
            .password-card .btn-success {
                background-color: #28a745;
                border: none;
            }

            .password-card .btn-success:hover {
                background-color: #218838;
            }

            /* Secondary button style */
            .password-card .btn-secondary {
                background-color: #6c757d;
                border: none;
            }

            .password-card .btn-secondary:hover {
                background-color: #5a6268;
            }

            /* Password visibility toggle */
            .toggle-password {
                position: absolute;
                top: 35px;
                right: 15px;
                cursor: pointer;
                color: #007bff;
                font-size: 14px;
            }

            .toggle-password:hover {
                color: #0056b3;
            }

            /* Error message styling */
            .error-message {
                color: red;
                margin-top: 10px;
                font-size: 14px;
            }

            /* Password note styling */
            .password-note {
                font-size: 12px;
                color: gray;
                margin-top: 5px;
                display: none; /* Hidden by default */
            }

            /* Form group spacing */
            .form-group {
                margin-bottom: 15px;
                position: relative;
            }

            /* Align buttons on the same row */
            .btn-group {
                display: flex;
                justify-content: space-between;
            }
            
            .error-message {
                color: #f08080;
                background-color: #ffecec;
                border: 1px solid #f5c6cb;
                padding: 20px;
                border-radius: 5px;
                font-size: 13px;
                margin-bottom: 20px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Password Change Form -->
        <div class="password-container">
            <div class="password-card">
                <h2>Change Password</h2>
                <form action="${pageContext.request.contextPath}/authen?action=change-password-re" method="POST" onsubmit="return validateForm()">
                    <div class="form-group position-relative">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" class="form-control" required onkeydown="preventSpaces(event)">
                        <span class="toggle-password" onclick="togglePasswordVisibility('currentPassword', this)">Show</span>
                    </div>
                    <div class="form-group position-relative">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control" required onkeydown="preventSpaces(event)">
                        <span class="toggle-password" onclick="togglePasswordVisibility('newPassword', this)">Show</span>
                        <p id="passwordNote" class="password-note">Passwords must be 8 to 20 characters long and include numbers, letters and special characters.</p>
                    </div>
                    <div class="form-group position-relative">
                        <label for="retypePassword">Retype Password</label>
                        <input type="password" id="retypePassword" name="retypePassword" class="form-control" required onkeydown="preventSpaces(event)">
                        <span class="toggle-password" onclick="togglePasswordVisibility('retypePassword', this)">Show</span>
                    </div>
                    <c:if test="${not empty requestScope.changePWrefail}">
                        <div class="error-message">${requestScope.changePWrefail}</div>
                    </c:if>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-success">Update</button>
                        <button type="button" class="btn btn-secondary" onclick="cancelChangePassword()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript -->
        <script>
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

            function cancelChangePassword() {
               var role = ${sessionScope.account.getRoleId()};
                if (role === 1) {
                    window.location.href = "${pageContext.request.contextPath}/view/admin/adminHome.jsp";
                } else if (role === 2) {
                    window.location.href = "${pageContext.request.contextPath}/view/recruiter/dashboard.jsp";
                } else if (role === 3) {
                    window.location.href = "${pageContext.request.contextPath}/view/user/userHome.jsp";
                }
            }

            var newPasswordInput = document.getElementById('newPassword');
            var passwordNote = document.getElementById('passwordNote');

            newPasswordInput.addEventListener('focus', function () {
                passwordNote.style.display = 'block';
            });

            newPasswordInput.addEventListener('blur', function () {
                passwordNote.style.display = 'none';
            });

            function preventSpaces(event) {
                if (event.key === " ") {
                    event.preventDefault();
                    alert("Passwords cannot contain spaces.");
                }
            }

            function validateForm() {
                var currentPassword = document.getElementById("currentPassword").value;
                var newPassword = document.getElementById("newPassword").value;
                var retypePassword = document.getElementById("retypePassword").value;

                if (currentPassword.includes(" ") || newPassword.includes(" ") || retypePassword.includes(" ")) {
                    alert("Passwords cannot contain spaces.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
