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
            /* General form container styles */
            .job-posting-container {
                padding: 20px;
                margin-left: 260px; /* Adjust for the sidebar */
                padding-top: 80px; /* Adjust for header */
                min-height: calc(100vh - 120px); /* Adjust height so footer stays at bottom */
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

            /* Search input styling */
            .search-bar input {
                width: 200px; /* Shortened search bar */
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

            /* Icon button styling */
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

            /* Add job button */
            .btn-add-job {
                background-color: #007b5e;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-add-job i {
                margin-right: 5px;
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

            /* Footer at the bottom */
/*            footer {
                background-color: #007b5e;
                color: white;
                text-align: center;
                padding: 10px;
                position: fixed;
                bottom: 0;
                left: 260px;  Adjust for the sidebar 
                width: calc(100% - 260px);  Adjust width to fill the remaining space 
            }

            footer a {
                color: white;
                margin-left: 15px;
            }

            footer a:hover {
                text-decoration: underline;
            }*/
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Job Posting Management -->
        <div class="job-posting-container">
            <!-- Header and search bar section -->
            <div class="header-section">
                <h2>Job Posting Management</h2>
                <div>
                    <input type="text" class="form-control search-bar" placeholder="Search by job title">
                </div>
                <button class="btn-add-job"><i class="fas fa-plus"></i> Add a new job</button>
            </div>

            <!-- Sorting buttons -->
            <div class="mb-3">
                <button class="btn btn-outline-success">Name A-Z</button>
                <button class="btn btn-outline-success">Date Post</button>
                <button class="btn btn-outline-success">Status</button>
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

        <!-- Footer -->
        <footer>
            © 2024 JobPath. All rights reserved.
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </footer>
<%@ include file="../recruiter/footer-re.jsp" %>
        <!-- JavaScript -->
        <script>
            // JavaScript for sorting or other interactive functionality
        </script>
    </body>
</html>
