<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        </head>
        <body>
            <style>
                .btn-google {
                    display: inline-block;
                    background-color: #4285F4;
                    color: white;
                    padding: 10px 20px;
                    border-radius: 4px;
                    text-decoration: none;
                    font-size: 14px;
                    font-weight: bold;
                    transition: background-color 0.3s ease;
                }
                .btn-google:hover {
                    background-color: #357AE8;
                }
                .btn-google img {
                    vertical-align: middle;
                    margin-right: 8px;
                }
                .password__icon {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    cursor: pointer;
                    font-size: 18px; /* Thay đổi kích thước icon nếu cần */
                }

            </style>
            <!-- header area -->
        <jsp:include page="../common/header-area.jsp"></jsp:include>
            <!-- header area end -->

            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="max-content similar__form form__padding">

                            <div class="d-flex mb-3 align-items-center justify-content-between">
                                <h4 class="mb-0" style="margin-top: 100px; margin-left: 90px">Login To Jobpath</h4>
                            </div>
                        <c:set var="cookies" value="${pageContext.request.cookies}"/>

                        <c:if test="${requestScope.messLogin != null}">
                            <div style="color: red; text-align: center;">
                                ${requestScope.messLogin}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/authen?action=login" method="post" class="d-flex flex-column gap-3" id="login-form">
                            <c:set var="cookies" value="${pageContext.request.cookies}"/>
                            <div class="form-group">
                                <label for="username" class="fw-medium text-dark mb-3">Username</label>
                                <div class="position-relative">
                                    <input value="${cookie.cu.value}" type="username" name="username" id="username" placeholder="Enter your username" required>
                                    <i class="fa-light fa-user icon"></i>
                                </div>
                            </div>                        
                            <div class="form-group">
                                <label for="password" class="fw-medium text-dark mb-3">Password</label>
                                <div class="position-relative">
                                    <!-- Trường nhập mật khẩu với icon để ẩn/hiện mật khẩu -->
                                    <input value="${cookie.cp.value}" type="password" name="password" id="password" placeholder="Enter your password" required>
                                    <i class="fa-light fa-lock icon"></i>
                                    <!--                                     Icon mắt dùng để ẩn/hiện mật khẩu -->
                                    <span class="password__icon" onclick="togglePassword('password')">
                                        👁️
                                    </span>
                                </div>
                            </div>


                            <div class="d-flex flex-wrap justify-content-between align-items-center fw-medium">
                                <div class="form-check">

                                    <input ${(cookie.cr != null ? 'checked':'')} class="form-check-input" type="checkbox" name="rememberMe" id="flexCheckDefault">
                                    <label class="form-check-label" for="flexCheckDefault">
                                        Remember me
                                    </label>
                                </div>
                                <a href="${pageContext.request.contextPath}/view/authen/forgotPassword.jsp" class="text-primary">Forgot Password?</a>
                            </div>

                            <div style="color: green; text-align: center; font-size: 16px;">${requestScope.changePWsuccess}</div>

                            <div style="display: flex; justify-content: center;" class="g-recaptcha" data-sitekey="6LeVFEsqAAAAAFK_7xKTrV798KMOrnTYcVgfeMIa"></div> 
                            <div style="color: red" id="error"></div>
                            <!--                            <div class="form-group my-3">
                                                            <button type="button" onclick="checkCapcha()" class="rts__btn w-100 fill__btn">Login</button>
                                                        </div>-->
                            <div class="form-group my-3">
                                <button type="submit" class="rts__btn w-100 fill__btn">Login</button>
                            </div>                                                     
                        </form>
                        <span class="d-block text-center fw-medium">Don’t have an account? You can <a href="${pageContext.request.contextPath}/authen?action=sign-up" class="text-primary">Register</a></span>

                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>

        <script type="text/javascript">
            function checkCapcha() {
                var form = document.getElementById("login-form");
                var error = document.getElementById("error");
                const response = grecaptcha.getResponse();
                if (response) {
                    form.submit();
                } else {
                    error.textContent = "Please verify that you are not a robot.";
                }
            }
            function togglePassword(id) {
                var input = document.getElementById(id);
                if (input.type === "password") {
                    input.type = "text";
                } else {
                    input.type = "password";
                }
            }
        </script>
    </body>
</html>