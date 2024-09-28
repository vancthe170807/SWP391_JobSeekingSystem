<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JobPath - Home</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                font-family: Arial, sans-serif;
                line-height: 1.6;
            }

            body {
                display: flex;
                flex-direction: column;
                background-color: #f4f7fc;
            }

            /* Header */
            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px 0;
                width: 100%;
            }

            .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .logo .highlight {
                color: #28a745;
            }

            nav ul {
                list-style: none;
                display: flex;
            }

            nav ul li {
                margin: 0 15px;
            }

            nav ul li a {
                text-decoration: none;
                color: #333;
                font-size: 16px;
            }

            nav ul li a:hover {
                color: #28a745;
            }

            .sign-in-btn {
                background-color: #28a745;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
            }

            .sign-in-btn:hover {
                background-color: #218838;
            }

            /* Hero Section */
            .hero {
                background-color: #e9ecef;
                padding: 100px 0;
                text-align: center;
                flex-grow: 1;
            }

            .hero h2 {
                font-size: 36px;
                color: #333;
            }

            .hero p {
                font-size: 18px;
                margin: 20px 0;
            }

            .explore-btn {
                background-color: #28a745;
                color: white;
                padding: 10px 30px;
                text-decoration: none;
                border-radius: 5px;
                font-size: 18px;
            }

            .explore-btn:hover {
                background-color: #218838;
            }

            /* Blog Section */
            .blog-section {
                padding: 50px 0;
                background-color: #ffffff;
            }

            .blog-section h3 {
                text-align: center;
                font-size: 28px;
                margin-bottom: 30px;
            }

            .blog-list {
                display: flex;
                justify-content: space-between;
            }

            .blog-item {
                background-color: white;
                padding: 20px;
                width: 48%;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }

            .blog-item h4 a {
                text-decoration: none;
                color: #333;
                font-size: 20px;
            }

            .blog-item h4 a:hover {
                color: #28a745;
            }

            .blog-item p {
                font-size: 14px;
                color: #666;
                margin-top: 10px;
            }

            /* Footer */
            footer {
                background-color: #343a40;
                color: white;
                padding: 20px 0;
                text-align: center;
                width: 100%;
                margin-top: auto; /* Giúp footer tự động nằm dưới cùng */
            }
            footer p {
                margin: 0;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container header-container">
                <div class="logo">
                    <!-- Bỏ logo -->
                    <h1>Job<span class="highlight">Path</span></h1>
                </div>
                <nav>
                    <ul>
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="blog.jsp">Blog</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                        <a href="${pageContext.request.contextPath}/view/authen/login.jsp" class="sign-in-btn">Sign In</a>
                    </ul>

                </nav>
            </div>
        </header>

        <main>
            <div class="hero">
                <div class="container">
                    <h2>Welcome to JobPath</h2>
                    <p>Your path to finding the perfect job starts here.</p>
                    <a href="explore.jsp" class="explore-btn">Explore Jobs</a>
                </div>
            </div>

            <section class="blog-section">
                <div class="container">
                    <h3>Latest from the Blog</h3>
                    <div class="blog-list">
                        <div class="blog-item">
                            <h4><a href="blog1.jsp">Blog Title 1</a></h4>
                            <p>Summary of blog post 1...</p>
                        </div>
                        <div class="blog-item">
                            <h4><a href="blog2.jsp">Blog Title 2</a></h4>
                            <p>Summary of blog post 2...</p>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <div class="container">
                <p>&copy; 2024 JobPath. All rights reserved. By group of 3 people of class SE1868-NJ</p>
            </div>
        </footer>
    </body>
</html>
