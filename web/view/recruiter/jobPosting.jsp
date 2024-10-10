<!DOCTYPE html>
<html lang="en">
    <head>   
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post a Job</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .container-fluid {
                display: flex;
                flex: 1;
                justify-content: center;
                align-items: flex-start;
            }

            .job-post-container {
                width: 600px;
                background-color: #fff;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-top: 50px;
            }

            h1 {
                text-align: center;
                margin-bottom: 40px;
                font-size: 28px;
                font-weight: bold;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 12px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .form-group textarea {
                height: 80px;
                resize: none;
            }

            .form-row {
                display: flex;
                justify-content: space-between;
            }

            .form-row .form-group {
                width: 48%;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .checkbox-group input {
                margin-right: 10px;
            }

            .button-group {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .button-group button {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .button-group .complete-btn {
                background-color: #28a745;
                color: white;
            }

            .button-group .reset-btn {
                background-color: #6c757d;
                color: white;
            }

            .button-group button:hover {
                opacity: 0.9;
            }

            header {
                background-color: #28a745; /* Adjust this to your desired color */
                padding: 15px 30px;
                color: white;
                display: flex;
                justify-content: space-between; /* Space between navigation links and user menu */
                align-items: center;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;
            }

            .nav-links {
                display: flex;
            }

            .nav-item {
                margin-right: 20px;
            }

            .nav-item a {
                color: white;
                text-decoration: none;
                font-size: 16px;
            }

            .nav-item a:hover {
                color: #f8f9fa;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-menu .notification {
                position: relative;
            }

            .user-menu .notification .badge {
                position: absolute;
                top: -10px;
                right: -10px;
                background-color: red;
                color: white;
                border-radius: 50%;
                padding: 5px;
            }

            .avatar-img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 10px;
            }

            .btn.dropdown-toggle {
                background: none;
                border: none;
                color: white;
                font-size: 16px;
            }

            .btn.dropdown-toggle:hover {
                color: #f8f9fa;
            }

            .dropdown-menu {
                background-color: #ffffff;
            }

            .dropdown-item {
                color: black;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
            }

            .logout {
                color: red !important;
            }

        </style>
    </head>
    <body>
        <!-- Sidebar and header included above the form -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        <%@ include file="../recruiter/header-re.jsp" %>
        <div class="container-fluid">
            <div class="job-post-container">
                <h1>Post a Job</h1>
                <form>
                    <!-- Title -->
                    <div class="form-group">
                        <label for="title">Title:</label>
                        <input type="text" id="title" placeholder="Enter job title">
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" placeholder="Enter job description"></textarea>
                    </div>

                    <!-- Location -->
                    <div class="form-group">
                        <label for="location">Location:</label>
                        <input type="text" id="location" placeholder="Enter job location">
                    </div>

                    <!-- Requirements -->
                    <div class="form-group">
                        <label for="requirements">Requirements:</label>
                        <textarea id="requirements" placeholder="Enter job requirements"></textarea>
                    </div>

                    <!-- Salary and Status -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="salary">Salary:</label>
                            <input type="number" id="salary" placeholder="Enter salary details">
                        </div>
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select id="status">
                                <option>Filled</option>
                                <option>Open</option>
                                <option>Closed</option>
                            </select>
                        </div>
                    </div>

                    <!-- Posted Date and Closing Date -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="postedDate">Posted Date:</label>
                            <input type="date" id="postedDate">
                        </div>
                        <div class="form-group">
                            <label for="closingDate">Closing Date:</label>
                            <input type="date" id="closingDate">
                        </div>
                    </div>

                    <!-- Checkbox for agreement -->
                    <div class="checkbox-group">
                        <input type="checkbox" id="terms">
                        <label for="terms">I have read and agree to Job Paths Terms of Service</label>
                    </div>

                    <!-- Buttons -->
                    <div class="button-group">
                        <button type="submit" class="complete-btn">Complete</button>
                        <button type="reset" class="reset-btn">Reset</button>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>
