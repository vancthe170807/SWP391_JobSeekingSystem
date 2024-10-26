<%-- 
    Document   : userHome
    Created on : Sep 16, 2024, 9:20:00 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <title>Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
    <body class="template-dashboard">
        <!-- header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- header area end -->

                <section class="hero d-flex align-items-center">
                    <div class="container">
                        <h2>Welcome to JobPath</h2>
                        <p>Your path to finding the perfect job starts here.</p>
                        <a href="${pageContext.request.contextPath}/listJob" class="btn explore-btn">Explore Jobs</a>
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
                                    <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${list.getJobPostingID()}" class="text-dark">
                                        <div class="card-body">
                                            <h4 class="blog-title">${list.getTitle()}</h4>
                                            <p class="btn btn-outline-success btn-sm">${list.getLocation()}</p>
                                            <p class="btn btn-success btn-sm">${list.getMinSalary()} $ - ${list.getMaxSalary()} $</p>
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
            <!-- content area end -->
            <!-- THEME PRELOADER START -->
        <jsp:include page="../common/footer.jsp"></jsp:include>
            <!-- THEME PRELOADER END -->
            <button type="button" class="btn btn-success position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
                <i class="fas fa-arrow-up"></i>
            </button>
            <!-- all plugin js -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
