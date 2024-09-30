<%-- 
    Document   : editUserProfile
    Created on : Sep 18, 2024, 5:45:45 PM
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
                <div class="dashboard__left">
                    <!-- sidebar menu -->
                    <div class="dashboard__sidebar">
                        <div class="dash__menu">
                            <ul>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                        <svg width="21" height="26" viewBox="0 0 21 26" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M10.466 10.4661C13.08 10.4661 15.199 8.34702 15.199 5.73303C15.199 3.11905 13.08 1 10.466 1C7.85202 1 5.73297 3.11905 5.73297 5.73303C5.73297 8.34702 7.85202 10.4661 10.466 10.4661Z"
                                            stroke="#595959" />
                                        <path
                                            d="M19.9321 19.3413C19.9321 22.2817 19.9321 24.6659 10.4661 24.6659C1 24.6659 1 22.2817 1 19.3413C1 16.4009 5.23843 14.0166 10.4661 14.0166C15.6937 14.0166 19.9321 16.4009 19.9321 19.3413Z"
                                            stroke="#595959" />
                                        </svg> Profile </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- sidebar menu end -->
                </div>
                <!--side bar end-->

                <!--content-main-->
                <div class="dashboard__right">
                    <div class="dash__content ">
                        <!-- sidebar menu -->
                        <div class="sidebar__menu d-md-block d-lg-none">
                            <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                        </div>
                        <!-- sidebar menu end -->
                        <form action="${pageContext.request.contextPath}/authen?action=edit-profile" method="POST" id="profile-form" enctype="multipart/form-data">
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
                                            <img id="preview" src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="">
                                        </c:if>

                                        <c:if test="${!empty sessionScope.account.getAvatar()}">
                                            <!-- Đường dẫn ảnh không trống -->
                                            <img id="preview" src="${sessionScope.account.getAvatar()}" alt="" width="150">
                                        </c:if>

                                    </div>
                                    <div class="select__image">
                                        <label for="file" class="file-upload__label">Upload New Photo</label>
                                        <input type="file" class="file-upload__input" id="file" name="image"  onchange="previewImage(event)">
                                    </div>


                                </div>
                                <div class="info__field">
                                    <div class="row row-cols-sm-2 row-cols-1 g-3">
                                        <div class="rt-input-group">
                                            <label for="lname">Last Name</label>
                                            <input type="text" name="lastName" id="lname" placeholder="Last Name" required value="${sessionScope.account.getLastName()}" >
                                        </div>
                                        <div class="rt-input-group">
                                            <label for="fname">First Name</label>
                                            <input type="text" name="firstName" id="fname" placeholder="First Name" required value="${sessionScope.account.getFirstName()}" >
                                        </div>
                                    </div>
                                    <div class="row row-cols-sm-2 row-cols-1 g-3">
                                        <div class="rt-input-group">
                                            <label for="phone">Phone</label>
                                            <input type="text" name="phone" id="phone" placeholder="+84" required value="${sessionScope.account.getPhone()}" >
                                        </div>
                                        <div class="rt-input-group">
                                            <label for="dob">Date of Birth</label>
                                            <input type="date" name="date" id="dob" required value="${sessionScope.account.getDob()}" >
                                        </div>
                                    </div>
                                    <div class="row row-cols-sm-2 row-cols-1 g-3">
                                        <div class="rt-input-group">
                                            <label for="gender">Gender</label>
                                            <select name="gender" id="gender" class="form-select">
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                            </select>
                                        </div> 
                                        
                                    </div>
                                    <div class="row row-cols-sm-2 row-cols-1 g-3">
                                        <div class="rt-input-group">
                                            <label for="add">Address</label>
                                            <input type="text" name="address" id="add" placeholder="Your Address" value="${sessionScope.account.getAddress()}"required>
                                        </div>
                                        <div class="rt-input-group">
                                            <label for="email">Email</label>
                                            <input type="email" name="email" id="email" value="${sessionScope.account.getEmail()}" required readonly >
                                        </div>
                                    </div>

                                </div>
                                <c:if test="${requestScope.error != null}">
                                    <div style="color: red; text-align: center;">
                                        ${requestScope.error}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <div class="info__field">
                            <button type="submit" class="rts__btn fill__btn mx-0" onclick="document.querySelector('#profile-form').submit()">Save Profile</button>
                        </div>
                    </form>
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
        <script>
            function previewImage(event) {
                console.log("previewImage function called");
                var input = event.target;
                if (!input.files || !input.files[0]) {
                    console.log("No file selected");
                    return;
                }

                console.log("File selected:", input.files[0].name);

                var reader = new FileReader();
                reader.onload = function (e) {
                    console.log("FileReader onload triggered");
                    var output = document.getElementById('preview');
                    if (output) {
                        output.src = e.target.result;
                        console.log("Image preview updated");
                    } else {
                        console.error("Preview element not found");
                    }
                };
                reader.onerror = function (error) {
                    console.error("FileReader error:", error);
                };
                reader.readAsDataURL(input.files[0]);
            }
        </script>
    </body>
</html>
