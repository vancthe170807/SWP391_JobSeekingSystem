<%-- 
    Document   : recruiterManagement
    Created on : Sep 15, 2024, 4:26:38 PM
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

        <!-- Add custom styles -->
        <style>

        </style>
    </head>
    <body>
        <!-- header area -->
        <jsp:include page="../common/admin/header-admin.jsp"></jsp:include>
            <!-- header area end -->

            <!-- content area -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <!--Side bar-->
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                        <!--side bar-end-->
                    </div>

                    <div class="col-md-9">
                        <!--content-main can fix-->
                        <div class="container mt-4">
                            <h2 class="mb-4">Create New Admin</h2>
                            <div class="card">
                                <div class="card-body">
                                    <div class="text-center mb-4">
                                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Admin avatar" class="rounded-circle" style="width: 150px; height: 150px;">
                                </div>
                                <form action="${pageContext.request.contextPath}/admin?action=create" method="post">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="lastname" class="form-label">Last Name</label>
                                            <input type="text" class="form-control" id="lastname" name="lastname" value="${requestScope.lname}" required>
                                            <div class="text-danger mt-1" id="lastname-error">${requestScope.errorLname}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="firstname" class="form-label">First Name</label>
                                            <input type="text" class="form-control" id="firstname" name="firstname" value="${requestScope.fname}" required>
                                            <div class="text-danger mt-1" id="lastname-error">${requestScope.errorFname}</div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" value="${requestScope.phone}" required>
                                        <div class="text-danger mt-1" id="lastname-error">${requestScope.errorPhone}</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" name="username" value="${requestScope.username}" required>
                                        <div class="text-danger mt-1" id="lastname-error">${requestScope.errorUsername}</div>
                                        <div class="text-danger mt-1" id="lastname-error">${requestScope.errorDuplicateUsername}</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" value="${requestScope.password}" required>
                                        <div class="text-danger mt-1" id="lastname-error">${requestScope.errorPassword}</div>
                                    </div>
                                    <div class="d-flex justify-content-center gap-3 mt-4">
                                        <button type="submit" class="btn btn-success">Create</button>
                                        <div class="text-secondary mt-1" id="lastname-error">${requestScope.success}</div>
                                    </div>
                                </form>
                                <form id="adminListForm" action="${pageContext.request.contextPath}/admin?action=view-list" method="post">
                                    <button type="submit" class="btn btn-success">List Admin</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!--modal hien thi danh sach admin-->
                    <div class="modal fade" id="adminListModal" tabindex="-1" aria-labelledby="adminListModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="adminListModalLabel">Admin List</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <!-- Bảng hiển thị thông tin admin -->
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Full Name</th>
                                                <th scope="col">Phone</th>
                                                <th scope="col">Username</th>
                                                <th scope="col">Action</th> <!-- Cột cho nút Delete -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Giả sử các admin được truyền vào qua requestScope -->
                                            <c:forEach items="${requestScope.listAdmin}" var="admin">
                                                <c:if test="${admin.isIsActive() == true}">
                                                <tr>
                                                    <td>${admin.getFullName()}</td>
                                                    <td>${admin.getPhone()}</td>
                                                    <td>${admin.getUsername()}</td>
                                                    <td>
                                                        <!-- Nút Delete và input hidden để chứa ID của admin -->
                                                        <form action="${pageContext.request.contextPath}/admin?action=delete" method="post">
                                                            <input type="hidden" name="id" value="${admin.getId()}" /> <!-- Ẩn id admin -->
                                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this admin?')">Delete</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>              
                    <!--modal end-->

                    <!-- content area end -->

                    <!-- Back to Top Button -->
                    <button type="button" class="btn btn-primary position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
                        <i class="fas fa-arrow-up"></i>
                    </button>
                </div>
            </div>
        </div>

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
                    <a href="#" class="small__btn d-xl-flex fill__btn border-6 font-xs" aria-label="Job Posting Button">Add Job</a>
                </div>
            </div>
            <div class="offcanvas-body p-0">
                <div class="rts__offcanvas__menu overflow-hidden">
                    <div class="offcanvas__menu"></div>
                </div>
                <p class="max-auto font-20 fw-medium text-center text-decoration-underline mt-4">Our Social Links</p>
                <div class="rts__social d-flex justify-content-center gap-3 mt-3">
                    <a href="https://facebook.com" aria-label="facebook">
                        <i class="fa-brands fa-facebook"></i>
                    </a>
                    <a href="https://instagram.com" aria-label="instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="https://linkedin.com" aria-label="linkedin">
                        <i class="fa-brands fa-linkedin"></i>
                    </a>
                    <a href="https://pinterest.com" aria-label="pinterest">
                        <i class="fa-brands fa-pinterest"></i>
                    </a>
                    <a href="https://youtube.com" aria-label="youtube">
                        <i class="fa-brands fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Theme Preloader Start -->
        <div class="loader-wrapper">
            <div class="loader"></div>
            <div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>
        </div>
        <!-- Theme Preloader End -->

        <!-- Back to Top Button -->
        <button type="button" class="rts__back__top" id="rts-back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>

        <!-- Include common JavaScript files -->
        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>

            <!-- Custom script for recruiter status switcher -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                                                $(document).ready(function () {
                                                    // Kiểm tra nếu adminList có tồn tại thì mở modal
                                                    var hasAdminList = ${not empty listAdmin ? 'true' : 'false'};
                                                    if (hasAdminList) {
                                                        $('#adminListModal').modal('show');
                                                    }
                                                });
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
</html>
