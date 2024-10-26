<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Postings Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h2 class="text-center mb-4">Job Postings</h2>

    <!-- Search and Filter Section -->
    <form action="${pageContext.request.contextPath}/home" method="get" class="row g-3 mb-4">
        <!-- Search by Title -->
        <div class="col-md-6">
            <input type="text" name="searchTitle" class="form-control" placeholder="Search by job title"
                   value="${param.searchTitle}">
        </div>

        <!-- Filter by Job Category -->
        <div class="col-md-4">
            <select name="jobCategory" class="form-select">
                <option value="">All Categories</option>
                <c:forEach var="category" items="${jobCategories}">
                    <option value="${category.getId()}" 
                            <c:if test="${category.getId() == param.jobCategory}">selected</c:if>>${category.getName()}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Submit Button -->
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <!-- Job Listings Table -->
    <table class="table table-bordered">
        <thead class="table-light">
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Requirements</th>
            <th>Min - Max Salary</th>
            <th>Location</th>
            <th>Category</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="job" items="${jobPostings}">
            <tr>
                <td>${job.getTitle()}</td>
                <td>${job.getDescription()}</td>
                <td>${job.getRequirements()}</td>
                <td>${job.getMinSalary()} - ${job.getMaxSalary()}</td>
                <td>${job.getLocation()}</td>
                <td>${job.getCategory().getName()}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination Controls -->
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage - 1}&searchTitle=${param.searchTitle}&jobCategory=${param.jobCategory}">Previous</a>
                </li>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                <li class="page-item <c:if test='${pageNum == currentPage}'>active</c:if>">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${pageNum}&searchTitle=${param.searchTitle}&jobCategory=${param.jobCategory}">${pageNum}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage + 1}&searchTitle=${param.searchTitle}&jobCategory=${param.jobCategory}">Next</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
