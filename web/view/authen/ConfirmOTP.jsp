<%-- 
    Document   : forgotPassword
    Created on : Sep 15, 2024, 9:50:14 PM
    Author     : Admin
--%>

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
                            <h6 class="mb-0">Confirm OTP - Register</h6>
                        </div>

                        <!-- OTP confirmation form -->
                        <form action="authen?action=verify-otp" method="POST" class="d-flex flex-column gap-3">
                            <div class="form-group">
                                <label for="inputOTP" class="fw-medium text-dark mb-3">Enter OTP to confirm</label>
                                <div class="position-relative">
                                    <input type="text" name="otp" id="inputOTP" placeholder="Enter OTP" required>
                                    <i class="fa-sharp fa-light fa-envelope icon"></i>
                                </div>
                            </div>

                            <!-- Error message if OTP is incorrect -->
                            <c:if test="${requestScope.error != null}">
                                    <div style="color: red; text-align: center;">
                                        ${requestScope.error}
                                    </div>
                                </c:if>

                            <div class="form-group my-3">
                                <button type="submit" class="rts__btn w-100 fill__btn">Confirm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer and JS includes -->
        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>
    </body>
</html>
