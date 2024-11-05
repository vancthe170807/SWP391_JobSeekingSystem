<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JobPath - Home</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            /* Custom CSS styles go here */
            .hero {
                background: linear-gradient(rgba(40, 167, 69, 0.8), rgba(40, 167, 69, 0.8)), url('${pageContext.request.contextPath}/assets/img/istockphoto-475352876-612x612.jpg') center/cover no-repeat;
                color: white;
                padding: 120px 0;
                text-align: center;
            }

            .hero h1 {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .hero p {
                font-size: 1.25rem;
                margin-bottom: 2rem;
            }

            .search-container {
                background-color: #f8f9fa;
                padding: 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            }

            .search-box {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 25px;
                font-size: 16px;
            }

            .search-button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 25px;
                transition: background-color 0.3s;
            }

            .search-button:hover {
                background-color: #218838;
            }

            .filter-form {
                background-color: #f8f9fa;
                padding: 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            }

            .job-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 100%;
            }

            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }

            .job-card-link {
                text-decoration: none;
                color: inherit;
                display: block;
                height: 100%;
            }

            .job-card-link:hover {
                color: inherit;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <!-- Header -->
        <jsp:include page="../view/common/header-area.jsp"></jsp:include>

            <!-- Hero Section -->
            <section class="hero">
                <div class="container">
                    <h1>Welcome to JobPath</h1>
                    <p>Your path to finding the perfect job starts here.</p>
            </div>
        </section>

        <!-- Job Listings Section -->
        <section class="py-5">
            <div class="container">
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-md-3 mb-4">
                        <div class="filter-form">
                            <h4 class="mb-3">Filters</h4>
                            <form action="home" method="GET" class="mb-4" id="filterForm">
                                <div class="row align-items-center mb-3">
                                    <div class="col-md-9">
                                        <input type="text" name="search" class="form-control search-box" placeholder="Search by job title" value="${param.search}">
                                    </div>
                                    <div class="col-md-2 mt-2 mt-md-0">
                                        <button type="submit" class="search-button">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="jobCategory" class="form-label">Job Category:</label>
                                    <select name="filterCategory" id="jobCategory" class="form-select" onchange="document.getElementById('filterForm').submit();">
                                        <option value="">All Categories</option>
                                        <c:forEach var="category" items="${activeCategories}">
                                            <option value="${category.getId()}" ${category.getId() == param.filterCategory ? 'selected' : ''}>${category.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="minSalary" class="form-label">Salary Range:</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="minSalary" name="minSalary" placeholder="Min ($)" value="${param.minSalary}">
                                        <span class="input-group-text">-</span>
                                        <input type="number" class="form-control" id="maxSalary" name="maxSalary" placeholder="Max ($)" value="${param.maxSalary}">
                                    </div>
                                    <button type="submit" class="btn btn-success">Filter by Salary</button>
                                </div>
                            </form>

                            <div class="mb-4">
                                <a href="${pageContext.request.contextPath}/home?sort=title&page=1&searchJP=${searchJP}" class="btn btn-success btn-sm">Sort by Title A-Z</a>
                                <a href="${pageContext.request.contextPath}/home?sort=postedDate&page=1&searchJP=${searchJP}" class="btn btn-success btn-sm">Sort by Post Date</a>
                            </div>
                        </div>
                    </div>

                    <!-- Job Listings -->
                    <div class="col-md-9">
                        <div class="row">
                            <c:if test="${empty jobPostingsList}">
                                <div class="col-12 text-center">
                                    <h4>No jobs found matching your criteria</h4>
                                </div>
                            </c:if>
                            <c:forEach var="job" items="${jobPostingsList}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <a href="${pageContext.request.contextPath}/viewdetail?action=details&idJP=${job.getJobPostingID()}" class="job-card-link">
                                        <div class="card job-card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title mb-3">${job.getTitle()}</h5>
                                                <div class="mb-2">
                                                    <span class="badge bg-primary">
                                                        <i class="fas fa-map-marker-alt me-1"></i>
                                                        ${job.getLocation()}
                                                    </span>
                                                </div>
                                                <div class="mb-3">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-dollar-sign me-1"></i>
                                                        ${job.getMinSalary()} - ${job.getMaxSalary()}
                                                    </span>
                                                </div>
                                                <p class="text-muted mb-0">
                                                    <i class="far fa-clock me-1"></i>
                                                    Posted: ${job.getPostedDate()}
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center" id="pagination">
                                <c:if test="${pageControl.getPage() > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage()-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo; Previous</span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:set var="startPage" value="${pageControl.getPage() - 2 > 0 ? pageControl.getPage() - 2 : 1}"/>
                                <c:set var="endPage" value="${startPage + 4 <= pageControl.getTotalPages() ? startPage + 4 : pageControl.getTotalPages()}"/>

                                <c:if test="${startPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${startPage-1}">...</a>
                                    </li>
                                </c:if>

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == pageControl.getPage() ? 'active' : ''}">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${endPage < pageControl.getTotalPages()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${endPage + 1}">...</a>
                                    </li>
                                </c:if>

                                <c:if test="${pageControl.getPage() < pageControl.getTotalPages()}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageControl.getUrlPattern()}page=${pageControl.getPage() + 1}" aria-label="Next">
                                            <span aria-hidden="true">Next &raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="../view/common/footer.jsp"></jsp:include>

        <script>
            // Category filter auto-submit
            document.getElementById('jobCategory').addEventListener('change', function () {
                document.getElementById('categoryForm').submit();
            });

            // Salary range validation
            const minSalaryInput = document.getElementById('minSalary');
            const maxSalaryInput = document.getElementById('maxSalary');

            minSalaryInput.addEventListener('change', function () {
                const minValue = parseInt(this.value);
                if (maxSalaryInput.value && minValue > parseInt(maxSalaryInput.value)) {
                    maxSalaryInput.value = minValue;
                }
            });

            maxSalaryInput.addEventListener('change', function () {
                const maxValue = parseInt(this.value);
                if (minSalaryInput.value && maxValue < parseInt(minSalaryInput.value)) {
                    minSalaryInput.value = maxValue;
                }
            });

            // Back to top button
            const backToTopButton = document.getElementById('back-to-top');

            window.onscroll = function () {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    backToTopButton.style.display = 'block';
                } else {
                    backToTopButton.style.display = 'none';
                }
            };

            backToTopButton.addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        </script>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
