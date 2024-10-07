<%-- 
    Document   : adminHome
    Created on : Sep 15, 2024, 4:26:38 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <!--css-->
        <jsp:include page="../common/admin/common-css-admin.jsp"></jsp:include>
            <style>
                .dashboard__right {
                    padding: 20px;
                }

                .seeker-list {
                    display: flex;
                    flex-direction: column; /* Arrange items vertically */
                    gap: 15px; /* Space between seeker items */
                }

                .seeker-item {
                    display: flex;
                    align-items: center; /* Align items in the center */
                    background: #f8f9fa;
                    padding: 10px;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    justify-content: space-between; /* Distribute space between items */
                    width: 100%; /* Make each item take full width */
                }

                .seeker-avatar {
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    margin-right: 15px; /* Space between avatar and name */
                }

                .seeker-name {
                    margin: 0; /* Remove default margin from h6 */
                    font-size: 16px; /* Adjust font size */
                    flex-grow: 1; /* Allow name to take available space */
                }

                .seeker-actions {
                    display: flex;
                    gap: 5px; /* Space between buttons */
                }

                .btn {
                    padding: 5px 8px; /* Adjust button padding */
                    border: none;
                    border-radius: 5px;
                    color: #fff;
                    cursor: pointer;
                }

                .btn-info {
                    background: #17a2b8;
                }

                .btn-danger {
                    background: #dc3545;
                }

                .btn-success {
                    background: #28a745;
                }

                .btn i {
                    margin-right: 5px; /* Space between icon and text */
                }

                /* Style for Inactive text */
                .seeker-status {
                    font-weight: bold;
                }

                /* Style for seeker status */


                .seeker-status.active {
                    color: green; /* You can adjust the color for Active seekers if needed */
                }

                .seeker-status.inactive {
                    color: red; /* Red color for Inactive seekers */
                }
                .filter-dropdown {
                    margin-bottom: 20px;
                }

                .filter-dropdown select {
                    appearance: none;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    background-color: #fff;
                    border: 1px solid #ced4da;
                    border-radius: 4px;
                    padding: 10px 35px 10px 15px;
                    font-size: 16px;
                    color: #495057;
                    cursor: pointer;
                    width: 200px;
                    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23343a40' d='M10.293 3.293L6 7.586 1.707 3.293A1 1 0 00.293 4.707l5 5a1 1 0 001.414 0l5-5a1 1 0 10-1.414-1.414z'/%3E%3C/svg%3E");
                    background-repeat: no-repeat;
                    background-position: right 15px center;
                    background-size: 12px;
                }

                .filter-dropdown select:focus {
                    border-color: #80bdff;
                    outline: 0;
                    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                }

                .filter-dropdown select:hover {
                    border-color: #b8c2cc;
                }

                .filter-dropdown label {
                    font-weight: bold;
                    margin-right: 10px;
                    color: #495057;
                }
                .modal-content {
                    border-radius: 8px;
                    box-shadow: 0 5px 15px rgba(0,0,0,.5);
                }

                .modal-header {
                    background-color: #f8f9fa;
                    border-bottom: 1px solid #dee2e6;
                    border-top-left-radius: 8px;
                    border-top-right-radius: 8px;
                }

                .modal-title {
                    color: #495057;
                    font-weight: bold;
                }

                .modal-body {
                    padding: 20px;
                }

                .modal-footer {
                    border-top: 1px solid #dee2e6;
                    background-color: #f8f9fa;
                }

                .btn-primary {
                    background-color: #007bff;
                    border-color: #007bff;
                }

                .btn-primary:hover {
                    background-color: #0056b3;
                    border-color: #0056b3;
                }
            </style>

        </head>
        <body class="template-dashboard">
            <!-- header area -->
        <jsp:include page="../common/admin/header-admin.jsp"></jsp:include>
            <!-- header area end -->

            <!-- content area -->
            <div class="dashboard__content d-flex">

                <!--Side bar-->
            <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                <!--side bar-end-->

                <!--content-main can fix-->
                <div class="dashboard__right">
                    <div class="dash__content">
                        <!-- sidebar menu -->
                        <div class="sidebar__menu d-md-block d-lg-none">
                            <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                        </div>
                        <!-- sidebar menu end -->
                        <div class="dash__overview">

                            <h6 class="fw-medium mb-30">SEEKER LIST</h6>
                            <!--drop-down filter seeker-->
                            <div class="filter-dropdown">
                                <form action="${pageContext.request.contextPath}/seekers" method="GET">
                                <label for="seeker-filter">Filter Seekers:</label>
                                <select id="seeker-filter" name="filter" onchange="this.form.submit()">
                                    <option value="all" ${param.filter == null || param.filter == 'all' ? 'selected' : ''}>All Seekers</option>
                                    <option value="active" ${param.filter == 'active' ? 'selected' : ''}>Active Seekers</option>
                                    <option value="inactive" ${param.filter == 'inactive' ? 'selected' : ''}>Inactive Seekers</option>
                                </select>
                            </form>
                        </div>
                        <div class="seeker-list">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Avatar</th>
                                        <th>Full Name</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Table rows will go here (populated dynamically) -->
                                    <c:forEach items="${listSeekers}" var="seeker">
                                        <tr>
                                            <!-- Avatar Column -->
                                            <td>
                                                <img src="${seeker.getAvatar()}" alt="Avatar" class="seeker-avatar" style="width: 50px; height: 50px; border-radius: 50%;">
                                            </td>

                                            <!-- Full Name Column -->
                                            <td>${seeker.getFullName()}</td>

                                            <!-- Status Column -->
                                            <td>
                                                <span class="seeker-status ${seeker.isIsActive() ? 'active' : 'inactive'}">
                                                    ${seeker.isIsActive() ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>

                                            <!-- Action Column -->
                                            <td>
                                                <form action="${pageContext.request.contextPath}/seekers?action=view-detail" method="POST">
                                                    <input type="hidden" name="id-seeker" value="${seeker.getId()}">
                                                    <button class="btn btn-info" type="submit">
                                                        <i class="fa fa-eye"></i>
                                                    </button>
                                                </form>

                                                <c:choose>
                                                    <c:when test="${seeker.isIsActive()}">
                                                        <form action="${pageContext.request.contextPath}/seekers?action=deactive" method="POST">
                                                            <input type="hidden" name="id-seeker" value="${seeker.getId()}">
                                                            <button class="btn btn-danger" type="submit">
                                                                <i class="fa fa-ban"></i> 
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/seekers?action=active" method="POST">
                                                            <input type="hidden" name="id-seeker" value="${seeker.getId()}">
                                                            <button class="btn btn-success" type="submit">
                                                                <i class="fa fa-check"></i> 
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>


                            <!-- Add more seekers here -->
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
                <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
                 
           
                </body>
                </html>