<%-- 
    Document   : login
    Created on : Sep 15, 2024, 6:07:15 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="max-content similar__form form__padding">
                            <div class="d-flex mb-3 align-items-center justify-content-between">
                                <h4 class="mb-0" style="margin-top: 100px; margin-left: 90px">Login To Jobpath</h4>
                            </div>
                        <c:set var="cookies" value="${pageContext.request.cookies}"/>

                        <c:if test="${requestScope.mess != null}">
                            <div style="color: red; text-align: center;">
                                ${requestScope.mess}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/authen?action=login" method="post" class="d-flex flex-column gap-3">
                            <c:set var="cookies" value="${pageContext.request.cookies}"/>
                            <div class="form-group">
                                <label for="username" class="fw-medium text-dark mb-3">Username</label>
                                <div class="position-relative">
                                    <input value="${cookie.cu.value}" type="text" name="username" id="username" placeholder="Enter your username" required>
                                    <i class="fa-light fa-user icon"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="fw-medium text-dark mb-3">Password</label>
                                <div class="position-relative">
                                    <input value="${cookie.cp.value}" type="password" name="password" id="password" placeholder="Enter your password" required>
                                    <i class="fa-light fa-lock icon"></i>
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

    </body>
</html>

