<%-- 
    Document   : ListJob
    Created on : Oct 17, 2024, 4:37:01 PM
    Author     : vanct
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Explore Jobs</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
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
            .filter-buttons {
                text-align: center;
                margin-bottom: 30px;
            }
            .filter-buttons .btn-filter {
                margin: 5px;
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                text-decoration: none;
                transition: background-color 0.3s;
            }
            .filter-buttons .btn-filter:hover {
                background-color: #0056b3;
            }
            .card {
                background-color: white;
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            h3 {
                color: #333;
                font-size: 24px;
            }
            .breadcrumb {
                background-color: #e9ecef;
                padding: 10px 20px;
                border-radius: 10px;
            }
            .btn-sm {
                font-size: 14px;
                padding: 5px 10px;
            }
            .pagination {
                margin-top: 40px;
            }
            .page-link {
                color: #007bff;
                padding: 10px 15px;
            }
            .page-link:hover {
                background-color: #007bff;
                color: white;
            }
            .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }
            .card h3 {
                color: #333;
                font-size: 24px;
                white-space: nowrap; /* Giữ tiêu đề trên một dòng */
                overflow: hidden; /* Ẩn nội dung thừa nếu quá dài */
                text-overflow: ellipsis; /* Thêm dấu "..." khi nội dung quá dài */
            }

            .card .info-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; /* Để các thông tin không vượt quá chiều rộng màn hình */
            }

            .card .info-group p {
                margin-bottom: 0; /* Loại bỏ margin dưới của các thông tin để căn đều */
                flex: 1; /* Để các thông tin lương, địa điểm và ngày đăng/đóng có chiều rộng linh hoạt */
                min-width: 120px; /* Giới hạn chiều rộng tối thiểu cho các phần tử */
                text-align: center; /* Căn giữa nội dung */
            }

        </style>
    </head>
    <body>
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>

            <div class="container mt-5 mb-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/HomeSeeker">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Explore Jobs</li>
                </ol>
            </nav>

            <!-- Search Bar -->
            <form action="${pageContext.request.contextPath}/listJob" method="get" class="search-container">
                <input type="text" name="searchJP" class="search-box" placeholder="Search by job title" value="${searchJP}">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <a href="${pageContext.request.contextPath}/listJob?sort=title&page=1&searchJP=${searchJP}" class="btn-filter">Filter by Title A-Z</a>
                <a href="${pageContext.request.contextPath}/listJob?sort=postedDate&page=1&searchJP=${searchJP}" class="btn-filter">Filter by Post Date</a>
            </div>

            <!-- Job Listing -->
            <c:forEach var="i" items="${listJobPosting}">
                <a href="${pageContext.request.contextPath}/jobPostingDetail?action=details&idJP=${i.getJobPostingID()}" style="text-decoration: none">
                <div class="card">
                    <h3>${i.getTitle()}</h3>
                    <div class="info-group">
                    <p class="btn btn-outline-success btn-sm">${i.getMinSalary()} $ - ${i.getMaxSalary()} $</p>
                    <p class="btn btn-secondary btn-sm">${i.getLocation()}</p>
                    <p class="btn btn-outline-secondary">
                        <fmt:formatDate value="${i.getPostedDate()}" pattern="dd/MM/yyyy"/> 
                        - 
                        <fmt:formatDate value="${i.getClosingDate()}" pattern="dd/MM/yyyy"/>
                    </p>
                    </div>
                </div>
                </a>
            </c:forEach>

            <!-- Pagination -->
            <nav aria-label="Page navigation" class="footer-container">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/listJob?page=${currentPage - 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="${pageContext.request.contextPath}/listJob?page=${i}&sort=${sortField}&searchJP=${searchJP}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/listJob?page=${currentPage + 1}&sort=${sortField}&searchJP=${searchJP}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <jsp:include page="../common/footer.jsp"></jsp:include>

        <!-- Bootstrap JS and Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
