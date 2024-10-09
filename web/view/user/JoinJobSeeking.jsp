<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Join Job Seeking</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="bg-dark d-flex justify-content-center align-items-center vh-100">
    <div class="card text-center" style="width: 90%; max-width: 500px;">
        <div class="card-body">
            <img class="logo__image mb-3" src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
            
            <!-- Display success or error message if exists -->
            <c:if test="${!empty requestScope.joinsuccess}">
                <div class="alert alert-success">
                    ${requestScope.joinsuccess}
                </div>
                    <a href="${pageContext.request.contextPath}/view/user/userHome.jsp" class="btn btn-success">Go to Home</a>
            </c:if>
            <c:if test="${!empty requestScope.joinerror}">
                <div class="alert alert-danger">
                    ${requestScope.joinerror}
                </div>
            </c:if>

            <!-- Confirmation question -->
            <h2 class="card-title">Are you sure you want to join job seeking?</h2>

            <div class="mt-4">
                <!-- Cancel button -->
                <button class="btn btn-secondary mr-3" onclick="cancelJoin()">Cancel</button>

                <!-- Confirm form -->
                <form id="confirmForm" action="${pageContext.request.contextPath}/seeker?action=join-job-seeking" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="join-job-seeking">
                    <input type="hidden" name="accountid" value="${sessionScope.account.id}">
                    <button type="submit" class="btn btn-primary">Confirm</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS, jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // If user clicks "Cancel", go back to the previous page
        function cancelJoin() {
            window.history.back();
        }
    </script>
</body>
</html>
