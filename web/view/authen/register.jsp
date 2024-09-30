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

            <div class="" id="signupModal" style="margin-top: 100px">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="max-content similar__form form__padding">
                                <div class="d-flex mb-3 align-items-center justify-content-between">
                                    <h6 class="mb-0">Create A Free Account</h6>

                                </div>
                                <div class="d-block has__line text-center"><p>Choose your Account Type</p></div>

                                <div class="tab__switch flex-wrap flex-sm-nowrap nav-tab mt-30 mb-30">
                                    <button class="rts__btn nav-link  active"><i class="fa-light fa-user"></i>Seeker</button>
                                    <button class="rts__btn nav-link"><i class="rt-briefcase"></i>Recruiter</button>
                                </div>
                                <form action="${pageContext.request.contextPath}/authen?action=sign-up" method="POST" class="d-flex flex-column gap-3">
                                <input type="hidden" name="role" value=""/>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">Last Name</label>
                                    <div class="position-relative">
                                        <input type="text" name="lastname" id="sname" placeholder="Enter last name" value="${requestScope.lname}" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                    <span style="color:red">${errorName}</span>
                                </div>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">First name</label>
                                    <div class="position-relative">
                                        <input type="text" name="firstname" id="sname" placeholder="Enter first name" value="${requestScope.fname}" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                    <span style="color:red">${errorName}</span>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select name="gender" id="gender" class="form-select" >
                                        <option value="male" ${gender == 'male' ? 'selected' : ''}>Male</option>
                                        <option value="female" ${gender == 'female' ? 'selected' : ''}>Female</option>
                                    </select>

                                </div>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">User name</label>
                                    <div class="position-relative">
                                        <input type="text" name="username" id="sname" placeholder="Enter user name" value="${requestScope.username}" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                    <span style="color:red">${errorUsernameExits}</span>
                                    <span style="color:red">${errorUsername}</span>
                                </div>

                                <div class="form-group">
                                    <label for="signemail" class="fw-medium text-dark mb-3">Your Email</label>
                                    <div class="position-relative">
                                        <input type="email" name="email" id="signemail" placeholder="Enter your email" value="${requestScope.email}" required>
                                        <i class="fa-sharp fa-light fa-envelope icon"></i>
                                    </div>
                                    <span style="color:red">${errorEmail}</span>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="fw-medium text-dark mb-3">Password</label>
                                    <div class="position-relative">
                                        <!-- Trường nhập mật khẩu với icon để ẩn/hiện mật khẩu -->
                                        <input value="${cookie.cp.value}" type="password" name="password" id="password" placeholder="Enter your password" value="${requestScope.password}" required>
                                        <i class="fa-light fa-lock icon"></i>
                                        <!--                                     Icon mắt dùng để ẩn/hiện mật khẩu -->
                                        <span class="password__icon" onclick="togglePassword('password')">
                                            👁️
                                        </span>
                                    </div>
                                    <span style="color: #737477">! Password must be 8-20 character, Contain at least alphabet and special character </span>    
                                    <span style="color:red">${errorPassword}</span>
                                </div>
                                <div class="form-group my-3">
                                    <button class="rts__btn w-100 fill__btn" onclick="document.querySelector('#signUpForm').submit()">Register</button>
                                </div>
                            </form>
                            <span class="d-block text-center fw-medium">Have an account? You can <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="text-primary">Login</a></span>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/footer.jsp"></jsp:include>                    
        <jsp:include  page="../common/authen/common-js-authen.jsp"></jsp:include>      
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const buttons = document.querySelectorAll('.tab__switch .rts__btn');
                    const hiddenInput = document.querySelector('input[name="role"]');

                    buttons.forEach(button => {
                        button.addEventListener('click', function () {
                            // Remove active class from all buttons
                            buttons.forEach(btn => btn.classList.remove('active'));

                            // Add active class to clicked button
                            this.classList.add('active');

                            // Update hidden input value based on selection
                            if (this.textContent.trim() === 'Seeker') {
                                hiddenInput.value = '3';
                            } else if (this.textContent.trim() === 'Recruiter') {
                                hiddenInput.value = '2';
                            }
                        });
                    });

                    // Set initial value based on the button that has 'active' class
                    const activeButton = document.querySelector('.tab__switch .rts__btn.active');
                    if (activeButton) {
                        hiddenInput.value = activeButton.textContent.trim() === 'Seeker' ? '3' : '2';
                    }
                });
                function togglePassword(id) {
                    var input = document.getElementById(id);
                    if (input.type === "password") {
                        input.type = "text";
                    } else {
                        input.type = "password";
                    }
                }
//                get ve gender
//                var genderSelect = document.getElementById('gender');
//                var selectedGender = '${requestScope.gender}'; // Giả sử bạn đã set attribute 'gender' trong servlet
//
//                if (selectedGender) {
//                    for (var i = 0; i < genderSelect.options.length; i++) {
//                        if (genderSelect.options[i].value === selectedGender) {
//                            genderSelect.options[i].selected = true;
//                            break;
//                        }
//                        }
//                    }
//                }
//                );
        </script>
</html>



