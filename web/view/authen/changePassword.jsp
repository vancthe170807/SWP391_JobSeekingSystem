<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
            <style>
                .password__change__form {
                    max-width: 500px;
                    margin: 0 auto;
                    padding: 30px;
                    background-color: #f9f9f9;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    border-radius: 10px;
                }
                .input-box {
                    position: relative;
                }
                .password__icon {
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    cursor: pointer;
                }
                h4 {
                    color: #28a745; /* Màu xanh lá cây cho tiêu đề */
                }
                .rts-input-group {
                    margin-bottom: 15px;
                }
                .rts-input-group label {
                    font-weight: bold;
                    margin-bottom: 5px;
                    display: block;
                }
                .input-box input {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    padding-left: 40px; /* Khoảng cách cho icon */
                }
                .rts__btn {
                    background-color: #28a745;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }
                .rts__btn:hover {
                    background-color: #218838;
                }
                .cancel__btn {
                    background-color: #6c757d;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    margin-right: 10px;
                }
                .cancel__btn:hover {
                    background-color: #5a6268;
                }
                .error-message {
                    color: red;
                    text-align: center;
                    font-size: 16px;
                    margin-bottom: 10px;
                }
                .icon-left {
                    position: absolute;
                    left: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                }
            </style>
        <div class="container-none">
            <div class="rts__menu__background">
                <div class="row">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="rts__logo">
                            <a href="${pageContext.request.contextPath}/view/home.jsp">
                            <img class="logo__image" src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
                        </a>
                    </div>
                    <div class="rts__menu d-flex gap-5 gap-lg-4 gap-xl-5 align-items-center">
                        <div class="navigation d-none d-lg-block">
                            <nav class="navigation__menu" id="offcanvas__menu">
                                <ul class="list-unstyled">
                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Home</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem"><a href="index.html">Home One</a></li>
                                            <li role="menuitem"><a href="index-2.html">Home Two</a></li>
                                            <li role="menuitem"><a href="index-3.html">Home Three</a></li>
                                            <li role="menuitem"><a href="index-4.html">Home Four</a></li>
                                            <li role="menuitem"><a href="index-5.html">Home Five</a></li>
                                            <li role="menuitem"><a href="index-6.html">Home Six</a></li>
                                        </ul>
                                    </li>

                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Browse Jobs</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="#">Job List</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="job-list-1.html">Job List One</a></li>
                                                    <li role="menuitem"><a href="job-list-2.html">Job List Two</a></li>
                                                    <li role="menuitem"><a href="job-list-3.html">Job List Three</a></li>
                                                    <li role="menuitem"><a href="job-list-4.html">Job List Four</a></li>
                                                    <li role="menuitem"><a href="job-list-5.html">Job List Five</a></li>
                                                </ul>
                                            </li>
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="#">Job Details</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="job-details-1.html">Job Details One</a></li>
                                                    <li role="menuitem"><a href="job-details-2.html">Job Details Two</a></li>
                                                    <li role="menuitem"><a href="job-details-3.html">Job Details Three</a></li>
                                                    <li role="menuitem"><a href="job-details-4.html">Job Details Four</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>

                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Employers</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="employer-1.html">Employer Style</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="employer-1.html">Employer One</a></li>
                                                    <li role="menuitem"><a href="employer-2.html">Employer Two</a></li>
                                                    <li role="menuitem"><a href="employer-3.html">Employer Three</a></li>
                                                </ul>
                                            </li>
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="employer-details-1.html">Employer Details</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="employer-details-1.html">Employer Details 1</a></li>
                                                    <li role="menuitem"><a href="employer-details-2.html">Employer Details 2</a></li>
                                                </ul>
                                            </li>
                                            <li role="menuitem"><a href="employer-dashboard.html">Employer Dashboard</a></li>
                                        </ul>
                                    </li>

                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Candidates</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="candidate-1.html">Candidate Style</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="candidate-1.html">Candidate One</a></li>
                                                    <li role="menuitem"><a href="candidate-2.html">Candidate Two</a></li>
                                                    <li role="menuitem"><a href="candidate-3.html">Candidate Three</a></li>
                                                    <li role="menuitem"><a href="candidate-4.html">Candidate Four</a></li>
                                                </ul>
                                            </li>
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="candidate-details-1.html">Candidate Details</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="candidate-details-1.html">Candidate Details 1</a></li>
                                                    <li role="menuitem"><a href="candidate-details-2.html">Candidate Details 2</a></li>

                                                </ul>
                                            </li>
                                            <li role="menuitem"><a href="candidate-dashboard.html">Candidate Dashboard</a></li>
                                        </ul>
                                    </li>

                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Pages</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem" class="has-child has-arrow">
                                                <a href="about.html">Blog</a>
                                                <ul class="sub__style" role="menu">
                                                    <li role="menuitem"><a href="blog-1.html">Blog One</a></li>
                                                    <li role="menuitem"><a href="blog-2.html">Blog Two</a></li>
                                                    <li role="menuitem"><a href="blog-3.html">Blog Three</a></li>
                                                    <li role="menuitem"><a href="blog-4.html">Blog Four</a></li>
                                                    <li role="menuitem"><a href="blog-details.html">Blog Details</a></li>
                                                </ul>
                                            </li>
                                            <li role="menuitem"><a href="about.html">About</a></li>
                                            <li role="menuitem"><a href="faq.html">Faq</a></li>
                                            <li role="menuitem"><a href="tos.html">Terms &amp; Conditions</a></li>
                                            <li role="menuitem"><a href="privacy.html">Privacy Policy</a></li>
                                            <li role="menuitem"><a href="pricing.html">Pricing</a></li>
                                        </ul>
                                    </li>

                                    <li class="navigation__menu--item has-child has-arrow">
                                        <a href="#" class="navigation__menu--item__link">Contact</a>
                                        <ul class="submenu sub__style" role="menu">
                                            <li role="menuitem"><a href="contact-1.html">Contact One</a></li>
                                            <li role="menuitem"><a href="contact-2.html">Contact Two</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="header__right__btn d-flex gap-3">
                            <a href="${pageContext.request.contextPath}/view/authen/logout.jsp" class="small__btn d-none d-sm-flex no__fill__btn border-6 font-xs" aria-label="Login Button">Logout</a>                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</head>
<body>        
    <div class="change__password" style="margin-top: 100px; margin-bottom: 20px">
        <div class="password__change__form">
            <h4 class="text-center mb-4">Change Password</h4>
            <form action="${pageContext.request.contextPath}/authen?action=change-password" method="post">
                <!-- Current Password -->
                <div class="rts-input-group">
                    <label for="currentPassword">Current Password</label>
                    <div class="input-box">
                        <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#6c757d"/>
                        </svg>
                        <input type="password" name="currentPassword" id="currentPassword" placeholder="Enter your current password" required>
                    </div>
                </div>

                <!-- New Password -->
                <div class="rts-input-group">
                    <label for="newPassword">New Password</label>
                    <div class="input-box">
                        <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#28a745"/>
                        </svg>
                        <input type="password" name="newPassword" id="newPassword" placeholder="Enter your new password" required>
                    </div>
                </div>

                <!-- Retype Password -->
                <div class="rts-input-group">
                    <label for="retypePassword">Retype Password</label>
                    <div class="input-box">
                        <svg class="icon-left" width="26" height="26" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zM12 7c2.76 0 5 2.24 5 5s-2.24 5-5 5-5-2.24-5-5 2.24-5 5-5m0-2C8.13 5 5 8.13 5 12s3.13 7 7 7 7-3.13 7-7-3.13-7-7-7z" fill="#007bff"/>
                        </svg>
                        <input type="password" name="retypePassword" id="retypePassword" placeholder="Retype your new password" required>
                    </div>
                </div>

                <!-- Error message -->
                <c:if test="${not empty requestScope.changePWfail}">
                    <div class="error-message">${requestScope.changePWfail}</div>
                </c:if>

                <!-- Buttons: Cancel and Update -->
                <div class="d-flex justify-content-between">
                    <button type="submit" class="rts__btn fill__btn">Update Password</button>
                    <button type="button" class="rts__btn fill__btn" onclick="cancelChangePassword()">Cancel</button>
                </div>
            </form>              
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"></jsp:include>                       
    <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>

    <!-- JavaScript function for Cancel -->
    <script>
        function cancelChangePassword() {
            window.history.back();
        }
        function togglePasswordVisibility(id) {
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
