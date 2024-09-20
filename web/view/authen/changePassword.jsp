<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
        </head>
        <body>        
        <jsp:include page="../common/header-area.jsp"></jsp:include>
            <div class="password__change__form">
                <h4 class="text-center mb-4" style="margin-top: 110px; color: green">Change Password</h4>
                <form action="${pageContext.request.contextPath}/authen?action=change-password" method="post">

                <!-- single item -->
                <div class="rts-input-group" style="margin: 0 30%">
                    <label for="currentPassword">Current Password</label>
                    <div class="input-box">
                        <input type="password" name="currentPassword" id="currentPassword" placeholder="Enter your current password" required>

                    </div>
                </div>
                <h4 style="color: red; text-align: center; font-size: 18px;">${requestScope.msg1}</h4>
                <!-- single item end -->
                <!-- single item -->
                <div class="rts-input-group" style="margin: 0 30%">
                    <label for="currentPassword">New password</label>
                    <div class="input-box">
                        <input type="password" name="newPassword" id="Newpassword" placeholder="Enter your New password" required>
                    </div>
                </div>
                <!-- single item end -->
                <!-- single item -->
                <div class="rts-input-group" style="margin: 0 30%" >
                    <label for="currentPassword">Retype password</label>
                    <div class="input-box">
                        <input type="password" name="retypePassword" id="Retypepassword" placeholder="Enter your Retype password" required>
                    </div>
                </div>
                
                <h4 style="color: red; text-align: center; font-size: 18px;">${requestScope.msg2}</h4>
                <h4 style="color: red; text-align: center; font-size: 18px;">${requestScope.msg3}</h4>
                <!-- single item end -->
                <div class="d-flex justify-content-end" style="margin: 0 auto">
                    <button type="submit" class="rts__btn fill__btn">Update Password</button>
                </div>

                <div class="d-flex justify-content-end" style="margin: 0 auto">

                    <h4 style="color: red"> ${requestScope.msg3}</h4>
                    <c:choose>
                        <c:when test="${sessionScope.role == 1}">
                            <a href="${pageContext.request.contextPath}/view/admin/adminHome.jsp" class="rts__btn fill__btn">Back To Admin Home</a>
                        </c:when>
                        <c:when test="${sessionScope.role == 2}">
                            <a href="${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp" class="rts__btn fill__btn">Back To Recruiter Home</a>
                        </c:when>
                        <c:when test="${sessionScope.role == 3}">
                            <a href="${pageContext.request.contextPath}/view/user/userHome.jsp" class="rts__btn fill__btn">Back To Seeker Home</a>
                        </c:when>
                    </c:choose>
                </div>

            </form>
        </div>

        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>
    </body>
</html>