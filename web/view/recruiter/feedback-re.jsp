<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Reuse the same styles from Job Posting Management */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 240px;
                padding-top: 60px;
                box-sizing: border-box;
                background-color: #f5f5f5;
            }

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

            /* Search bar, Add Feedback, and Filter positioning */
            .controls-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 90%;
                margin: 0 auto 20px;
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
                text-align: center;
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
                margin-right: 20px;
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

        <!-- Main content for Feedback Management -->
        <div class="job-posting-container">
            <!-- Centered Header section -->
            <div class="header-section">
                <h2>Feedback Management</h2>
            </div>

            <!-- Search bar for Feedback -->
            <div class="controls-container">
                <!-- Search bar -->
                <form action="${pageContext.request.contextPath}/Feedback_re" method="get" class="search-container">
                    <input type="text" name="searchFB" class="search-box" placeholder="Search by feedback content">
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>

            <!-- Table for displaying feedback -->
            <table>
                <thead>
                    <tr>
                        <th>Feedback ID</th>
                        <th>Content</th>
                        <th>Create At</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbackList}">
                        <tr>
                            <td>${feedback.feedbackID}</td>
                            <td>${feedback.content}</td>
                            <td><fmt:formatDate value="${feedback.createAt}" pattern="dd-MM-yyyy" /></td>
                            <td>${feedback.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Error message if no feedback found -->
            <c:if test="${not empty requestScope.NoFB}">
                <div class="error-message">${requestScope.NoFB}</div>
            </c:if>

            <!-- Pagination controls -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/Feedback_re?page=${currentPage - 1}&searchFB=${searchFB}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/Feedback_re?page=${i}&searchFB=${searchFB}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/Feedback_re?page=${currentPage + 1}&searchFB=${searchFB}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript for confirmation dialog -->
        <script>
            function confirmDelete(feedbackId) {
                var confirmed = confirm("Are you sure you want to delete this feedback?");
                if (confirmed) {
                    window.location.href = 'deleteFeedback?idFB=' + feedbackId;
                }
            }
        </script>
    </body>
</html>
