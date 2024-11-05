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
            .hero {
                background: linear-gradient(rgba(40, 167, 69, 0.8), rgba(40, 167, 69, 0.8)),
                    url('${pageContext.request.contextPath}/assets/img/istockphoto-475352876-612x612.jpg') center/cover no-repeat;
                color: white;
                padding: 120px 0;
                text-align: center;
            }

            .hero h2 {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .hero p {
                font-size: 1.25rem;
                margin-bottom: 2rem;
            }

            .search-container {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }
            .search-box {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 25px;
                margin-right: 10px;
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

            .explore-btn {
                background-color: #28a745;
                color: white;
                padding: 0.625rem 1.875rem;
                border-radius: 0.3125rem;
                font-size: 1.125rem;
                transition: all 0.3s ease;
            }

            .explore-btn:hover {
                background-color: #218838;
                color: white;
                transform: translateY(-2px);
            }

            .card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 100%;
            }

            .card:hover {
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

            .salary-filter-form {
                background-color: #f8f9fa;
                padding: 1.25rem;
                border-radius: 0.5rem;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            }

            #back-to-top {
                display: none;
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 99;
                transition: opacity 0.3s ease;
            }

            @media (max-width: 768px) {
                .hero h2 {
                    font-size: 2rem;
                }

                .hero p {
                    font-size: 1rem;
                }
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <!-- Header -->
        <jsp:include page="../view/common/header-area.jsp"></jsp:include>

            <!-- Hero Section -->
            <section class="hero">
                <div class="container">
                    <h2>Welcome to JobPath</h2>
                    <p>Your path to finding the perfect job starts here.</p>
                    <!-- Search Bar -->
                    <form action="${pageContext.request.contextPath}/home" method="get" class="search-container">
                    <input type="text" name="searchJP" class="search-box" placeholder="Search by job title" value="${searchJP}">
                    <button type="submit" class="search-button">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </section>

        <!-- Job Listings Section -->
        <section class="py-5">
            <div class="container">
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-md-3 mb-4">
                        <div class="salary-filter-form">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-success">Show all Job Posting</a>
                            <!-- Category Filter -->
                            <form action="home" method="GET" class="mb-4 mt-4" id="categoryForm">
                                <div class="mb-3">
                                    <label for="jobCategory" class="form-label fw-bold">Job Category:</label>
                                    <select name="filter" id="jobCategory" class="form-select">
                                        <option value="">All Categories</option>
                                        <c:forEach var="category" items="${activeCategories}">
                                            <option value="${category.getId()}" ${category.getId() == selectedFilter ? 'selected' : ''}>
                                                ${category.getName()}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>

                            <!-- Salary Filter -->
                            <form action="home" method="GET" class="mt-4">
                                <h5 class="mb-3">Salary Range</h5>
                                <div class="row g-3">
                                    <div class="col-6">
                                        <label for="minSalary" class="form-label">Min ($):</label>
                                        <input type="number" 
                                               class="form-control" 
                                               id="minSalary" 
                                               name="minSalary" 
                                               value="${minSalary}"/>
                                    </div>
                                    <div class="col-6">
                                        <label for="maxSalary" class="form-label">Max ($):</label>
                                        <input type="number" 
                                               class="form-control" 
                                               id="maxSalary" 
                                               name="maxSalary" 
                                               value="${maxSalary}"/>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success w-100 mt-3">
                                    Apply Filters
                                </button>
                            </form>
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/home?sort=title&page=1&searchJP=${searchJP}" class="btn btn-success btn-sm">Filter by Title A-Z</a>
                                <a href="${pageContext.request.contextPath}/home?sort=postedDate&page=1&searchJP=${searchJP}" class="btn btn-success btn-sm">Filter by Post Date</a>
                            </div>
                        </div>
                    </div>

                    <!-- Job Listings -->
                    <div class="col-md-9">
                        <div class="row">
                            <c:if test="${empty listTop6}">
                                <div class="col-12 text-center">
                                    <h4>No jobs found matching your criteria</h4>
                                </div>
                            </c:if>
                            <c:forEach var="job" items="${listTop6}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <a href="${pageContext.request.contextPath}/viewdetail?action=details&idJP=${job.getJobPostingID()}" 
                                       class="job-card-link">
                                        <div class="card h-100">
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
                        <nav aria-label="Page navigation" class="footer-container">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage - 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo; Previous</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${i}&sort=${sortField}&searchJP=${searchJP}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage + 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Next">
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
