<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
        </head>
        <body>
            <!-- header area -->
        <jsp:include page="../common/header-area.jsp"></jsp:include>
            <!-- header area end -->

            <div class="container" id="forgotModal" style="margin-top: 100px">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="max-content similar__form form__padding">
                            <div class="d-flex mb-3 align-items-center justify-content-between">
                                <h6 class="mb-0">Reset Your Password</h6>
                            </div>

                            <!-- OTP confirmation form -->
                            <form action="authen?action=reset-password" method="POST" class="d-flex flex-column gap-3">
                                <div class="form-group">
                                    <label for="password" class="fw-medium text-dark mb-3">New Password</label>
                                    <div class="position-relative">
                                        <input type="password" name="password" id="password" placeholder="Enter new password" required>
                                        <i class="fa-sharp fa-light fa-envelope icon"></i>
                                    </div>

                                    <label for="confirmPassword" class="fw-medium text-dark mb-3">Confirm New Password</label>
                                    <div class="position-relative">
                                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Enter confirm to new password" required>
                                        <i class="fa-sharp fa-light fa-envelope icon"></i>
                                    </div>
                                </div>

                                <!-- Error message if OTP is incorrect -->
                                <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    ${error}
                                </div>
                            </c:if>

                            <div class="form-group my-3">
                                <button type="submit" class="rts__btn w-100 fill__btn">Change Password</button>
                            </div>
                        </form>
                        <!-- Link to login page -->
                        <span class="d-block text-center fw-medium">Remember Your Password? <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="text-primary">Login</a></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer and JS includes -->
        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>
    </body>
</html>
