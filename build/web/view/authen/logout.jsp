<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Logout</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <jsp:include page="../common/authen/common-css-authen.jsp"></jsp:include>
</head>
<body class="bg-dark d-flex justify-content-center align-items-center vh-100">
    <div class="card text-center" style="width: 90%; max-width: 500px;">
        <div class="card-body">
            <img class="logo__image mb-3" src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
            <h2 class="card-title">Logout from status?</h2>
            <div class="mt-4">
                <button class="btn btn-secondary mr-3" onclick="cancelLogout()">Cancel</button>
                <button class="btn btn-primary" id="confirmLogout">Continue</button>
            </div>
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
