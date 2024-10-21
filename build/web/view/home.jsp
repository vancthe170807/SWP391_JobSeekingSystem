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
    <style>

        .hero {
            background: linear-gradient(rgba(40, 167, 69, 0.8), rgba(40, 167, 69, 0.8)), 
                        url('path/to/your/background/image.jpg') no-repeat center center/cover; /* Add a background image */
            color: white;
            padding: 120px 0;
            text-align: center;
            position: relative;
        }

        .hero h2 {
            font-size: 48px;
            font-weight: 700;
        }

        .hero p {
            font-size: 20px;
            margin: 20px 0;
        }

        .explore-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        .explore-btn:hover {
            background-color: #218838;
        }

        .blog-section h3 {
            font-size: 32px;
            font-weight: 600;
            color: #333;
            margin-bottom: 40px;
        }

        .blog-title {
            font-size: 24px;
            font-weight: 500;
        }

        .card {
            transition: transform 0.3s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        footer p {
            margin: 0;
        }
        .text-dark {
                text-decoration: none
            }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Header -->
    <jsp:include page="../view/common/header-area.jsp"></jsp:include>

    <!-- Hero Section -->
    <section class="hero d-flex align-items-center">
        <div class="container">
            <h2>Welcome to JobPath</h2>
            <p>Your path to finding the perfect job starts here.</p>
            <a href="explore.jsp" class="btn explore-btn">Explore Jobs</a>
        </div>
    </section>

    <!-- Blog Section -->
    <section class="blog-section py-5">
                    <div class="container">
                        <h3 class="text-center mb-5">Top 6 Job Latest from the Blog</h3>
                        <div class="row">
                        <c:if test="${not empty listTop6}">
                            <c:forEach var="list" items="${listTop6}">
                            <div class="col-md-4 mb-4">
                                <div class="card shadow-sm" style="text-decoration: none">
                                    <a href="${pageContext.request.contextPath}/viewdetail?action=details&idJP=${list.getJobPostingID()}" class="text-dark">
                                        <div class="card-body">
                                            <h4 class="blog-title">${list.getTitle()}</h4>
                                            <p class="btn btn-outline-success btn-sm">${list.getLocation()}</p>
                                            <p class="btn btn-success btn-sm">${list.getSalary()} $</p>
                                            <p style="font-style: italic">Post Date: ${list.getPostedDate()}</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            </c:forEach>
                            </c:if>
                        </div>
                        
                        <h3 class="text-center mb-5">Top 3 Company Latest from the Blog</h3>
                        <div class="row">
                        <c:if test="${not empty listTop3Company}">
                            <c:forEach var="listCompany" items="${listTop3Company}">
                            <div class="col-md-4 mb-4">
                                <div class="card shadow-sm" style="text-decoration: none">
                                    <a href="${pageContext.request.contextPath}/viewCompany?action=details&idCompany=${listCompany.getId()}" class="text-dark">
                                        <div class="card-body">
                                            <h4 class="blog-title">${listCompany.getName()}</h4>
                                            <p class="btn btn-outline-success btn-sm">${listCompany.getLocation()}</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </section>

    <!-- Footer -->
    <jsp:include page="../view/common/footer.jsp"></jsp:include>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
