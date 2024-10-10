<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
            /* Flexbox layout to push footer to bottom */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Main content layout to take remaining space */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 260px; /* Adjust for the sidebar */
                padding-top: 80px; /* Adjust for the header */
                box-sizing: border-box;
            }

            /* Header section */
            .header-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .header-section h2 {
                color: #007b5e;
                font-weight: bold;
            }

            /* Search bar styling */
            .search-bar {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .search-bar input {
                width: 200px;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table thead th {
                background-color: #007b5e;
                color: white;
                padding: 10px;
                text-align: left;
            }

            table tbody td {
                padding: 10px;
                border: 1px solid #ddd;
            }

            /* Icon button styling for actions */
            .btn-action {
                background-color: transparent;
                border: none;
                color: #007b5e;
                font-size: 16px;
                cursor: pointer;
                margin-right: 5px;
            }

            .btn-action:hover {
                color: #005f46;
            }

            /* Styling for the button */
            .btn-add-job {
                background-color: #007b5e;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none; /* Removes underline */
                display: inline-block; /* Makes it behave like a button */
            }

            .btn-add-job i {
                margin-right: 5px;
            }

            .btn-add-job:hover {
                background-color: #005f46;
                text-decoration: none; /* Ensures underline is still removed on hover */
            }
            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .pagination .page-item {
                margin: 0 5px;
            }

            .pagination .page-item a {
                color: #007b5e;
                text-decoration: none;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .pagination .page-item a:hover {
                background-color: #007b5e;
                color: white;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar (unchanged) -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header (unchanged) -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Job Posting Management Main Content -->
        <div class="job-posting-container">
            <!-- Page Title Section -->
            <div class="header-section">
                <h2>Job Posting Management</h2>
                <a href="${pageContext.request.contextPath}/view/recruiter/jobPosting.jsp" class="btn-add-job"><i class="fas fa-plus"></i> Add a new job</a>
            </div>


            <!-- Search Bar Section (Below Header) -->
            <div class="search-bar">
                <input type="text" class="form-control" placeholder="Search by job title">
                <!-- Sorting buttons -->
                <div>
                    <button class="btn btn-outline-success">Name A-Z</button>
                    <button class="btn btn-outline-success">Date Post</button>
                    <button class="btn btn-outline-success">Status</button>
                </div>
            </div>

            <!-- Job posting table -->
            <table>
                <thead>
                    <tr>
                        <th>Job Title</th>
                        <th>Date Posted</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Job 1</td>
                        <td>2024-10-10</td>
                        <td>Open</td>
                        <td>
                            <button class="btn-action"><i class="fas fa-eye"></i></button>
                            <button class="btn-action"><i class="fas fa-edit"></i></button>
                            <button class="btn-action text-danger"><i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>Job 2</td>
                        <td>2024-10-10</td>
                        <td>Open</td>
                        <td>
                            <button class="btn-action"><i class="fas fa-eye"></i></button>
                            <button class="btn-action"><i class="fas fa-edit"></i></button>
                            <button class="btn-action text-danger"><i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>Job 3</td>
                        <td>2024-10-10</td>
                        <td>Open</td>
                        <td>
                            <button class="btn-action"><i class="fas fa-eye"></i></button>
                            <button class="btn-action"><i class="fas fa-edit"></i></button>
                            <button class="btn-action text-danger"><i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>Job 4</td>
                        <td>2024-10-10</td>
                        <td>Close</td>
                        <td>
                            <button class="btn-action"><i class="fas fa-eye"></i></button>
                            <button class="btn-action"><i class="fas fa-edit"></i></button>
                            <button class="btn-action text-danger"><i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="pagination">
                <div class="page-item"><a href="#">← Previous</a></div>
                <div class="page-item"><a href="#">1</a></div>
                <div class="page-item"><a href="#">2</a></div>
                <div class="page-item"><a href="#">3</a></div>
                <div class="page-item"><a href="#">Next →</a></div>
            </div>
        </div>

        <!-- Footer (always at the bottom) -->
        <%@ include file="../recruiter/footer-re.jsp" %>

        <!-- JavaScript -->
        <script>
            // JavaScript for sorting or other interactive functionality
        </script>
    </body>
</html>
