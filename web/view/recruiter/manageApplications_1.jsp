<%-- 
    Document   : manageApplications
    Created on : Nov 1, 2024, 8:34:29 AM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Applications Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
        <style>
            /* Main layout using flexbox */
            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh; /* Ensure the container takes full height */
            }

            /* Main content layout */
            .job-posting-container {
                flex: 1; /* Allows this section to expand */
                padding: 20px;
                margin-left: 240px; /* Adjust for sidebar */
                padding-top: 60px; /* Adjust for header */
                background-color: #f5f5f5; /* Light background */
                display: flex;
                flex-direction: column; /* Ensure content is stacked vertically */
            }

            /* Ensure table takes available space */
            .table-wrapper {
                flex: 1; /* Table section will expand to take up available space */
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
                padding-bottom: 20px;
            }

            .pagination button,
            .pagination span {
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
        <div class="page-container">
            <!-- Include Sidebar -->
            <%@ include file="../recruiter/sidebar-re.jsp" %>

            <!-- Include Header -->
            <%@ include file="../recruiter/header-re.jsp" %>

            <!-- Main content for Applications Management -->
            <div class="job-posting-container">
                <div class="header-section">
                    <h2>Applications Management</h2>
                    <c:if test="${param.success == 'true'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Success!</strong> The application status was updated successfully and the email was sent.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'updateFailed'}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error!</strong> Failed to update the application status. Please try again.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'emailFailed'}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Error!</strong> The status was updated, but the email failed to send.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                </div>

                <!-- Table for displaying applications -->
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Applicant Name</th>
                                <th>Applied Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="application" items="${applications}">
                                <tr>
                                    <td>${application.jobSeeker.account.firstName} ${application.jobSeeker.account.lastName}</td>
                                    <td>${application.getAppliedDate()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${application.getStatus() == 3}">
                                                <span class="status pending">Pending</span>
                                            </c:when>
                                            <c:when test="${application.getStatus() == 2}">
                                                <span class="status agree">Agree</span>
                                            </c:when>
                                            <c:when test="${application.getStatus() == 1}">
                                                <span class="status reject">Reject</span>
                                            </c:when>
                                            <c:when test="${application.getStatus() == 0}">
                                                <span class="status cancel">Cancel</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status unknown">Unknown</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewProfile&id=${application.jobSeeker.getAccount().getId()}" class="btn-action text-info">
                                            <i class="fas fa-user"></i> View Profile
                                        </a>
                                        <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewCV&id=${application.getCVID()}" class="btn-action text-primary">
                                            <i class="fas fa-file-pdf"></i> View CV
                                        </a>
                                        <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewEducation&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-secondary">
                                            <i class="fas fa-graduation-cap"></i> View Education
                                        </a>
                                        <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewWorkExperience&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-warning">
                                            <i class="fas fa-briefcase"></i> View Work Experience
                                        </a>
                                        <c:if test="${application.getStatus() == 3}">
                                            <button type="button" class="btn btn-success btn-action" data-bs-toggle="modal" data-bs-target="#changeStatusModal" 
                                                    onclick="openModal(${application.getApplicationID()})">
                                                <i class="fas fa-edit"></i> Change
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>


                <!-- Error message if no applications found -->
                <c:if test="${empty applications}">
                    <div class="error-message">No applications found for this job posting.</div>
                </c:if>
                <div class="modal fade" id="changeStatusModal" tabindex="-1" aria-labelledby="changeStatusModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="changeStatusModalLabel">Change Application Status</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="changeStatusForm" action="${pageContext.request.contextPath}/applicationSeekers" method="post">
                                    <input type="hidden" name="applicationId" id="applicationId" value="">

                                    <div class="mb-3">
                                        <label for="status" class="form-label">Select New Status:</label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="2">Agree</option>
                                            <option value="1">Reject</option>
                                            <option value="0">Cancel</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="emailContent" class="form-label">Email Content:</label>
                                        <textarea class="form-control" id="emailContent" name="emailContent" rows="4" placeholder="Enter your message here..." required></textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination controls (if needed) -->
                    <nav aria-label="Page navigation" class="footer-container">
                        <ul class="pagination justify-content-center">
                            <!-- Implement pagination similar to job postings if necessary -->
                        </ul>
                    </nav>
                </div>
                <script>
                    function openModal(applicationId) {
                        document.getElementById("applicationId").value = applicationId;
                    }
                </script>
                <!-- Include Footer -->
                <%@ include file="../recruiter/footer-re.jsp" %>
            </div>
    </body>
</html>
