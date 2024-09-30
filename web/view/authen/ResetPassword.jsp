<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include  page="../common/authen/common-css-authen.jsp"></jsp:include>
        </head>
        <body>
            <style>
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

            <div class="container" id="forgotModal" style="margin-top: 100px; align-content: center">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="max-content similar__form form__padding">
                            <div class="d-flex mb-3 align-items-center justify-content-between">
                                <h6 class="mb-0">Reset Your Password</h6>
                            </div>

                            <!-- OTP confirmation form -->
                            <form action="authen?action=reset-password" method="POST" class="d-flex flex-column gap-3">
                                <div class="form-group">
                                    
                                    <label for="password" class="fw-medium text-dark mb-3">Password</label>
                                    <div class="position-relative">
                                        <!-- Trường nhập mật khẩu với icon để ẩn/hiện mật khẩu -->
                                        <input type="password" name="password" id="password" placeholder="Enter your new password" required onkeydown="preventSpaces(event)">
                                        <i class="fa-light fa-lock icon"></i>
                                        <!--                                     Icon mắt dùng để ẩn/hiện mật khẩu -->
                                        <span class="password__icon" onclick="togglePassword('password')">
                                            👁️
                                        </span>
                                    </div>

                                    <label for="confirmPassword" class="fw-medium text-dark mb-3">Confirm New Password</label>
                                    <div class="position-relative">
                                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Enter confirm to new password" required onkeydown="preventSpaces(event)">
                                        <i class="fa-sharp fa-light fa-envelope icon"></i>
                                        <span class="password__icon" onclick="togglePassword('confirmPassword')">
                                            👁️
                                        </span>
                                    </div>
                                </div>

                                <!-- Error message if OTP is incorrect -->
                                <c:if test="${requestScope.error != null}">
                                <div style="color: red; text-align: center;">
                                    ${requestScope.error}
                                </div>
                            </c:if>

                            <div class="form-group my-3">
                                <button type="submit" class="rts__btn w-100 fill__btn">Change Password</button>
                            </div>
                        </form>
                        <!-- Link to login page -->
                        <span class="d-block text-center fw-medium">Remember Your Password? <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="text-primary">Login</a></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer and JS includes -->
        <jsp:include page="../common/footer.jsp"></jsp:include>                       
        <jsp:include page="../common/authen/common-js-authen.jsp"></jsp:include>
    </body>

    <script>
        // Prevent entering spaces in password fields
            function preventSpaces(event) {
                if (event.key === " ") {
                    event.preventDefault();  // Prevent the space from being entered
                    alert("Passwords cannot contain spaces.");
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
</html>
