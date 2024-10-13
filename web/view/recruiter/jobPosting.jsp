<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Posting</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* General form container styles */
            .job-posting-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - 80px);
                padding: 20px;
                margin-left: 260px; /* Adjust for the sidebar */
                padding-top: 80px; /* Adjust for header */
                background-color: #f8f9fa;
            }

            /* Form card styling */
            .job-posting-card {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                border: 1px solid #ddd;
                max-width: 700px; /* Reduced width for a more focused form */
                width: 100%;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            /* Title styling */
            .job-posting-card h2 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: bold;
                color: #007b5e;
            }

            /* Label and input field styling */
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 14px;
                color: #333;
            }

            .form-control {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                font-size: 14px;
                background-color: #fafafa;
                margin-bottom: 20px;
            }

            /* Two-column layout for form fields */
            .row .col-md-6 {
                padding-right: 10px;
                padding-left: 10px;
            }

            /* Button styling */
            .btn-group {
                display: flex;
                justify-content: flex-start; /* Align buttons on the left */
                gap: 20px; /* Create space between buttons */
                margin-top: 20px;
            }

            .btn-success {
                background-color: #007b5e;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
            }

            /* Checkbox styling */
            .form-check {
                margin-bottom: 20px;
            }

            /* Datepicker icon styling */
            .datepicker-icon {
                position: absolute;
                right: 10px;
                top: 40px;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <!-- Include Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Include Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Job Posting Form -->
        <div class="job-posting-container">
            <div class="job-posting-card">
                <h2>Job Posting</h2>
                <form action="${pageContext.request.contextPath}/jobPosting?action=postJob" method="POST">
                    <!-- Title -->
                    <div class="form-group">
                        <label for="jobTitle">Title</label>
                        <input type="text" id="jobTitle" name="jobTitle" class="form-control" placeholder="Enter job title" required>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="jobDescription">Description</label>
                        <textarea id="jobDescription" name="jobDescription" class="form-control" placeholder="Enter job description" rows="3" required></textarea>
                    </div>

                    <!-- Requirements -->
                    <div class="form-group">
                        <label for="jobRequirements">Requirements</label>
                        <textarea id="jobRequirements" name="jobRequirements" class="form-control" placeholder="Enter job requirements" rows="3" required></textarea>
                    </div>

                    <!-- Two-column row for Location, Salary, Status, Posted Date, and Closing Date -->
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Location -->
                            <div class="form-group">
                                <label for="jobLocation">Location</label>
                                <input type="text" id="jobLocation" name="jobLocation" class="form-control" required placeholder="Enter job location">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Salary -->
                            <div class="form-group">
                                <label for="jobSalary">Salary</label>
                                <input type="number" id="jobSalary" name="jobSalary" class="form-control" required placeholder="Enter job salary">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Status -->
                            <div class="form-group">
                                <label for="jobStatus">Status</label>
                                <select id="jobStatus" name="jobStatus" class="form-control" required>
                                    <option value="Open">Open</option>
                                    <option value="Filled">Filled</option>
                                    <option value="Close">Close</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Posted Date -->
                            <div class="form-group position-relative">
                                <label for="postedDate">Posted Date</label>
                                <input type="date" id="postedDate" name="postedDate" class="form-control" required>
                                <i class="fas fa-calendar-alt datepicker-icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Closing Date -->
                            <div class="form-group position-relative">
                                <label for="closingDate">Closing Date</label>
                                <input type="date" id="closingDate" name="closingDate" class="form-control" required>
                                <i class="fas fa-calendar-alt datepicker-icon"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check">
                        <input type="checkbox" id="jobPathAgreement" name="jobPathAgreement" class="form-check-input" required>
                        <label class="form-check-label" for="jobPathAgreement">I have read and agree to Job Paths Terms of Service</label>
                    </div>

                    <!-- Buttons: Separated Complete and Reset buttons -->
                    <div class="btn-group">
                        <div>
                            <button type="submit" class="btn btn-success">Complete</button>
                        </div>
                        <div>
                            <button type="reset" class="btn btn-secondary">Reset</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

    </body>
</html>
