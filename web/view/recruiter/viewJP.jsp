<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Job Posting</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Main content layout */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 260px; /* Adjust for sidebar */
                margin-top: 80px; /* Adjust for header */
                box-sizing: border-box;
                background-color: #f5f5f5; /* Light background */
                min-height: calc(100vh - 140px); /* Ensure container takes full height minus header and footer */
            }

            .job-posting-content {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .job-posting-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .job-posting-header h2 {
                color: #007b5e;
                font-weight: bold;
            }

            .job-detail {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .job-detail div {
                width: 48%;
            }

            .job-detail h5 {
                color: #007b5e;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .job-detail p {
                margin-bottom: 10px;
                color: #333;
            }

            /* Buttons */
            .btn-apply {
                background-color: #007b5e;
                color: white;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }

            .btn-apply:hover {
                background-color: #005f46;
            }

            /* Footer */
            footer {
                background-color: #389354;
                color: white;
                text-align: center;
                padding: 20px 0;
                width: calc(100% - 260px); /* Adjusting for sidebar width */
                margin-left: 260px;
                position: relative;
                bottom: 0;
            }

            footer a {
                color: white;
                text-decoration: none;
                margin: 0 15px;
            }

            footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content for Viewing Job Posting -->
        <div class="job-posting-container">
            <!-- Job Posting Details -->
            <div class="job-posting-content">
                <div class="job-posting-header">
                    <h2>${jobPost.getTitle()}</h2>
                </div>
                <div class="job-detail">
                    <div>
                        <h5>Description:</h5>
                        <p>${jobPost.getDescription()}</p>
                    </div>
                    <div>
                        <h5>Status:</h5>
                        <p>${jobPost.getStatus()}</p>

                    </div>
                </div>
                <div class="job-detail">
                    <div>
                        <h5>Date Posted:</h5>
                        <p><fmt:formatDate value="${jobPost.getPostedDate()}" pattern="dd-MM-yyyy"/></p>
                    </div>
                    <div>
                        <h5>Closing Date:</h5>
                        <p><fmt:formatDate value="${jobPost.getClosingDate()}" pattern="dd-MM-yyyy"/></p>
                    </div>
                </div>
                <div class="job-detail">
                    <div>
                        <h5>Requirements:</h5>
                        <p>${jobPost.getRequirements()}</p>
                    </div>
                    <div>
                        <h5>Location:</h5>
                        <p>${jobPost.getLocation()}</p>
                    </div>
                </div>
                <!--                <div class="job-detail">
                                    <div>
                                        <h5>Salary $:</h5>
                                        <p>${jobPost.getSalary()}</p>
                                    </div>
                                </div>-->
                <div class="job-detail">
                    <div>
                        <h5>Salary $:</h5>
                        <p>
                            <fmt:formatNumber value="${jobPost.getSalary()}" type="number" groupingUsed="true"/>
                        </p>
                    </div>
                </div>
                <a href="javascript:window.history.back();" class="btn-apply">Back</a>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>
