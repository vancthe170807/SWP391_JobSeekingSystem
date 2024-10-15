<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Seeker Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Main content layout */
            .job-seeker-container {
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
                margin-top: 50px;
            }

            /* Search bar and Filter positioning */
            .controls-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 90%; /* Match width of the table */
                margin: 0 auto 20px; /* Center and position above the table */
            }

            /* Add new job seeker button */
            .btn-add-seeker {
                background-color: #007b5e;
                color: white;
                padding: 10px 20px;
                font-size: 15px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s ease;
            }

            .btn-add-seeker i {
                margin-right: 5px;
            }

            .btn-add-seeker:hover {
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

        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content for Job Seeker Management -->
        <div class="job-seeker-container">
            <!-- Centered Header section -->
            <div class="header-section">
                <h2>Job Seeker Management</h2>
            </div>

            <!-- Search bar, Add New Seeker, and Filters -->
            <div class="controls-container">
                <!-- Add New Job Seeker Button -->
                <a href="${pageContext.request.contextPath}/view/recruiter/addJobSeeker.jsp" class="btn-add-seeker">
                    <i class="fas fa-plus"></i> Add New Seeker
                </a>

                <!-- Search bar -->
                <form action="${pageContext.request.contextPath}/jobSeeker" method="get" class="search-container">
                    <input type="text" name="searchJS" class="search-box" placeholder="Search by name or email">
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Table for displaying job seekers -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seeker" items="${listJobSeekers}">
                        <tr>
                            <td>${seeker.getSeekerID()}</td>
                            <td>${seeker.getFullName()}</td>
                            <td>${seeker.getEmail()}</td>
                            <td>${seeker.getPhone()}</td>
                            <td>${seeker.getStatus()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/viewJobSeeker?id=${seeker.getSeekerID()}" class="btn-action"><i class="fas fa-eye"></i></a>
                                <a href="${pageContext.request.contextPath}/editJobSeeker?id=${seeker.getSeekerID()}" class="btn-action"><i class="fas fa-edit"></i></a>                              
                                <a href="javascript:void(0);" class="btn-action text-danger" 
                                   onclick="confirmDelete('${seeker.getSeekerID()}')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <dib><p>Chưa có cái gì KHÓ</p></dib>
            <!-- Pagination controls -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobSeeker?page=${currentPage - 1}&searchJS=${searchJS}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobSeeker?page=${i}&searchJS=${searchJS}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/jobSeeker?page=${currentPage + 1}&searchJS=${searchJS}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>

            <!-- Error message if no job seekers found -->
            <c:if test="${not empty requestScope.noJobSeekers}">
                <div class="error-message">${requestScope.noJobSeekers}</div>
            </c:if>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript for delete confirmation -->
        <script>
            function confirmDelete(seekerId) {
                var confirmed = confirm("Are you sure you want to delete this job seeker?");
                if (confirmed) {
                    window.location.href = 'deleteJobSeeker?id=' + seekerId;
                }
            }
        </script>
    </body>
</html>
