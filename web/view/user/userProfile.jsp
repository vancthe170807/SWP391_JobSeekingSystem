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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        </head>
        <body class="template-dashboard">
            <!-- header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- header area end -->

            <div class="container mt-5 mb-5">
                <div class="row">
                    <!-- Sidebar Section -->
                    <div class="col-md-3 sidebar p-3">
                        <h5 class="text-center text-white">User Menu</h5>
                        <ul class="nav nav-tabs flex-column" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="true">Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="cv-tab" data-bs-toggle="tab" href="#cv" role="tab" aria-controls="cv" aria-selected="false">Upload / Update CV</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="education-tab" data-bs-toggle="tab" href="#education" role="tab" aria-controls="education" aria-selected="false">Education</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="skill-experience-tab" data-bs-toggle="tab" href="#skill-experience" role="tab" aria-controls="skill-experience" aria-selected="false">Skill & Experience</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="deactivate-account-tab" data-bs-toggle="tab" href="#deactivate-account" role="tab" aria-controls="deactivate-account" aria-selected="false">Deactivate Account</a>
                            </li>
                        </ul>
                    </div>

                    <!-- Main Content Section -->
                    <div class="col-md-9">
                        <c:set var="isJobSeeker" value="${not empty jobSeekerInfo}" />
                        <div class="tab-content">
                            <!-- Profile Tab -->
                            <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <h4 class="mb-3">Profile Information</h4>
                                <form class="p-4 rounded shadow-sm bg-light">
                                    <div class="author__image mb-3 text-center">
                                    <c:if test="${empty sessionScope.account.avatar}">
                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="rounded-circle" width="150" height="150">
                                    </c:if>
                                    <c:if test="${!empty sessionScope.account.avatar}">
                                        <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle" width="150" height="150">
                                    </c:if>
                                </div>
                                <c:if test="${isJobSeeker}">
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Job Seeker ID</label>
                                        <input type="text" id="jobseekerid" class="form-control" placeholder="Full Name" required readonly value="${jobSeekerInfo.jobSeekerID}">
                                    </div>
                                </c:if>
                                    
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <input type="text" id="name" class="form-control" placeholder="Full Name" required readonly value="${sessionScope.account.fullName}">
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" id="email" class="form-control" placeholder="jobpath@gmail.com" required readonly value="${sessionScope.account.email}">
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="text" id="phone" class="form-control" placeholder="+84" required readonly value="${sessionScope.account.phone}">
                                </div>
                                <div class="mb-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <input type="date" id="dob" class="form-control" required readonly value="${sessionScope.account.dob}">
                                </div>
                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <input type="text" id="genderDisplay" class="form-control" value="${sessionScope.account.gender == true ? 'Male' : 'Female'}" readonly>
                                    <input type="hidden" name="gender" id="genderHidden">
                                </div>
                                <div class="mb-3">
                                    <label for="add" class="form-label">Address</label>
                                    <input type="text" id="add" class="form-control" placeholder="Your Address" required readonly value="${sessionScope.account.address}">
                                </div>
                                <button type="button" class="btn btn-info" id="editProfile" onclick="location.href = '${pageContext.request.contextPath}/authen?action=edit-profile'">Edit Profile</button>
                            </form>
                        </div>

                        <!--                                CV Tab-->
                        <div class="tab-pane fade" id="cv" role="tabpanel" aria-labelledby="cv-tab">
                            <h5 class="mb-3">Upload/Update CV (PDF format)</h5>
                            <form action="${pageContext.request.contextPath}/uploadCV" method="POST" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label for="cvFile" class="form-label">Select your CV (PDF only):</label>
                                    <input type="file" class="form-control" id="cvFile" name="cvFile" accept=".pdf" required>
                                    <small class="form-text text-muted">Only PDF files are allowed (Max size: 5MB).</small>
                                </div>
                                <button type="submit" class="btn btn-success">Upload/Update CV</button>
                            </form>
                        </div>
                        <!-- Education-->
                        <div class="tab-pane fade" id="education" role="tabpanel" aria-labelledby="education-tab">


                        </div>

                        <!-- Education-->
                        <div class="tab-pane fade" id="skill-experience" role="tabpanel" aria-labelledby="skill-experience-tab">


                        </div>

                        <!-- Deactivate Account Tab -->
                        <div class="tab-pane fade" id="deactivate-account" role="tabpanel" aria-labelledby="deactivate-account-tab">
                            <h6>Deactivate Your Account</h6>
                            <p>Are you sure you want to deactivate your account?</p>
                            <c:if test="${requestScope.error != null}">
                                <div style="color: red; text-align: center;">
                                    ${requestScope.error}
                                </div>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/authen?action=deactivate-account" method="POST">
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label">Please Enter Your Login Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="Enter your password" value="${cookie.cp.value}" required onkeydown="preventSpaces(event)">
                                        <span class="input-group-text cursor-pointer" onclick="togglePassword('currentPassword')">
                                            👁️
                                        </span>
                                    </div>
                                </div>
                                <p class="text-danger">
                                    <strong>Note:</strong> After your account is deactivated, you will temporarily be unable to use it. If you wish to reactivate your account, please contact the Admin for assistance.
                                </p>
                                <button type="button" class="btn btn-primary">Cancel</button>
                                <button type="submit" class="btn btn-danger">Deactivate Account</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-primary position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>
            <!-- all plugin js -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>
