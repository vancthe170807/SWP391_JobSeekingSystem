<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Please Authenticate Your Recruiter</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* To make sure the layout takes up the full viewport height */
            body, html {
                height: 100%;
                margin: 0;
            }

            /* Wrapper to hold the main content and footer */
            .wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh; /* This ensures the wrapper takes up at least the full height */
            }

            /* Main content styling */
            .main-content {
                flex: 1; /* Allows main content to grow and push the footer to the bottom */
                margin-left: 260px;
                padding: 40px;
                padding-top: 120px;
                background-color: #f7f8fa;
            }

            /* Header styling */
            header {
                background-color: #2c3e50;
                padding: 15px 30px;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                left: 260px;
                width: calc(100% - 260px);
                height: 70px;
                z-index: 1000;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            /* Card styling */
            .card {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                border: none;
                background: #fff;
                transition: all 0.3s ease;
                max-width: 600px;
                margin: 0 auto;
                margin-bottom: 40px; /* Ensures space between form and footer */
            }

            .card:hover {
                transform: scale(1.02);
            }

            /* Header in the card */
            .card-header {
                background-color: #227527c9;
                color: #fff;
                text-align: center;
                padding: 15px;
                font-size: 20px;
                font-weight: bold;
                border-radius: 10px 10px 0 0;
            }


            /* Button styling */
            .btn-primary {
                background-color: #227527c9;
                border-color: #16a085;
                padding: 4px 18px;
                font-size: 16px;
                border-radius: 50px;
                width: 150px;
                margin: 0 auto;
            }


            .btn-primary:hover {
                background-color: #148f77;
                border-color: #148f77;
            }

            /* Input styling */
            .form-control {
                border-radius: 8px;
                padding: 12px;
                border: 1px solid #ccc;
                font-size: 15px;
            }

            /* Image preview styling */
            .preview-img {
                width: 100px;
                height: 100px;
                border: 1px solid #ddd;
                margin-top: 10px;
                display: none;
                border-radius: 10px;
                object-fit: cover;
            }

            /* Footer styling */
            footer {
                background-color: #2c3e50;
                color: white;
                text-align: center;
                padding: 10px 0;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            /* Alert styling */
            .alert {
                border-radius: 50px;
            }

            /* Additional responsive styling */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding-top: 80px;
                }

                header {
                    width: 100%;
                    left: 0;
                }
            }
        </style>
    </head>
    <body>

        <div class="wrapper">
            <%@ include file="../recruiter/sidebar-re.jsp" %>

            <!-- Main content -->
            <div class="main-content">  
                <%@ include file="../recruiter/header-re.jsp" %>

                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card shadow">
                                <div class="card-header">
                                    Verify your account to use this service
                                </div>
                                <div class="card-body">
                                    <!-- Display error message -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger text-center">${error}</div>
                                    </c:if>

                                    <!-- Form starts -->
                                    <form action="${pageContext.request.contextPath}/verifyRecruiter" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                                        <!-- Company ID input -->
                                        <div class="mb-3">
                                            <label for="companyId" class="form-label">Enter Company ID</label>
                                            <input type="text" class="form-control" id="companyId" name="companyId" placeholder="e.g. 12345" required>
                                        </div>

                                        <!-- Position input -->
                                        <div class="mb-3">
                                            <label for="position" class="form-label">Position</label>
                                            <input type="text" class="form-control" id="position" name="position" placeholder="e.g. Recruiter" required>
                                        </div>

                                        <!-- Upload Front of Citizen ID -->
                                        <div class="mb-3">
                                            <label for="frontCitizenID" class="form-label">Upload Front of Citizen ID</label>
                                            <input type="file" class="form-control" id="frontCitizenID" name="frontCitizenID" accept="image/*" onchange="previewImage(this, 'frontPreview')" required>
                                            <img id="frontPreview" class="preview-img" alt="Front Citizen ID">
                                        </div>

                                        <!-- Upload Back of Citizen ID -->
                                        <div class="mb-3">
                                            <label for="backCitizenID" class="form-label">Upload Back of Citizen ID</label>
                                            <input type="file" class="form-control" id="backCitizenID" name="backCitizenID" accept="image/*" onchange="previewImage(this, 'backPreview')" required>
                                            <img id="backPreview" class="preview-img" alt="Back Citizen ID">
                                        </div>

                                        <!-- Submit button -->
                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-primary">Submit Request</button>
                                        </div>

                                        <!-- Display success message -->
                                        <c:if test="${not empty verify}">
                                            <div class="alert alert-success mt-3 text-center">${verify}</div>
                                        </c:if>
                                    </form>
                                    <!-- Form ends -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Include footer -->
            <footer>
                <%@ include file="../recruiter/footer-re.jsp" %>
            </footer>
        </div>

        <!-- Validation and preview scripts -->
        <script>
            let lastUploadedFront = '';
            let lastUploadedBack = '';

            function validateForm() {
                var companyId = document.getElementById("companyId").value;
                var regex = /^[0-9]+$/;
                if (!regex.test(companyId)) {
                    alert("Company ID must be a number without spaces or other characters.");
                    return false;
                }
                return true;
            }

            function previewImage(input, imageId) {
                const file = input.files[0];
                const imgElement = document.getElementById(imageId);
                const filePath = URL.createObjectURL(file);

                // Check if the user is trying to upload the same image twice
                if (imageId === 'frontPreview' && filePath === lastUploadedFront) {
                    alert('You have already uploaded this image.');
                    input.value = ''; // Reset the input file
                    return;
                }

                if (imageId === 'backPreview' && filePath === lastUploadedBack) {
                    alert('You have already uploaded this image.');
                    input.value = ''; // Reset the input file
                    return;
                }

                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        imgElement.src = e.target.result;
                        imgElement.style.display = 'block'; // Hiển thị ảnh sau khi chọn
                    }
                    reader.readAsDataURL(file);

                    // Store the last uploaded file path
                    if (imageId === 'frontPreview') {
                        lastUploadedFront = filePath;
                    } else if (imageId === 'backPreview') {
                        lastUploadedBack = filePath;
                    }
                }
            }
        </script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
