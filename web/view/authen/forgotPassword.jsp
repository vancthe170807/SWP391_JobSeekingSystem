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

            <div class="" id="forgotModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="max-content similar__form form__padding">
                                <div class="d-flex mb-3 align-items-center justify-content-between">
                                    <h6 class="mb-0">Forgot Password</h6>
                                    <button type="button" data-bs-dismiss="modal" aria-label="Close">
                                        <i class="fa-regular fa-xmark text-primary"></i>
                                    </button>
                                </div>
                                <form action="#" class="d-flex flex-column gap-3">

                                    <div class="form-group">
                                        <label for="fmail" class="fw-medium text-dark mb-3">Your Email</label>
                                        <div class="position-relative">
                                            <input type="email" name="email" id="fmail" placeholder="Enter your email" required>
                                            <i class="fa-sharp fa-light fa-envelope icon"></i>
                                        </div>
                                    </div>

                                    <div class="form-group my-3">
                                        <button class="rts__btn w-100 fill__btn">Reset Password</button>
                                    </div>
                                </form>
                                <span class="d-block text-center fw-medium">Remember Your Password? <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="text-primary">Login</a></span>
                            </div>
                        </div>
                    </div>
                </div>
            <jsp:include page="../common/footer.jsp"></jsp:include>                       
            <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>
</html>
