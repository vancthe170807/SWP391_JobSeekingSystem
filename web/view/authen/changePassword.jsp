<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
            <style>
                .password__change__form {
                    max-width: 500px;
                    margin: 0 auto;
                    padding: 30px;
                    background-color: #f9f9f9;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    border-radius: 10px;
                }
                .input-box {
                    position: relative;
                }
                .password__icon {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    cursor: pointer;
                }
                h4 {
                    color: #28a745; /* Màu xanh lá cây cho tiêu đề */
                }
                .rts-input-group {
                    margin-bottom: 15px;
                }
                .rts-input-group label {
                    font-weight: bold;
                    margin-bottom: 5px;
                    display: block;
                }
                .input-box input {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    padding-left: 40px; /* Khoảng cách cho icon */
                }
                .rts__btn {
                    background-color: #28a745;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }
                .rts__btn:hover {
                    background-color: #218838;
                }
                .cancel__btn {
                    background-color: #6c757d;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    margin-right: 10px;
                }
                .cancel__btn:hover {
                    background-color: #5a6268;
                }
                .error-message {
                    color: red;
                    text-align: center;
                    font-size: 16px;
                    margin-bottom: 10px;
                }
                .icon-left {
                    position: absolute;
                    left: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                }
            </style>
        </head>
        <body>        
        <jsp:include page="../common/header-area.jsp"></jsp:include>
            <div class="change__password" style="margin-top: 100px; margin-bottom: 20px">
                <div class="password__change__form">
                    <h4 class="text-center mb-4">Change Password</h4>
                    <form action="${pageContext.request.contextPath}/authen?action=change-password" method="post">
                    <!-- Current Password -->
                    <div class="rts-input-group">
                        <label for="currentPassword">Current Password</label>
                        <div class="input-box">
                            <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#6c757d"/>
                            </svg>
                            <input type="password" name="currentPassword" id="currentPassword" placeholder="Enter your current password" required>
                        </div>
                    </div>

                    <!-- New Password -->
                    <div class="rts-input-group">
                        <label for="newPassword">New Password</label>
                        <div class="input-box">
                            <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#28a745"/>
                            </svg>
                            <input type="password" name="newPassword" id="newPassword" placeholder="Enter your new password" required>
                        </div>
                    </div>

                    <!-- Retype Password -->
                    <div class="rts-input-group">
                        <label for="retypePassword">Retype Password</label>
                        <div class="input-box">
                            <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#007bff"/>
                            </svg>
                            <input type="password" name="retypePassword" id="retypePassword" placeholder="Retype your new password" required>
                        </div>
                    </div>

                    <!-- Error message -->
                    <c:if test="${not empty requestScope.changePWfail}">
                        <div class="error-message">${requestScope.changePWfail}</div>
                    </c:if>

                    <!-- Buttons: Cancel and Update -->
                    <div class="d-flex justify-content-between">
                        <button type="submit" class="rts__btn fill__btn">Update Password</button>
                        <button type="button" class="rts__btn fill__btn" onclick="cancelChangePassword()">Cancel</button>
                    </div>


                </form>              
            </div>
        </div>

        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>

            <!-- JavaScript function for Cancel -->
            <script>
                function cancelChangePassword() {

                    var role = ${sessionScope.account.getRoleId()};

                    if (role === 1) {
                        window.location.href = "${pageContext.request.contextPath}/view/admin/adminHome.jsp";
                    } else if (role === 2) {
                        window.location.href = "${pageContext.request.contextPath}/view/recruiter/user/recruiterHome.jsp";
                    } else if (role === 3) {
                        window.location.href = "${pageContext.request.contextPath}/view/user/userHome.jsp";
                    } else {
                        // Trường hợp không xác định vai trò
                        window.location.href = "${pageContext.request.contextPath}/view/home.jsp";
                    }
                }
        </script>
    </body>
</html>
