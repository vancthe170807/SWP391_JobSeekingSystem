<%-- 
    Document   : register
    Created on : Sep 15, 2024, 9:29:22 PM
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

            <div class="" id="signupModal">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="max-content similar__form form__padding">
                                <div class="d-flex mb-3 align-items-center justify-content-between">
                                    <h6 class="mb-0">Create A Free Account</h6>
                                    <button type="button" data-bs-dismiss="modal" aria-label="Close">
                                        <i class="fa-regular fa-xmark text-primary"></i>
                                    </button>
                                </div>
                                <div class="d-block has__line text-center"><p>Choose your Account Type</p></div>

                                <div class="tab__switch flex-wrap flex-sm-nowrap nav-tab mt-30 mb-30">
                                    <button class="rts__btn nav-link  active"><i class="fa-light fa-user"></i>Candidate</button>
                                    <button class="rts__btn nav-link"><i class="rt-briefcase"></i> Employer</button>
                                </div>
                                <form action="#" class="d-flex flex-column gap-3">

                                    <div class="form-group">
                                        <label for="sname" class="fw-medium text-dark mb-3">Your Name</label>
                                        <div class="position-relative">
                                            <input type="text" name="sname" id="sname" placeholder="Candidate" required>
                                            <i class="fa-light fa-user icon"></i>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="signemail" class="fw-medium text-dark mb-3">Your Email</label>
                                        <div class="position-relative">
                                            <input type="email" name="signemail" id="signemail" placeholder="Enter your email" required>
                                            <i class="fa-sharp fa-light fa-envelope icon"></i>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="spassword" class="fw-medium text-dark mb-3">Password</label>
                                        <div class="position-relative">
                                            <input type="password" name="spassword" id="spassword" placeholder="Enter your password" required>
                                            <i class="fa-light fa-lock icon"></i>
                                        </div>
                                    </div>

                                    <div class="form-group my-3">
                                        <button class="rts__btn w-100 fill__btn">Login</button>
                                    </div>
                                </form>
                                <div class="d-block has__line text-center"><p>Or</p></div>
                                <div class="d-flex flex-wrap justify-content-center gap-4 mt-20 mb-20">
                                    <div class="is__social google">
                                        <button><img src="${pageContext.request.contextPath}/assets/img/icon/google-small.svg" alt="">Continue with Google</button>
                                </div>
                                <div class="is__social facebook">
                                    <button><img src="${pageContext.request.contextPath}/assets/img/icon/facebook-small.svg" alt="">Continue with Facebook</button>
                                </div>
                            </div>
                            <span class="d-block text-center fw-medium">Have an account? You can <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="text-primary">Login</a></span>

                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../common/footer.jsp"></jsp:include>                    
            <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>                    
</html>
