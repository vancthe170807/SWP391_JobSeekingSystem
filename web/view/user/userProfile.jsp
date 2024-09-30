<%-- 
    Document   : userProfile
    Created on : Sep 18, 2024, 5:20:27 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <jsp:include page="../common/user/common-css-user.jsp"></jsp:include>
        </head>
        <body class="template-dashboard">
            <!-- header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- header area end -->

            <!-- content area -->
            <div class="dashboard__content d-flex">
                <!--side bar-->
            <jsp:include page="../common/user/sidebar-user.jsp"></jsp:include>
                <!--side bar end-->

                <!--content-main-->
                <div class="dashboard__right">
                    <div class="dash__content ">
                        <!-- sidebar menu -->
                        <div class="sidebar__menu d-md-block d-lg-none">
                            <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                        </div>
                        <!-- sidebar menu end -->

                        <div class="my__profile__tab radius-16 bg-white">
                            <nav>
                                <div class="nav nav-tabs">
                                    <a class="nav-link active" href="#info">My Details</a>

                                </div>
                            </nav>
                            <div class="my__details" id="info">
                                <div class="info__top">
                                    <div class="author__image">
                                        <c:if test="${empty sessionScope.account.getAvatar()}">
                                            <!-- Đường dẫn ảnh trống -->
                                            <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="">
                                        </c:if>

                                        <c:if test="${!empty sessionScope.account.getAvatar()}">
                                            <!-- Đường dẫn ảnh không trống -->
                                            <img src="${sessionScope.account.getAvatar()}" alt="">
                                        </c:if>
                                </div>
                                <div class="select__image">
                                    <label for="editProfile" class="file-upload__label">Edit Profile</label>
                                    <input type="button" class="file-upload__input" id="editProfile" onclick="location.href = '${pageContext.request.contextPath}/authen?action=edit-profile'" value="Edit Profile">
                                </div>


                            </div>
                            <div class="info__field">
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="name">Full Name</label>
                                        <input type="text" id="name" placeholder="Full Name" required readonly value="${sessionScope.account.getFullName()}">
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" placeholder="jobpath@gmqail.com" required readonly value="${sessionScope.account.getEmail()}">
                                    </div>
                                </div>
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="phone">Phone</label>
                                        <input type="text" id="phone" placeholder="+84" required readonly value="${sessionScope.account.getPhone()}">
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="dob">Date of Birth</label>
                                        <input type="date" id="dob" required readonly value="${sessionScope.account.getDob()}">
                                    </div>
                                </div>
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="gender">Gender</label>
                                        <input type="text" id="genderDisplay" class="form-control" value="${sessionScope.account.isGender() == true ? 'Male' : 'Female'}" readonly >
                                        <input type="hidden" name="gender" id="genderHidden">
                                    </div>
                                </div>
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="add">Address</label>
                                        <input type="text" id="add" placeholder="Your Address" required readonly value="${sessionScope.account.getAddress()}">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- address area end -->
                </div>
                <div class="d-flex justify-content-center mt-30">
                    <p class="copyright">Copyright © 2024 All Rights Reserved by jobpath</p>
                </div>
            </div>
        </div>
        <!-- content area end -->



        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
            <div class="offcanvas-header p-0 mb-5 mt-4">
                <a href="index.html" class="offcanvas-title" id="offcanvasLabel">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" alt="logo">
                </a> 
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <!-- login offcanvas -->
            <div class="mb-4 d-block d-sm-none">
                <div class="header__right__btn d-flex justify-content-center gap-3">
<!--                    <a href="#" class="small__btn no__fill__btn border-6 font-xs" aria-label="Login Button" data-bs-toggle="modal" data-bs-target="#loginModal"> <i class="rt-login"></i>Sign In</a>-->
                    <a href="#" class="small__btn d-xl-flex fill__btn border-6 font-xs" aria-label="Job Posting Button">Add Job</a>
                </div>
            </div>
            <div class="offcanvas-body p-0">
                <div class="rts__offcanvas__menu overflow-hidden">
                    <div class="offcanvas__menu"></div>
                </div>
                <p class="max-auto font-20 fw-medium text-center text-decoration-underline mt-4">Our Social Links</p>
                <div class="rts__social d-flex justify-content-center gap-3 mt-3">
                    <a href="https://facebook.com"  aria-label="facebook">
                        <i class="fa-brands fa-facebook"></i>
                    </a>
                    <a href="https://instagram.com"  aria-label="instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="https://linkedin.com"  aria-label="linkedin">
                        <i class="fa-brands fa-linkedin"></i>
                    </a>
                    <a href="https://pinterest.com"  aria-label="pinterest">
                        <i class="fa-brands fa-pinterest"></i>
                    </a>
                    <a href="https://youtube.com"  aria-label="youtube">
                        <i class="fa-brands fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
        <!-- THEME PRELOADER START -->
        <div class="loader-wrapper">
            <div class="loader">
            </div>
            <div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>
        </div>
        <!-- THEME PRELOADER END -->
        <button type="button" class="rts__back__top" id="rts-back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>
        <!-- all plugin js -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>
        

        

    </body>
</html>
