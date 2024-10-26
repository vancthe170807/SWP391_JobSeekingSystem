<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Job Posting</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/ygxzbqd4ej8z1yjswkp0ljn56qm4r6luix9l83auaajk3h3q/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>

        <style>
            /* General form container styles */
            .job-posting-container {
                flex: 1;
                padding: 40px;
                margin-left: 260px; /* Adjust for the sidebar */
                margin-top: 80px; /* Adjust for header */
                box-sizing: border-box;
                background-color: #f5f5f5;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            /* Form card styling */
            .job-posting-card {
                background-color: #ffffff;
                padding: 40px;
                border-radius: 10px;
                border: 1px solid #ddd;
                max-width: 900px; /* Increased width */
                width: 100%;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            /* Title styling */
            .job-posting-card h2 {
                text-align: center;
                margin-bottom: 30px; /* Increased space */
                font-weight: bold;
                color: #007b5e;
            }

            /* Label and input field styling */
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 15px;
                color: #389354;
            }

            .form-control {
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 12px;
                font-size: 15px;
                background-color: #fafafa;
                margin-bottom: 20px; /* Increased space */
            }

            /* Two-column layout for form fields */
            .row .col-md-6 {
                padding-right: 15px;
                padding-left: 15px;
            }

            /* Button styling */
            .btn-group {
                display: flex;
                justify-content: flex-start;
                gap: 20px;
                margin-top: 20px;
            }

            .btn-success {
                background-color: #007b5e;
                border: none;
                padding: 12px 24px;
                font-size: 16px;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
                padding: 12px 24px;
                font-size: 16px;
            }

            /* Checkbox styling */
            .form-check {
                margin-top: 20px;
            }

            footer {
                background-color: #389354;
                color: white;
                text-align: center;
                padding: 20px 0;
                width: calc(100% - 260px);
                margin-left: 260px;
                bottom: 0;
                position: relative;
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

        <!-- Job Posting Form -->
        <div class="job-posting-container">
            <div class="job-posting-card">
                <a href="${pageContext.request.contextPath}/jobPost" class="btn btn-outline-secondary mb-3">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <form id="jobPostingForm" action="${pageContext.request.contextPath}/jobPost?action=add-jp" method="POST" onsubmit="return validateForm()">
                    <h2>Add Job Posting</h2>

                    <!-- Title -->
                    <div class="form-group">
                        <label for="jobTitle">Job Title:</label>
                        <input type="text" id="jobTitle" name="jobTitle" class="form-control" placeholder="Enter job title" value="${jobTitle}" required>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="jobDescription">Job Description:</label>
                        <textarea id="jobDescription" name="jobDescription" class="form-control" placeholder="Enter job description" rows="3" required>${jobDescription}</textarea>
                    </div>

                    <!-- Requirements -->
                    <div class="form-group">
                        <label for="jobRequirements">Job Requirements:</label>
                        <textarea id="jobRequirements" name="jobRequirements" class="form-control" placeholder="Enter job requirements" rows="3" required>${jobRequirements}</textarea>
                    </div>
                    <!-- Two-column row for Location, Salary, Status, Posted Date, and Closing Date -->
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Location -->
                            <div class="form-group">
                                <label for="jobLocation">Location:</label>
                                <input type="text" id="jobLocation" name="jobLocation" class="form-control" placeholder="Enter job location" value="${jobLocation}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Salary -->
                            <div class="form-group">
                                <label for="jobSalary">Salary $:</label>
                                <input type="number" id="jobSalary" name="jobSalary" class="form-control" placeholder="Enter job salary" value="${jobSalary}" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Status -->
                            <div class="form-group">
                                <label for="jobStatus">Status:</label>
                                <select id="jobStatus" name="jobStatus" class="form-control" required>
                                    <option value="Open" <c:if test="${jobStatus == 'Open'}">selected</c:if>>Open</option>
<!--                                    <option value="Filled" <c:if test="${jobStatus == 'Filled'}">selected</c:if>>Filled</option>
                                    <option value="Closed" <c:if test="${jobStatus == 'Closed'}">selected</c:if>>Closed</option>-->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Posted Date -->
                            <div class="form-group">
                                <label for="postedDate">Posted Date:</label>
                                <input type="date" id="postedDate" name="postedDate" class="form-control" value="${postedDate}" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <!-- Closing Date -->
                            <div class="form-group">
                                <label for="closingDate">Closing Date:</label>
                                <input type="date" id="closingDate" name="closingDate" class="form-control" value="${closingDate}" required>
                            </div>
                        </div>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check">
                        <input type="checkbox" id="jobPathAgreement" name="jobPathAgreement" class="form-check-input" required>
                        <label class="form-check-label" for="jobPathAgreement">
                            I have read and agree to Job Paths Terms of Service
                        </label>
                    </div>

                    <c:if test="${not empty erMess}">
                        <div class="alert alert-danger" role="alert">
                            <ul>
                                <c:forEach var="error" items="${erMess}">
                                    <li>${error}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                    <!-- Success message -->
                    <c:if test="${not empty successPost}">
                        <div class="alert alert-success">
                            ${successPost}
                        </div>
                    </c:if>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-success">Save Job</button>
                        <button type="button" class="btn btn-secondary" onclick="clearForm()">Reset</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- JavaScript to handle form reset and validation -->
        <script>
            function clearForm() {
                // Reset form fields to their default values
                document.getElementById("jobPostingForm").reset();

                // Manually reset TinyMCE content for job description and requirements
                tinymce.get("jobDescription").setContent('');
                tinymce.get("jobRequirements").setContent('');

                // Manually clear other input fields
                document.getElementById("jobTitle").value = '';
                document.getElementById("jobLocation").value = '';
                document.getElementById("jobSalary").value = '';
                document.getElementById("jobStatus").value = 'Open'; // Default value
                document.getElementById("postedDate").value = '';
                document.getElementById("closingDate").value = '';

                // Manually uncheck the checkbox if it was checked
                document.getElementById("jobPathAgreement").checked = false;
            }

            function validateForm() {
                // Ensure job description and job requirements are not empty
                const jobDescription = tinymce.get("jobDescription").getContent({ format: "text" }).trim();
                const jobRequirements = tinymce.get("jobRequirements").getContent({ format: "text" }).trim();

                if (!jobDescription) {
                    alert("Job Description cannot be empty.");
                    return false;
                }

                if (!jobRequirements) {
                    alert("Job Requirements cannot be empty.");
                    return false;
                }

                // All validation passed
                return true;
            }

            tinymce.init({
                selector: 'textarea', // Initialize TinyMCE for all text areas
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                menubar: true, // Disable the menubar
                branding: false, // Disable the TinyMCE branding
                height: 300, // Set the height of the editor
                setup: function(editor) {
                    editor.on('change', function() {
                        tinymce.triggerSave(); // Synchronize TinyMCE content with the form
                    });
                }
            });

        </script>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>
