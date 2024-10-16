<%@page import="model.CV"%>
<%@page import="model.JobSeekers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seeker's CV</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- Header area end -->

            <div class="container mt-5 mb-5">
                <h2 class="mb-4">Manage Your CV</h2>

                <!-- Display success or error messages -->
            <c:if test="${not empty successCV}">
                <div class="alert alert-success" role="alert">
                    ${successCV}
                </div>
            </c:if>

            <c:if test="${not empty errorCV}">
                <div class="alert alert-danger" role="alert">
                    ${errorCV}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <!-- Check if there's a CV -->
            <c:if test="${not empty cvFilePath}">
                <!-- Display View CV button -->
                <div class="d-grid gap-2 mb-1">
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#updateCVModal">
                    Update CV
                </button>
                </div>
                <div class="mb-4">
                    <iframe src="cv?action=view-cv" height="1200px" width="100%" allowfullscreen="" frameborder="0"></iframe>
                </div>

                <!-- Form to update CV -->
                

            </c:if>

            <c:if test="${empty cvFilePath}">
                <!-- Form to upload CV if not present -->
                <form action="${pageContext.request.contextPath}/cv?action=upload-cv" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="cvFile" class="form-label">Upload CV</label>
                        <input type="file" class="form-control" id="cvFile" name="cvUploadFile" accept=".pdf" required>
                    </div>
                    <span style="color: green">Note: <strong>Upload file less than 10MB (or 10 240KB)</strong></span><br/>
                    <button type="submit" class="btn btn-success">Upload CV</button>
                </form>
            </c:if>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="updateCVModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Update CV</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/cv?action=update-cv" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        
                    <div class="mb-3">
                        <label for="cvFile" class="form-label">Update CV</label>
                        <input type="file" class="form-control" id="cvFile" name="cvFile" accept=".pdf" required>
                    </div>
                        <span style="color: green">Note: <strong>Upload file less than 10MB (or 10 240KB)</strong></span>
                
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-success">Update CV</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
