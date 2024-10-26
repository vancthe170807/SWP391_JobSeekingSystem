<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Job Posting</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- TinyMCE Script -->
        <script src="https://cdn.tiny.cloud/1/ygxzbqd4ej8z1yjswkp0ljn56qm4r6luix9l83auaajk3h3q/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <style>
            /* Flexbox layout for body and content */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Job Posting Container */
            .job-posting-container {
                flex: 1;
                padding: 20px;
                margin-left: 260px; /* Adjust for sidebar */
                margin-top: 80px; /* Adjust for header */
                box-sizing: border-box;
                background-color: #f5f5f5;
                display: flex;
                justify-content: center; /* Center the form horizontally */
                align-items: flex-start; /* Align to the top of the page */
                min-height: calc(100vh - 80px); /* Ensure minimum height to push footer */
                overflow: auto; /* Allow scrolling if content is too large */
            }

            .job-posting-content {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 1200px; /* Limit the width of the form */
            }

            .job-posting-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .job-posting-header h2 {
                color: #007b5e;
                font-weight: bold;
            }

            .form-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr); /* Two columns */
                grid-gap: 20px;
            }

            .form-group {
                margin-bottom: 15px;
                display: flex;
                flex-direction: column;
            }

            .form-label {
                font-weight: bold;
                color: #007b5e;
            }

            .form-control {
                border-radius: 5px;
                padding: 10px;
                font-size: 14px;
                width: 100%; /* Ensure inputs take full width */
            }

            /* Buttons */
            .btn-save {
                background-color: #007b5e;
                color: white;
                padding: 12px 30px;
                font-size: 16px;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
                border: none;
            }

            .btn-save:hover {
                background-color: #005f46;
            }

            /* Back Button Styling */
            .btn-back {
                display: flex;
                align-items: center;
                color: #007b5e;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none;
                margin-bottom: 20px;
            }

            .btn-back i {
                margin-right: 8px; /* Spacing between icon and text */
            }

            .btn-back:hover {
                text-decoration: underline;
                color: #005f46;
            }

            /* Footer */
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
                flex-shrink: 0;
                z-index: 1;
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

        <!-- Main content for Editing Job Posting -->
        <div class="job-posting-container">
            <div class="job-posting-content">
                <!-- Back button with icon -->
                <a href="${pageContext.request.contextPath}/jobPost" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Manage
                </a>

                <div class="job-posting-header">
                    <h2>Edit Job Posting</h2>
                </div>
                <form action="${pageContext.request.contextPath}/jobPost?action=updateJobPost" method="post">
                    <!-- Grid layout for form -->
                    <div class="form-grid">
   
                        <input type="hidden" id="JobPostingID" name="JobPostingID" 
                               value="${param.JobPostingID != null ? param.JobPostingID : jobPost.getJobPostingID()}">

                        <div class="form-group">
                            <label for="jobTitle" class="form-label">Job Title</label>
                            <input type="text" id="jobTitle" name="jobTitle" class="form-control" 
                                   value="${param.jobTitle != null ? param.jobTitle : jobPost.getTitle()}" required>
                        </div>

                        <!-- Job Location -->
                        <div class="form-group">
                            <label for="jobLocation" class="form-label">Location</label>
                            <input type="text" id="jobLocation" name="jobLocation" class="form-control" 
                                   value="${param.jobLocation != null ? param.jobLocation : jobPost.getLocation()}" required>
                        </div>
                        <!-- Job Description -->
                        <div class="form-group">
                            <label for="jobDescription" class="form-label">Job Description</label>
                            <textarea id="jobDescription" name="jobDescription" class="form-control" rows="6" required>${fn:escapeXml(param.jobDescription != null ? param.jobDescription : jobPost.getDescription())}</textarea>
                        </div>

                        <!-- Job Requirements -->
                        <div class="form-group">
                            <label for="jobRequirements" class="form-label">Job Requirements</label>
                            <textarea id="jobRequirements" name="jobRequirements" class="form-control" rows="6" required>${fn:escapeXml(param.jobRequirements != null ? param.jobRequirements : jobPost.getRequirements())}</textarea>
                        </div>

                        <!-- Job Salary -->
                        <div class="form-group">
                            <label for="minSalary" class="form-label">Min Salary $</label>
                            <input type="number" id="minSalary" name="minSalary" class="form-control" 
                                   value="${param.minSalary != null ? param.minSalary : jobPost.getMinSalary()}" required>
                        </div>
                        <div class="form-group">
                            <label for="maxSalary" class="form-label">Max Salary $</label>
                            <input type="number" id="maxSalary" name="maxSalary" class="form-control" 
                                   value="${param.maxSalary != null ? param.maxSalary : jobPost.getMaxSalary()}" required>
                        </div>

                        <div class="form-group">
                            <label for="jobCategory">Job Category:</label>
                            <select id="jobCategory" name="jobCategory" class="form-control" required>
                                <option value="">Select Job Category</option>
                                <c:forEach var="category" items="${jobCategories}">
                                    <option value="${category.getId()}" 
                                            <c:if test="${category.getId() == selectedJobCategory}">selected</c:if>>
                                        ${category.getName()}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Job Status -->
                        <div class="form-group">
                            <label for="jobStatus" class="form-label">Status</label>
                            <select id="jobStatus" name="jobStatus" class="form-control" required>
                                <option value="Open" ${param.jobStatus == 'Open' ? 'selected' : (jobPost.getStatus() == 'Open' ? 'selected' : '')}>Open</option>
                                <option value="Filled" ${param.jobStatus == 'Filled' ? 'selected' : (jobPost.getStatus() == 'Filled' ? 'selected' : '')}>Filled</option>
                                <option value="Closed" ${param.jobStatus == 'Closed' ? 'selected' : (jobPost.getStatus() == 'Closed' ? 'selected' : '')}>Closed</option>
                            </select>
                        </div>

                        <!-- Posted Date -->
                        <div class="form-group">
                            <label for="postedDate" class="form-label">Posted Date</label>
                            <input type="date" id="postedDate" name="postedDate" class="form-control" 
                                   value="${param.postedDate != null ? param.postedDate : jobPost.getPostedDate()}" required>
                        </div>

                        <!-- Closing Date -->
                        <div class="form-group">
                            <label for="closingDate" class="form-label">Closing Date</label>
                            <input type="date" id="closingDate" name="closingDate" class="form-control" 
                                   value="${param.closingDate != null ? param.closingDate : jobPost.getClosingDate()}" required>
                        </div>
                    </div>

                    <!-- Error Messages -->
                    <c:if test="${not empty eM}">
                        <div class="alert alert-danger" role="alert">
                            <ul>
                                <c:forEach var="error" items="${eM}">
                                    <li>${error}</li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <!-- Save Button -->
                    <button type="submit" class="btn-save">Save Changes</button>
                </form>

            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>
        <script>
            tinymce.init({
                selector: 'textarea', // Initialize TinyMCE for all text areas
                plugins: 'advlist autolink lists link image charmap print preview anchor',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat',
                menubar: true, // Disable the menubar
                branding: false, // Disable the TinyMCE branding
                height: 300, // Set the height of the editor
                setup: function (editor) {
                    editor.on('change', function () {
                        tinymce.triggerSave(); // Synchronize TinyMCE content with the form
                    });
                }
            });

        </script>
    </body>
</html>
