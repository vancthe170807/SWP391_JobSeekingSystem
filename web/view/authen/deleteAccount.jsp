<%-- 
    Document   : userProfile
    Created on : Sep 18, 2024, 5:20:27 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- CSS -->
        <jsp:include page="../common/authen/common-css-authen.jsp"></jsp:include>
        </head>
        <body class="template-dashboard">
            <!-- Header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <!-- Content area -->
            <div class="dashboard__content d-flex">
                <!-- Sidebar -->
            <jsp:include page="../common/user/sidebar-user.jsp"></jsp:include>

                <!-- Profile Deletion Form -->
                <div class="candidate__passwordchange" style="margin-left: 500px; margin-right: 100px">
                    <h6 class="mb-3">Delete Profile</h6>
                    <div class="change__password">
                        <div class="password__change__form">
                            <h6 class="text-center mb-4">Are you sure you want to delete your profile?</h6>
                            <form action="${pageContext.request.contextPath}/authen?action=delete-account" method="POST">
                            <!-- Password Input -->
                            <c:if test="${requestScope.error != null}">
                                <div style="color: red; text-align: center;">
                                    ${requestScope.error}
                                </div>
                            </c:if>
                            <div class="rts-input-group">
                                <label for="currentPassword">Please Enter Your Login Password</label>
                                <input type="password" name="currentPassword" id="currentPassword" placeholder="Enter your current password" required>
                                <span><strong>Note: </strong>After deleting your account, all associated data will be permanently removed and cannot be restored. Please consider this decision carefully before proceeding.</span>
                            </div>
                                
                            <!-- Action Buttons -->
                            <div class="d-flex justify-content-end gap-30">
                                <button type="button" class="rts__btn fill__btn" onclick="window.location.href = '${pageContext.request.contextPath}/view/home.jsp'">Cancel</button>
                                <button type="submit" class="cancel__button rts__btn gray__btn">Delete Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Theme Preloader -->
            <div class="loader-wrapper">
                <div class="loader"></div>
                <div class="loader-section section-left"></div>
                <div class="loader-section section-right"></div>
            </div>

            <!-- Back to Top Button -->
            <button type="button" class="rts__back__top" id="rts-back-to-top">
                <i class="fas fa-arrow-up"></i>
            </button>

        </div>

        <!-- Plugin JS -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>

    </body>
</html>
