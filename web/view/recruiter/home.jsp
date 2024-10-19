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
            <h3 class="text-center mb-5">Latest from the Blog</h3>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h4 class="blog-title"><a href="blog1.jsp" class="text-dark">Blog Title 1</a></h4>
                            <p class="text-muted">Summary of blog post 1...</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h4 class="blog-title"><a href="blog2.jsp" class="text-dark">Blog Title 2</a></h4>
                            <p class="text-muted">Summary of blog post 2...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="../view/common/footer.jsp"></jsp:include>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
