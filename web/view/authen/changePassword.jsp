<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow" style="width: 400px;">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">Change Password</h2>
                <form action="${pageContext.request.contextPath}/authen?action=change-password" method="POST" onsubmit="return validateForm()">
                    <div class="mb-3">
                        <label for="currentPassword" class="form-label">Current Password</label>
                        <div class="input-group">
                            <input type="password" id="currentPassword" name="currentPassword" class="form-control" required onkeydown="preventSpaces(event)">
                            <span class="input-group-text toggle-password" onclick="togglePasswordVisibility('currentPassword', this)">Show</span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">New Password</label>
                        <div class="input-group">
                            <input type="password" id="newPassword" name="newPassword" class="form-control" required onkeydown="preventSpaces(event)">
                            <span class="input-group-text toggle-password" onclick="togglePasswordVisibility('newPassword', this)">Show</span>
                        </div>
                        <p id="passwordNote" class="text-muted small">Passwords must be 8 to 20 characters long and include numbers, letters, and special characters.</p>
                    </div>
                    <div class="mb-3">
                        <label for="retypePassword" class="form-label">Retype Password</label>
                        <div class="input-group">
                            <input type="password" id="retypePassword" name="retypePassword" class="form-control" required onkeydown="preventSpaces(event)">
                            <span class="input-group-text toggle-password" onclick="togglePasswordVisibility('retypePassword', this)">Show</span>
                        </div>
                    </div>
                    <c:if test="${not empty requestScope.changePWfail}">
                        <div class="alert alert-danger" role="alert">${requestScope.changePWfail}</div>
                    </c:if>
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-success">Update</button>
                        <a class="btn btn-secondary" onclick="cancelChangePassword()">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to show or hide the password
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

        // Function to cancel password change and redirect to appropriate page
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

        // Event listeners to show/hide password note
        var newPasswordInput = document.getElementById('newPassword');
        var passwordNote = document.getElementById('passwordNote');

        newPasswordInput.addEventListener('focus', function() {
            passwordNote.style.display = 'block'; // Show note when focused
        });

        newPasswordInput.addEventListener('blur', function() {
            passwordNote.style.display = 'none'; // Hide note when not focused
        });

        // Prevent entering spaces in password fields
        function preventSpaces(event) {
            if (event.key === " ") {
                event.preventDefault();
                alert("Passwords cannot contain spaces.");
            }
        }

        // Validate form before submission to ensure no spaces in passwords
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
