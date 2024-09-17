<%-- 
    Document   : login
    Created on : Sep 15, 2024, 6:07:15 PM
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

            <!--<div class="modal similar__modal fade " id="loginModal">-->
            <div class="" id="loginModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="max-content similar__form form__padding">
                                <div class="d-flex mb-3 align-items-center justify-content-between">
                                    <h4 class="mb-0" style="margin-top: 100px; margin-left: 90px">Login To Jobpath</h4>
                                    <button type="button" data-bs-dismiss="modal" aria-label="Close">
                                        <i class="fa-regular fa-xmark text-primary"></i>
                                    </button>
                                </div>
                                <form action="${pageContext.request.contextPath}/login" method="post" class="d-flex flex-column gap-3">
                                    <div class="form-group">
                                        <label for="email" class="fw-medium text-dark mb-3">Your Email</label>
                                        <div class="position-relative">
                                            <input type="email" name="email" id="email" value="user@test.com" placeholder="Enter your email" required>
                                            <i class="fa-light fa-user icon"></i>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="fw-medium text-dark mb-3">Password</label>
                                        <div class="position-relative">
                                            <input type="password" name="password" value="1234" id="password" placeholder="Enter your password" required>
                                            <i class="fa-light fa-lock icon"></i>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-wrap justify-content-between align-items-center fw-medium">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                            <label class="form-check-label" for="flexCheckDefault">
                                                Remember me
                                            </label>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/view/authen/forgotPassword.jsp" class="text-primary">Forgot Password?</a>
                                    </div>
                                    <div class="form-group my-3">
                                        <button type="submit" class="rts__btn w-100 fill__btn">Login</button>
                                    </div>
                                </form>
                                <div class="d-block has__line text-center"><p>Or</p></div>
                                <div class="d-flex gap-4 flex-wrap justify-content-center mt-20 mb-20">
                                    <div class="is__social google">
                                        <button disabled><img src="${pageContext.request.contextPath}/assets/img/icon/google-small.svg" alt="">Continue with Google</button>
                                </div>
                            </div>
                            <span class="d-block text-center fw-medium">Don’t have an account? You can <a href="${pageContext.request.contextPath}/view/authen/register.jsp" class="text-primary">Register</a></span>

                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../common/footer.jsp"></jsp:include>                       
            <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>

    </body>
</html>

