<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.JobPostings"%>
<%@page import="java.util.List"%>
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
                    <h2 class="table-title mt-4 mb-4">${jobPostingTitle}</h2>

                    <!-- Row for Back Button, Filter Buttons, and Search Box -->
                    <div class="row align-items-center mb-3">
                        <!-- Back Button -->
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/jobPost" class="btn btn-secondary">Back</a>
                        </div>

                        <!-- Filter Buttons -->
                        <div class="col-auto">
                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="text" name="searchName" value="${searchName}" placeholder="Search by Applicant Name" class="form-control d-inline-block" style="width: 200px;">
                                <button type="submit" class="btn btn-outline-primary">Search</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <select name="statusFilter" class="form-control d-inline-block" style="width: 150px;">
                                    <option value="">All Status</option>
                                    <option value="3" ${statusFilter == '3' ? 'selected' : ''}>Pending</option>
                                    <option value="2" ${statusFilter == '2' ? 'selected' : ''}>Agree</option>
                                    <option value="1" ${statusFilter == '1' ? 'selected' : ''}>Reject</option>
                                    <option value="0" ${statusFilter == '0' ? 'selected' : ''}>Cancel</option>
                                </select>
                                <button type="submit" class="btn btn-outline-primary">Filter by Status</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applicationSeekers" method="get" class="d-inline">
                                <input type="hidden" name="jobPostId" value="${param.jobPostId}" />
                                <input type="date" name="dateFilter" value="${dateFilter}" class="form-control d-inline-block" style="width: 200px;">
                                <button type="submit" class="btn btn-outline-primary">Filter by Applied Date</button>
                            </form>
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
                                                <c:when test="${application.getStatus() == 0}">
                                                    <span class="badge bg-danger">Cancel</span>
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

                                        <%

                                            String jobPostingStatus = (String) request.getAttribute("jobPostingStatus");
                                            boolean isViolate = "Violate".equals(jobPostingStatus);
                                        %>

                                        <td>
                                            <c:choose>
                                                <c:when test="${application.getStatus() == 3}">

                                                    <button type="button" class="btn btn-success btn-action <%= isViolate ? "text-danger" : "" %>" 
                                                            data-bs-toggle="modal" data-bs-target="#changeStatusModal" 
                                                            onclick="openModal(${application.getApplicationID()})" 
                                                            <%= isViolate ? "disabled" : "" %>>
                                                        <i class="fas fa-edit"></i> Confirm
                                                    </button>

                                                    <% if (isViolate) { %>

                                                    <span class="text-danger"> (Not allowed)</span>
                                                    <% } %>
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

                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage - 1}">Previous</a></li>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                    <a class="page-link" href="?jobPostId=${param.jobPostId}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item"><a class="page-link" href="?jobPostId=${param.jobPostId}&page=${currentPage + 1}">Next</a></li>
                                </c:if>
                        </ul>
                    </nav>

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
                                    <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button> <!-- Nút reset -->
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
        <!-- TinyMCE và mã JavaScript cho nút Reset -->
        <script src="https://cdn.tiny.cloud/1/ygxzbqd4ej8z1yjswkp0ljn56qm4r6luix9l83auaajk3h3q/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
                                        // Khởi tạo TinyMCE cho textarea với id là 'emailContent'
                                        tinymce.init({
                                            selector: 'textarea',
                                            plugins: 'advlist autolink lists link image charmap print preview anchor',
                                            toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                                            branding: false,
                                            height: 300,
                                            setup: function (editor) {
                                                editor.on('change', function () {
                                                    tinymce.triggerSave();
                                                });
                                            }
                                        });

                                        // Hàm reset để xóa nội dung trong TinyMCE
                                        function resetForm() {
                                            // Reset nội dung của TinyMCE editor
                                            tinymce.get('emailContent').setContent('');

                                            // Reset các trường khác trong form nếu cần
                                            document.getElementById('status').selectedIndex = 0; // Đặt lại giá trị đầu tiên của dropdown
                                            document.getElementById('changeStatusForm').reset(); // Reset form nếu cần
                                        }
        </script>
    </body>
</html>
