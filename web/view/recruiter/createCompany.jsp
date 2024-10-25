<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Company</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Custom CSS -->
        <style>
            /* Tùy chỉnh cho main content */
            .main-content {
                padding: 20px;
                margin-left: 250px; /* Nếu bạn có sidebar cố định */
                background-color: #f8f9fa; /* Màu nền nhạt */
            }

            /* Card layout */
            .card {
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                background-color: white;
            }

            .card-header {
                background-color: #28a745;
                color: white;
                border-radius: 10px 10px 0 0;
                padding: 10px;
                font-size: 18px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            .card-header i {
                margin-right: 10px;
            }

            .card-body {
                padding: 20px;
            }

            /* Tùy chỉnh thêm */
            .form-label {
                font-weight: bold;
            }

            .form-control, .form-select {
                border-radius: 5px;
            }

            /* Footer của form */
            .form-footer {
                display: flex;
                justify-content: flex-start;
                margin-top: 20px;
            }
            /* Điều chỉnh font-size của thông báo lỗi */
            .invalid-feedback {
                font-size: 14px;
            }

            /* Thêm màu nền nhạt đỏ cho trường nhập khi có lỗi */
            .is-invalid {
                border-color: #dc3545; /* Màu đỏ */
                background-color: #f8d7da; /* Nền nhạt đỏ */
            }

        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header with Bootstrap Navbar -->
            <%@ include file="../recruiter/header-re.jsp" %>

            <!-- Kiểm tra và hiển thị thông báo -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                    <!-- Đường link để gửi request về servlet -->
                    <a href="${pageContext.request.contextPath}/company?action=edit">
                        Edit 
                    </a>
                </div>
            </c:if>
            <c:if test="${not empty notice}">
                <div class="alert alert-success" role="alert">
                    ${notice}
                </div>
            </c:if>

            <!-- Kiểm tra nếu không có lỗi thì hiển thị form -->

            <!-- Card chứa form -->
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-building"></i> Fill Your Company Information
                </div>
                <div class="card-body">
                    <!--form add company-->
                    <form id="addCompanyForm" action="${pageContext.request.contextPath}/company?action=create" method="POST" enctype="multipart/form-data">
                        <!-- Hàng đầu tiên với 2 trường nhập -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="companyName" class="form-label">Company Name</label>
                                <input type="text" class="form-control" id="companyName" name="name" value="${requestScope.company.getName()}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="companyLocation" class="form-label">Location</label>
                                <input type="text" class="form-control" id="companyLocation" name="location" value="${requestScope.company.getLocation()}"required>
                            </div>
                        </div>

                        <!-- Hàng thứ hai với 2 trường nhập -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="companyDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="companyDescription" name="description" rows="3" required>${requestScope.company.getDescription()}</textarea>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="businessCode" class="form-label">Business Code</label>

                                <!-- Trường nhập có thể thêm class 'is-invalid' khi có lỗi -->
                                <input type="text" 
                                       class="form-control <c:if test='${not empty errorCode or not empty duplicateCode}'>is-invalid</c:if>" 
                                           id="businessCode" name="businessCode" 
                                           value="${requestScope.company.getBusinessCode()}" required>

                                <!-- Hiển thị thông báo lỗi dưới trường nhập -->
                                <c:if test="${not empty errorCode}">
                                    <div class="invalid-feedback">
                                        ${errorCode}
                                    </div>
                                </c:if>
                                <c:if test="${not empty duplicateCode}">
                                    <div class="invalid-feedback">
                                        ${duplicateCode}
                                    </div>
                                </c:if>
                            </div>

                        </div>

                        <!-- Trường cuối cùng chiếm nguyên một hàng -->
                        <div class="mb-3">
                            <label for="businessLicense" class="form-label">Business License</label>
                            <input type="file" class="form-control" id="businessLicense" name="businessLicense" accept="image/*" required>
                        </div>

                        <!-- Footer form -->
                        <div class="form-footer">
                            <button type="submit" class="btn btn-success">Create</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
