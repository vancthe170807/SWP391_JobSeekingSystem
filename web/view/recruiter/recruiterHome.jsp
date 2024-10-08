<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recruiter Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                background-color: #f8f9fa;
                font-size: 16px;
            }

            /* Sidebar styling */
            .sidebar {
                height: 100vh;
                width: 260px;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #fff;
                padding-top: 20px;
                overflow-y: auto;
                border-right: 1px solid #ddd;
            }

            /* JobPath brand inside sidebar */
            .sidebar .brand {
                font-size: 36px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 40px;
            }

            .sidebar .brand span {
                color: #28a745;
            }

            .sidebar a {
                padding: 15px 30px;
                text-decoration: none;
                font-size: 16px;
                color: #333;
                display: flex;
                align-items: center;
            }

            .sidebar a i {
                margin-right: 10px;
            }

            .sidebar a:hover {
                background-color: #f0f0f0;
            }

            /* Main content next to the sidebar */
            .main-content {
                margin-left: 260px;
                padding: 20px;
                min-height: 100vh;
            }

            /* Header styling */
            header {
                background-color: #f8f9fa;
                padding: 10px 30px;
                border-bottom: 1px solid #ddd;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }

            /* Centered Navigation Links */
            .nav-links {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
            }

            /* Removing space between letters in navigation links */
            .nav-item a {
                color: #007bff;
                font-weight: 500;
                margin: 0 20px;
                text-decoration: none;
                letter-spacing: -0.5px;
                font-size: 16px;
            }

            .nav-item a:hover {
                color: #0056b3;
                text-decoration: none;
            }

            .user-menu {
                display: flex;
                align-items: center;
            }

            .user-menu .notification {
                position: relative;
                color: #333;
                margin-right: 20px;
            }

            .user-menu .notification .badge {
                position: absolute;
                top: -5px;
                right: -10px;
                background-color: red;
                color: white;
                padding: 3px 6px;
                border-radius: 50%;
                font-size: 12px;
            }

            .user-menu .dropdown-toggle {
                color: #333;
                background-color: transparent;
                border: none;
            }

            .dropdown-menu {
                min-width: 260px;
            }

            .dropdown-menu a {
                color: #333;
            }

            .dropdown-menu a.logout {
                color: red;
            }

            .dropdown-menu a.logout:hover {
                background-color: #f8d7da;
            }

            /* Dashboard styling */
            .top-metrics {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
            }

            .metric-box {
                flex: 1;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                margin-right: 20px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
                transition: transform 0.2s;
            }

            .metric-box:last-child {
                margin-right: 0;
            }

            .metric-box h4 {
                font-size: 18px;
                color: #333;
            }

            .metric-box p {
                font-size: 28px;
                margin: 10px 0;
                color: #28a745;
            }

            .metric-box a {
                color: #007bff;
                text-decoration: none;
            }

            .metric-box:hover {
                transform: translateY(-5px);
            }

            /* Chart styling */
            .chart-container {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
                width: 80%;
                max-width: 800px;
                margin: 0 auto;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .main-content {
                    margin-left: 0;
                }

                .top-metrics {
                    flex-direction: column;
                }

                .metric-box {
                    margin-right: 0;
                    margin-bottom: 20px;
                }

                .nav-links {
                    justify-content: flex-start;
                }
            }

            .user-avatar {
                width: 32px; /* Set avatar size */
                height: 32px; /* Maintain height consistent with width */
                border-radius: 50%; /* Round avatar shape */
                object-fit: cover; /* Ensure image covers the space */
                margin-right: 8px; /* Add space between avatar and name */
            }

            .user-menu button {
                display: flex;
                align-items: center;
                gap: 10px; /* Add space between avatar and name */
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="brand">
                Job<span>Path</span>
            </div>
            <a href="${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp"><i class="fas fa-home"></i> Dashboard</a>
            <a href="#"><i class="fas fa-user"></i> Profile</a>
            <a href="#"><i class="fas fa-users"></i> Job Posting</a>
            <a href="#"><i class="fas fa-envelope"></i> Messages</a>
            <a href="#"><i class="fas fa-cog"></i> Settings</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header with Bootstrap Navbar -->
            <header>
                <nav>
                    <!-- Centered Navigation Links -->
                    <div class="nav-links">
                        <div class="nav-item">
                            <a href="#">Home</a>
                        </div>
                        <div class="nav-item">
                            <a href="#">About</a>
                        </div>
                        <div class="nav-item">
                            <a href="#">Services</a>
                        </div>
                        <div class="nav-item">
                            <a href="#">Contact</a>
                        </div>
                    </div>

                    <!-- User Profile Menu with Notification -->
                    <div class="user-menu">
                        <a href="javascript:void(0);" class="notification">
                            <i class="fas fa-bell"></i>
                            <span class="badge">5</span>
                        </a>
                        <button class="btn dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:choose>
                                <c:when test="${empty sessionScope.account.getAvatar()}">
                                    <!-- Show icon if no avatar is available -->
                                    <i class="fas fa-user-circle" style="font-size: 24px;"></i>
                                </c:when>
                                <c:otherwise>
                                    <!-- Avatar image -->
                                    <img src="${sessionScope.account.getAvatar()}" alt="User Avatar" class="user-avatar">
                                </c:otherwise>
                            </c:choose>
                            ${sessionScope.account.getFullName()}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
                            <li>
                                <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#profileModal">
                                    <i class="fas fa-user"></i> Profile
                                </a>
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Job Alerts</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Deactivate Account</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/authen/changePassword.jsp"><i class="fas fa-lock"></i> Change Password</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item logout" href="${pageContext.request.contextPath}/view/authen/logout.jsp"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
                        </ul>
                    </div>
                </nav>
            </header>

            <!-- Main Dashboard Content -->
            <div class="top-metrics">
                <div class="metric-box">
                    <h4>Job Postings</h4>
                    <p>5</p>
                    <a href="#">View details</a>
                </div>
                <div class="metric-box">
                    <h4>Pending Approvals</h4>
                    <p>0</p>
                    <a href="#">View details</a>
                </div>
                <div class="metric-box">
                    <h4>Articles</h4>
                    <p>0</p>
                    <a href="#">View details</a>
                </div>
                <div class="metric-box">
                    <h4>CV Submissions</h4>
                    <p>2</p>
                    <a href="#">View details</a>
                </div>
            </div>

            <!-- Applicants Statistics Chart Section -->
            <div class="chart-container my-5">
                <h4>Applicants Registered Statistics</h4>
                <canvas id="applicantChart"></canvas>
            </div>
        </div>

        <!-- Bootstrap Modal for Profile -->
        <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="profileModalLabel">Profile Information</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Profile information -->
                        <p><strong>Fullname:</strong> ${sessionScope.account.getFullName()}</p>
                        <p><strong>Email:</strong> ${sessionScope.account.getEmail()}</p>
                        <p><strong>Phone:</strong> ${sessionScope.account.getPhone()}</p>
                        <p><strong>Gender:</strong> ${sessionScope.account.isGender() == true ? 'Male' : 'Female'}</p>
                        <p><strong>Address:</strong> ${sessionScope.account.getAddress()}</p>
                        <p><strong>Date of birth:</strong> ${sessionScope.account.getDob()}</p>
                    </div>
                    <div class="modal-footer">
                        <a href="${pageContext.request.contextPath}/view/recruiter/editRecruiterProfile.jsp" class="btn btn-danger">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

        <!-- Chart.js Script to Generate Chart -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            var ctx = document.getElementById('applicantChart').getContext('2d');
            var applicantChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Tháng 1', 'Tháng 3', 'Tháng 5', 'Tháng 7', 'Tháng 9', 'Tháng 11'],
                    datasets: [{
                            label: 'Sessions',
                            data: [0, 1, 0, 0, 0, 0],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>

        <!-- Script to trigger modal when Profile is clicked -->
        <script>
            document.querySelector('.sidebar a[href="#"]').addEventListener('click', function (e) {
                e.preventDefault();
                var profileModal = new bootstrap.Modal(document.getElementById('profileModal'));
                profileModal.show();
            });
        </script>

    </body>
</html>
