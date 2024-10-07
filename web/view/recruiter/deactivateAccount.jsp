<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    </head>
    <body>
        <div class="row">
            <!-- Sidebar Section -->
            <div class="col-md-3">
                <jsp:include page="../common/recruiter/sidebar-recruiter.jsp"></jsp:include>
                </div>

                <!-- Main Content Section -->
                <div class="col-md-9">
                    <!-- Main Content Area -->
                    <div class="container mt-3">
                        <h6 class="mb-3">Deactivate Profile</h6>
                        <div class="change__password">
                            <div class="password__change__form">
                                <h6 class="text-center mb-4">Are you sure you want to deactivate your profile?</h6>
                                <form action="${pageContext.request.contextPath}/authen?action=deactivate-account" method="POST">
                                <!-- Error Handling -->
                                <c:if test="${requestScope.error != null}">
                                    <div class="alert alert-danger text-center">
                                        ${requestScope.error}
                                    </div>
                                </c:if>

                                <!-- Password Input -->
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label">Please Enter Your Login Password</label>
                                    <input type="password" class="form-control" name="currentPassword" id="currentPassword" placeholder="Enter your current password" required onkeydown="preventSpaces(event)">
                                </div>

                                <!-- Warning Message -->
                                <div class="mb-3">
                                    <p class="text-danger">
                                        <strong>Note:</strong> After your account is deactivated, you will temporarily be unable to use it. If you wish to reactivate your account and resume using it, please contact the Admin for assistance.
                                    </p>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-flex justify-content-end gap-3">
                                    <button type="button" class="btn btn-secondary" onclick="window.location.href = '${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp'">Cancel</button>
                                    <button type="submit" class="btn btn-danger">Deactivate Profile</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Main Content Information -->
                    <div class="mt-4">
                        <h2>Main Content Area</h2>
                        <p>Add your main content here. This area is where the recruiter can view information and perform actions.</p>
                    </div>
                </div>
                <!-- Back to Top Button -->
                <button type="button" class="btn btn-primary position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
                    <i class="fas fa-arrow-up"></i>
                </button>

                <!-- Footer -->
                <div class="d-flex justify-content-center mt-3">
                    <p class="copyright">Copyright © 2024 All Rights Reserved by Group 4 - SE1868-NJ</p>
                </div>
            </div>
        </div>



        <!-- Bootstrap JS and Common Scripts -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>
        <script>
            function preventSpaces(event) {
                if (event.key === " ") {
                    event.preventDefault();  // Prevent the space from being entered
                    alert("Passwords cannot contain spaces.");
                }
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
