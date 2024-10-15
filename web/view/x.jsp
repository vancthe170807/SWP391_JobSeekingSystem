<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recruiter Home</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Recruiter home design */
            body, html {
                height: 100%;
                margin: 0;
                font-family: Arial, Helvetica, sans-serif;
            }

            .container-fluid {
                background-color: #f8f9fa;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
            }

            .hero-section {
                text-align: center;
                padding: 50px 0;
            }

            .hero-section h1 {
                font-size: 48px;
                color: #333;
                font-weight: bold;
            }

            .hero-section p {
                font-size: 18px;
                color: #555;
                margin-bottom: 30px;
            }

            .btn-verification {
                padding: 15px 30px;
                font-size: 20px;
                background-color: #007bff;
                color: white;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-verification:hover {
                background-color: #0056b3;
            }

            /* Employer verification form */
            .modal-content {
                padding: 30px;
                border-radius: 8px;
            }

            .form-control {
                margin-bottom: 20px;
            }

            .form-header {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 30px;
            }

            .submit-btn {
                padding: 12px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }

            .submit-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <!-- Recruiter Home Section -->
        <div class="container-fluid">
            <div class="hero-section">
                <h1>Welcome to the Recruiting Platform</h1>
                <p>Get started by verifying your company as an employer. Once verified, you can manage your job postings, view applicants, and more!</p>
                <button class="btn-verification" data-bs-toggle="modal" data-bs-target="#verificationModal">
                    Employer Verification
                </button>
            </div>
        </div>

        <!-- Employer Verification Modal -->
        <div class="modal fade" id="verificationModal" tabindex="-1" aria-labelledby="verificationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verificationModalLabel">Employer Verification Form</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="verificationForm" action="${pageContext.request.contextPath}/verifyEmployer" method="post">
                            <div class="form-header">Fill in your company details</div>

                            <div class="mb-3">
                                <label for="companyName" class="form-label">Company Name</label>
                                <input type="text" class="form-control" id="companyName" name="companyName" required>
                            </div>

                            <div class="mb-3">
                                <label for="companyEmail" class="form-label">Company Email</label>
                                <input type="email" class="form-control" id="companyEmail" name="companyEmail" required>
                            </div>

                            <div class="mb-3">
                                <label for="companyPhone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="companyPhone" name="companyPhone" required>
                            </div>

                            <div class="mb-3">
                                <label for="companyAddress" class="form-label">Company Address</label>
                                <input type="text" class="form-control" id="companyAddress" name="companyAddress" required>
                            </div>

                            <div class="mb-3">
                                <label for="companyWebsite" class="form-label">Company Website</label>
                                <input type="url" class="form-control" id="companyWebsite" name="companyWebsite">
                            </div>

                            <button type="submit" class="submit-btn">Submit for Approval</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
