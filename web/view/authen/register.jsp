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

            <div class="" id="signupModal" style="margin-top: 100px">
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
                                    <button class="rts__btn nav-link  active"><i class="fa-light fa-user"></i>Seeker</button>
                                    <button class="rts__btn nav-link"><i class="rt-briefcase"></i>Recruiter</button>
                                </div>
                                <form action="${pageContext.request.contextPath}/authen?action=sign-up" method="POST" class="d-flex flex-column gap-3">
                                <input type="hidden" name="role" value=""/>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">Last Name</label>
                                    <div class="position-relative">
                                        <input type="text" name="lastname" id="sname" placeholder="Enter last name" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">First name</label>
                                    <div class="position-relative">
                                        <input type="text" name="firstname" id="sname" placeholder="Enter first name" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select name="gender" id="gender" class="form-select" >
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="sname" class="fw-medium text-dark mb-3">User name</label>
                                    <div class="position-relative">
                                        <input type="text" name="username" id="sname" placeholder="Enter user name" required>
                                        <i class="fa-light fa-user icon"></i>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="signemail" class="fw-medium text-dark mb-3">Your Email</label>
                                    <div class="position-relative">
                                        <input type="email" name="email" id="signemail" placeholder="Enter your email" required>
                                        <i class="fa-sharp fa-light fa-envelope icon"></i>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="spassword" class="fw-medium text-dark mb-3">Password</label>
                                    <div class="position-relative">
                                        <input type="password" name="password" id="spassword" placeholder="Enter your password" required>
                                        <i class="fa-light fa-lock icon"></i>
                                    </div>
                                </div>
                                <span style="color:red">${error}</span>
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
        </script>
</html>



