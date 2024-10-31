<%-- 
    Document   : ViewJobPosting
    Created on : Oct 17, 2024, 2:10:58 PM
    Author     : vanct
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Job Posting Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <!-- Include header -->
    <jsp:include page="../common/user/header-user.jsp"></jsp:include>

    <div class="container my-5">
        <c:if test="${not empty jobPost}">
            <div class="row">
                <!-- Job Details Section -->
                <div class="col-md-8">
                    <!-- Job Basic Info -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-body">
                            <h1 class="card-title">${jobPost.title}</h1>
                            <hr>
                            <div class="row">
                                <div class="col-md-4">
                                    <p><i class="fas fa-calendar-alt"></i> <strong>Post Date:</strong> ${jobPost.postedDate}</p>
                                </div>
                                <div class="col-md-4">
                                    <p><i class="fas fa-hourglass-end"></i> <strong>Deadline:</strong> ${jobPost.closingDate}</p>
                                </div>
                                <div class="col-md-4">
                                    <p><i class="fa-solid fa-location-dot"></i> <strong>Location: </strong>${jobPost.location}</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <p><i class="fa-solid fa-circle"></i> <strong>Status: </strong>${jobPost.status}</p>
                                </div>
                                <div class="col-md-4">
                                    <p><i class="fa-solid fa-money-bill"></i> <strong>Salary: </strong>${jobPost.minSalary} $ - ${jobPost.maxSalary} $</p>
                                </div>
                            </div>
                            <div class="row">
                                <p><i class="fa-solid fa-list"></i> <strong>Job Category:</strong> ${category != null ? category.name : 'N/A'}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Job Description -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h5 class="m-0">Description</h5>
                        </div>
                        <div class="card-body">
                            <p>${jobPost.description}</p>
                        </div>
                    </div>

                    <!-- Job Requirements -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h5 class="m-0">Requirements</h5>
                        </div>
                        <div class="card-body">
                            <p>${jobPost.requirements}</p>
                        </div>
                    </div>
                </div>

                <!-- Sidebar Section for Application Form -->
                <div class="col-md-4">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h5 class="m-0">Apply Job</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-favourJP" method="post">
                                <input type="hidden" name="jobPostingIDF" value="${jobPost.jobPostingID}">
                                <c:if test="${not empty jobSeekerF}">
                                    <input type="hidden" name="jobSeekerIDF" value="${jobSeekerF.jobSeekerID}">
                                </c:if>
                                <input type="submit" class="btn btn-success" value="Favourite Job Posting">
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/jobPostingDetail?action=add-application" method="post">
                                <input type="hidden" name="jobPostingID" value="${jobPost.jobPostingID}">
                                <c:if test="${not empty jobSeeker}">
                                    <input type="hidden" name="jobSeekerID" value="${jobSeeker.jobSeekerID}">
                                </c:if>
                                <c:if test="${not empty cv}">
                                    <input type="hidden" name="cvid" value="${cv.CVID}">
                                </c:if>
                                <input type="submit" class="btn btn-success" value="Apply Job">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Include footer -->
    <jsp:include page="../common/footer.jsp"></jsp:include>

    <!-- Bootstrap JS and Popper -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
