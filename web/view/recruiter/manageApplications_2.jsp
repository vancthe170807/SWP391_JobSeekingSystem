<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Map" %>

<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Applications Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
        <style>
            /* Center the table container and make it full width */
            .container {
                max-width: 90%;
                margin: auto;
            }

            /* Title styling */
            .table-title {
                font-size: 24px;
                font-weight: bold;
                color: #007b5e;
                padding-top:70px;
                text-align: center;
            }

            /* Row and cell styling */
            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Header styling without borders */
            .table thead th {
                background-color: #007b5e;
                color: white;
                text-align: center;
                padding: 15px;
                font-size: 16px;
                border: none; /* Remove border from header */
            }

            .table tbody td {
                padding: 12px;
                text-align: center;
                font-size: 15px;
                color: #333;
                border-top: 1px solid #e0e0e0; /* Retain border for body cells */
                border-left: 1px solid #e0e0e0;
            }

            .table tbody tr td:last-child {
                border-right: 1px solid #e0e0e0;
            }

            /* Alternating row colors */
            .table tbody tr:nth-child(odd) {
                background-color: #f9f9f9;
            }

            /* Hover effect */
            .table tbody tr:hover {
                background-color: #e6f2f1;
            }

            /* Badge styling */
            .badge {
                padding: 8px 12px;
                font-size: 14px;
                border-radius: 12px;
                color: white;
            }

            .badge.bg-warning {
                background-color: #ffc107;
                color: black;
            }
            .badge.bg-success {
                background-color: #28a745;
            }
            .badge.bg-danger {
                background-color: #dc3545;
            }
            .badge.bg-secondary {
                background-color: #6c757d;
            }
            .badge.bg-dark {
                background-color: #343a40;
            }

            /* Action button styling */
            .btn-action {
                margin-right: 8px;
                color: #007b5e;
                font-size: 16px;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .btn-action:hover {
                color: #005f46;
            }

            .btn-success {
                background-color: #28a745;
                color: white;
                padding: 6px 12px;
                font-size: 14px;
                border: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .btn-action i {
                margin-right: 5px;
            }


        </style>
    </head>
    <body>
        <div class="page-container d-flex flex-column min-vh-100">
            <!-- Include Sidebar -->
            <%@ include file="../recruiter/sidebar-re.jsp" %>

            <!-- Include Header -->
            <%@ include file="../recruiter/header-re.jsp" %>

            <!-- Main content for Applications Management -->
            <div class="job-posting-container flex-grow-1">
                <div class="container">
                    <!-- Title Section -->
                    <h2 class="table-title mt-4 mb-4">Application Management</h2>

                    <!-- Row for Back Button, Filter Buttons, and Search Box -->
                    <div class="row align-items-center mb-3">
                        <!-- Back Button -->
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/jobPost" class="btn btn-secondary">Back</a>
                        </div>


                        <!-- Filter Buttons -->
                        <div class="col-auto">
                            <button class="btn btn-outline-primary me-2" onclick="filterByName()">Filter by Name</button>
                            <button class="btn btn-outline-primary" onclick="filterByDate()">Filter by Applied Date</button>
                        </div>

                        <!-- Search Box aligned to the right -->
                        <div class="col ms-auto" style="max-width: 300px;">
                            <div class="input-group">
                                <input type="text" id="searchInput" class="form-control" placeholder="Search by Applicant Name">
                                <button class="btn btn-primary" onclick="searchByName()">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Table Container -->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Applicant Name</th>
                                    <th>Applied Date</th>
                                    <th>Status</th>
                                    <th>Seeker Details</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="application" items="${applications}">
                                    <tr>
                                        <td>${application.jobSeeker.account.firstName} ${application.jobSeeker.account.lastName}</td>
                                        <td>
                                            <fmt:formatDate value="${application.getAppliedDate()}" pattern="dd-MM-yyyy" />
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">
                                                    <span class="badge bg-warning">Pending</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 2}">
                                                    <span class="badge bg-success">Agree</span>
                                                </c:when>
                                                <c:when test="${application.getStatus() == 1}">
                                                    <span class="badge bg-danger">Reject</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewCV&id=${application.getCVID()}" class="btn-action text-primary">
                                                <i class="fas fa-file-pdf"></i>CV
                                            </a>
                                            <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewEducation&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-secondary">
                                                <i class="fas fa-graduation-cap"></i>Education
                                            </a>
                                            <a href="${pageContext.request.contextPath}/applicationSeekers?action=viewWorkExperience&id=${application.jobSeeker.getJobSeekerID()}" class="btn-action text-warning">
                                                <i class="fas fa-briefcase"></i>Work Experience
                                            </a>

                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">
                                                    <button type="button" class="btn btn-success btn-action" data-bs-toggle="modal" data-bs-target="#changeStatusModal" 
                                                            onclick="openModal(${application.getApplicationID()})">
                                                        <i class="fas fa-edit"></i>Confirm
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not yet</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Error message if no applications found -->
                    <c:if test="${empty applications}">
                        <div class="error-message text-center mt-3">No applications found for this job posting.</div>
                    </c:if>
                </div>

                <!-- Change Status Modal -->
                <div class="modal fade" id="changeStatusModal" tabindex="-1" aria-labelledby="changeStatusModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
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
                </div>

            </div>

            <!-- Include Footer -->
            <%@ include file="../recruiter/footer-re.jsp" %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                                function openModal(applicationId) {
                                                                    document.getElementById("applicationId").value = applicationId;
                                                                }
        </script>
    </body>
</html>
