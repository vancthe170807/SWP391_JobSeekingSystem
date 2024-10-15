<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Posting Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>

            /* Main content layout */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 240px; /* Adjust for sidebar */
                padding-top: 60px; /* Adjust for header */
                box-sizing: border-box;
                background-color: #f5f5f5; /* Light background */
            }

            /* Center and style header section */
            .header-section {
                text-align: center;
                margin-bottom: 20px;
            }

            .header-section h2 {
                color: #007b5e;
                font-weight: bold;
                font-size: 26px;
                display: inline-block;
                margin-top: 80px;
            }

            /* Search bar, Add New Job, and Filter positioning */
            .controls-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 90%; /* Match width of the table */
                margin: 0 auto 20px; /* Center and position above the table */
            }

            /* Add new job button */
            .btn-add-job {
                background-color: #007b5e;
                color: white;
                padding: 10px 20px;
                font-size: 15px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s ease;
            }

            .btn-add-job i {
                margin-right: 5px;
            }

            .btn-add-job:hover {
                background-color: #005f46;
            }

            /* Search bar styling */
            .search-container {
                display: flex;
                justify-content: flex-end;
            }

            .search-box {
                width: 250px;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-right: none;
                border-radius: 5px 0 0 5px;
                font-size: 14px;
                outline: none;
                height: 42px;
            }

            .search-button {
                background-color: #007b5e;
                border: none;
                padding: 8px 15px;
                border-radius: 0 5px 5px 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 42px;
                cursor: pointer;
            }

            .search-button i {
                color: white;
                font-size: 16px;
            }

            /* Filter buttons styling */
            .filter-buttons {
                display: flex;
                gap: 10px;
            }

            .filter-buttons .btn-filter {
                background-color: #f8f9fa;
                border: 1px solid #007b5e;
                color: #007b5e;
                padding: 7px 11px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
            }

            .filter-buttons .btn-filter:hover {
                background-color: #007b5e;
                color: white;
            }

            /* Table styling */
            table {
                width: 90%;
                margin: 0 auto;
                border-collapse: collapse;
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            table thead th {
                background-color: #007b5e;
                color: white;
                padding: 15px;
                text-align: center; /* Center the headers */
                font-size: 16px;
            }

            table tbody td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: center;
                font-size: 14px;
            }

            /* Set specific width for Job Title column */
/*            table th:nth-child(2),
            table td:nth-child(2) {
                width: 200px;  Adjust the width of the Job Title column 
                white-space: nowrap;  Prevent text from wrapping 
                overflow: hidden;  Hide overflow 
                text-overflow: ellipsis;  Show ellipsis if text is too long 
            }*/

            /* Action buttons styling */
            .btn-action {
                margin-right: 20px; /* Increase spacing between action buttons */
                background-color: transparent;
                color: #007b5e;
                font-size: 16px;
                cursor: pointer;
                text-decoration: none;
            }

            .btn-action:last-child {
                margin-right: 0;
            }

            .btn-action:hover {
                color: #005f46;
            }

            .text-danger {
                color: #dc3545;
            }

            .text-danger:hover {
                color: #c82333;
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .pagination button, .pagination span {
                padding: 8px 15px;
                border: none;
                font-size: 16px;
                cursor: pointer;
                border-radius: 5px;
                margin: 0 5px;
            }

            .pagination button {
                background-color: #007bff;
                color: white;
            }

            .pagination button:hover {
                background-color: #0056b3;
            }

            .pagination .page-number.active {
                background-color: #007bff;
                color: white;
            }

            /* Error message styling */
            .error-message {
                color: #f08080;
                padding: 20px;
                border-radius: 5px;
                text-align: center;
                margin-top: 20px;
                font-weight: bold;
            }
            /*css cho phân trang*/
            .pagination .page-item.active .page-link {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .pagination .page-link {
                color: #007bff;
            }

            .pagination .page-link:hover {
                background-color: #e9ecef;
                color: #0056b3;
            }

        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content for Job Posting Management -->
        <div class="job-posting-container">
            <!-- Centered Header section -->
            <div class="header-section">
                <h2>Job Posting Management</h2>
            </div>

            <!-- Search bar, Add New Job, and Filters -->
            <div class="controls-container">
                <!-- Add New Job Button -->
                <a href="${pageContext.request.contextPath}/view/recruiter/addJobPosting.jsp" class="btn-add-job">
                    <i class="fas fa-plus"></i> Add New Job
                </a>

                <!-- Filter Buttons -->
                <div class="filter-buttons">
                    <a href="${pageContext.request.contextPath}/jobPost?sort=title&page=1&searchJP=${searchJP}" class="btn-filter">Filter by Title A-Z</a>
                    <a href="${pageContext.request.contextPath}/jobPost?sort=postedDate&page=1&searchJP=${searchJP}" class="btn-filter">Filter by Post Date</a>
                    <a href="${pageContext.request.contextPath}/jobPost?sort=status&page=1&searchJP=${searchJP}" class="btn-filter">Filter by Status</a>
                </div>
                <!-- Search bar -->
                <form action="${pageContext.request.contextPath}/jobPost" method="get" class="search-container">
                    <input type="text" name="searchJP" class="search-box" placeholder="Search by job title">
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Table for displaying job postings -->
            <table>
                <thead>
                    <tr>
                        <th>ID Job</th>
                        <th>Job Title</th>
                        <th>Date Posted</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="i" items="${listJobPosting}">
                        <tr>
                            <td>${i.getJobPostingID()}</td>
                            <td>${i.getTitle()}</td>
                            <td><fmt:formatDate value="${i.getPostedDate()}" pattern="dd-MM-yyyy"/></td>
                            <td>${i.getStatus()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/detailsJP?action=details&idJP=${i.getJobPostingID()}" class="btn-action"><i class="fas fa-eye"></i></a>
                                <a href="${pageContext.request.contextPath}/updateJP?idJP=${i.getJobPostingID()}" class="btn-action"><i class="fas fa-edit"></i></a>                              
                                <a href="javascript:void(0);" class="btn-action text-danger" 
                                   onclick="confirmDelete('${i.getJobPostingID()}')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Error message if no job postings found -->
            <c:if test="${not empty requestScope.NoJP}">
                <div class="error-message">${requestScope.NoJP}</div>
            </c:if>

            <!-- Pagination controls -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage - 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${i}&sort=${sortField}&searchJP=${searchJP}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobPost?page=${currentPage + 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
        <!-- JavaScript for sorting -->
        <script>
            function sortTitleAZ() {
                // Code to handle sorting by title A-Z
                console.log('Sorting by Title A-Z');
            }

            function sortPostDate() {
                // Code to handle sorting by post date
                console.log('Sorting by Post Date');
            }

            function sortStatus() {
                // Code to handle sorting by status
                console.log('Sorting by Status');
            }
            function confirmDelete(jobId) {
                // Hiển thị hộp thoại xác nhận
                var confirmed = confirm("Are you sure you want to delete this job posting?");

                // Nếu người dùng chọn "OK", tiếp tục xóa
                if (confirmed) {
                    // Chuyển hướng tới URL xóa
                    window.location.href = 'deleteJP?idJP=' + jobId;
                }
                // Nếu người dùng chọn "Cancel", không làm gì cả
            }
        </script>
    </body>
</html>
