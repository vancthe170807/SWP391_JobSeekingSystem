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
            .recruiter-status.active {
                color: green; /* Active recruiters in green */
                font-weight: bold;
            }
            .recruiter-status.inactive {
                color: red; /* Inactive recruiters in red */
                font-weight: bold;
            }
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
                    <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                        <div class="dash__content">
                            <!-- sidebar menu -->
                            <div class="sidebar__menu d-md-block d-lg-none">
                                <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                            </div>
                            <!-- sidebar menu end -->
                            <div class="dash__overview">
                                <h6 class="fw-medium mb-30 text-center fs-2">RECRUITER MANAGEMENT</h6>
                                
                                <!--drop-down filter recruiter-->
                                <div class="filter-dropdown">
                                    <form action="${pageContext.request.contextPath}/recruiters" method="GET">
                                        <label for="recruiter-filter">Filter</label>
                                        <select id="recruiter-filter" name="filter" onchange="this.form.submit()">
                                            <option value="all" ${param.filter == null || param.filter == 'all' ? 'selected' : ''}>All Recruiters</option>
                                            <option value="active" ${param.filter == 'active' ? 'selected' : ''}>Active Recruiters</option>
                                            <option value="inactive" ${param.filter == 'inactive' ? 'selected' : ''}>Inactive Recruiters</option>
                                        </select>
                                    </form>
                                </div>
                                
                                <div class="recruiter-list">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Avatar</th>
                                                <th>Full Name</th>
                                                <th>Status</th>
                                                <th>View</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Table rows will go here (populated dynamically) -->
                                            <c:forEach items="${listRecruiters}" var="recruiter">
                                                <tr>
                                                    <!-- Avatar Column -->
                                                    <td>
                                                        <img src="${recruiter.getAvatar()}" alt="Avatar" class="recruiter-avatar" style="width: 50px; height: 50px; border-radius: 50%;">
                                                    </td>

                                                    <!-- Full Name Column -->
                                                    <td>${recruiter.getFullName()}</td>

                                                    <!-- Status Column -->
                                                    <td>
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheck${recruiter.id}" ${recruiter.isActive ? 'checked' : ''} data-recruiter-id="${recruiter.id}">
                                                            <label class="form-check-label" for="flexSwitchCheck${recruiter.id}"></label>
                                                        </div>
                                                    </td>
                                                    
                                                    <!-- Action Column -->
                                                    <td>
                                                        <form action="recruiters?action=view-detail" method="POST">
                                                            <input type="hidden" name="id-recruiter" value="${recruiter.getId()}">
                                                            <button class="btn btn-info" type="submit">
                                                                <i class="fa fa-eye"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${pageControl.getTotalPages()}" var="pageNumber">
                                                <li>
                                                    <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageNumber}">${pageNumber}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </nav>
                                    <!-- Add more recruiters here -->
                                </div>
                            </div>
                        </div>
                    </div>
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
                $('.form-check-input').change(function () {
                    var recruiterId = $(this).data('recruiter-id');
                    var isActive = this.checked;
                    
                    $.ajax({
                        url: '${pageContext.request.contextPath}/recruiters',
                        type: 'POST',
                        data: {
                            action: isActive ? 'active' : 'deactive',
                            'id-recruiter': recruiterId
                        },
                        success: function (response) {
                            console.log('Recruiter status updated successfully');
                        },
                        error: function (xhr, status, error) {
                            console.error('Error updating recruiter status');
                            $(this).prop('checked', !isActive);
                        }
                    });
                });
            });
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
