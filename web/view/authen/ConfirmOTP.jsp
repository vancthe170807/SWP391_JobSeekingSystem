<%-- 
    Document   : forgotPassword
    Created on : Sep 15, 2024, 9:50:14 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Forgot password - OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

<body>
    <!-- Header Area -->
    <jsp:include page="../common/header-area.jsp"></jsp:include>
    <!-- Header Area End -->

    <div class="container d-flex justify-content-center align-items-center" style="margin-bottom: 20px; margin-top: 20px">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">Confirm OTP - Register</h6>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/authen?action=verify-otp" method="post">
                        <div class="mb-3">
                            <label for="ResetOTPCode" class="form-label">Enter OTP to confirm</label>
                            <input type="text" name="otp" id="ResetOTPCode" class="form-control" placeholder="Enter OTP" required>
                        </div>
                        <c:if test="${requestScope.error != null}">
                            <div class="text-danger text-center mb-3">
                                ${requestScope.error}
                            </div>
                        </c:if>
                        <button type="submit" class="btn btn-primary w-100">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"></jsp:include>
    <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>
</body>
</html>
