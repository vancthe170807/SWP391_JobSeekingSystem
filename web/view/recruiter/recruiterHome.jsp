<%-- 
    Document   : recruiterHome
    Created on : Oct 4, 2024, 9:29:22 AM
    Author     : TuanTVHE173048
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Recruiter Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
            }

            .sidebar {
                height: 100vh;
                width: 250px;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #ffffff;
                border-right: 1px solid #eaeaea;
                padding-top: 20px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .sidebar .logo {
                display: flex;
                justify-content: center;
                margin-bottom: 40px;
            }

            .sidebar .logo span {
                font-size: 32px;
                font-weight: bold;
                color: #28a745;
            }

            .sidebar .logo span.second {
                color: #333;
            }

            .sidebar a {
                display: flex;
                align-items: center;
                padding: 15px;
                font-size: 16px;
                color: #333;
                text-decoration: none;
                width: 100%;
                padding-left: 30px;
            }

            .sidebar a:hover {
                background-color: #f1f1f1;
                color: #000;
            }

            .sidebar a i {
                margin-right: 15px;
                font-size: 18px;
            }

            .sidebar .active {
                background-color: #f8f9fa;
                border-left: 3px solid #28a745;
                color: #28a745;
            }

            .sidebar a span {
                font-size: 16px;
            }

            .main-content {
                margin-left: 260px;
                padding: 20px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .header h1 {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            .right-menu {
                display: flex;
                align-items: center;
            }

            .notification {
                position: relative;
                color: #333;
                text-decoration: none;
                margin-right: 20px;
            }

            .notification .badge {
                position: absolute;
                top: -5px;
                right: -5px;
                background-color: red;
                color: white;
                padding: 3px 6px;
                border-radius: 50%;
                font-size: 12px;
            }

            .dropdown-toggle {
                display: flex;
                align-items: center;
                color: #333;
                text-decoration: none;
            }

            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .dropdown-menu {
                width: 200px;
                padding: 10px;
            }

            .dropdown-menu .dropdown-item {
                padding: 10px;
                font-size: 16px;
                color: #333;
            }

            .dashboard-section {
                background-color: #fff;
                padding: 10px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 15px;
            }

            .dashboard-section h2 {
                font-size: 18px;
                margin-bottom: 15px;
            }

            .stats {
                display: flex;
                justify-content: space-between;
            }

            .stat-item {
                background-color: #f1f1f1;
                padding: 15px;
                border-radius: 8px;
                width: 24%;
                text-align: center;
            }

            .stat-item h3 {
                font-size: 16px;
                margin-bottom: 5px;
            }

            .table {
                font-size: 14px;
            }

            .table th,
            .table td {
                padding: 8px;
            }

            /* Thu nhỏ biểu đồ */
            #applicantChart {
                max-width: 1000px;
                max-height: 400px;
            }

            .user-info {
                display: flex;
                align-items: center;
            }

            .user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .user-info span {
                font-size: 16px;
                color: #333;
            }

            .user-info {
                text-decoration: none; /* Loại bỏ gạch dưới */
                color: inherit;        /* Giữ màu chữ mặc định */
            }

            .user-info:hover {
                text-decoration: none; /* Đảm bảo không có gạch dưới khi di chuột */
            }

        </style>
    </head>

    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <span>Job<span class="second">Path</span></span>
            </div>
            <a href="#" class="active"><i class="fas fa-th-large"></i><span>Dashboard</span></a>
            <a href="#"><i class="fas fa-user-circle"></i><span>Profile</span></a>
            <a href="#"><i class="fas fa-briefcase"></i><span>My Job</span></a>
            <a href="#"><i class="fas fa-upload"></i><span>Submit Job</span></a>
            <a href="#"><i class="fas fa-list"></i><span>Candidate List</span></a>
            <a href="#"><i class="fas fa-list-alt"></i><span>Candidate Shortlist</span></a>
            <a href="#"><i class="fas fa-envelope"></i><span>Message</span></a>
            <a href="#"><i class="fas fa-bell"></i><span>Candidate Alerts</span></a>
            <a href="#"><i class="fas fa-calendar-alt"></i><span>Meeting</span></a>
            <a href="#"><i class="fas fa-box"></i><span>Package</span></a>
            <a href="${pageContext.request.contextPath}/authen?action=change-password"><i class="fas fa-key"></i><span>Change Password</span></a>
            <a href="${pageContext.request.contextPath}/view/user/deactivateAccount.jsp"><i class="fas fa-trash"></i><span>Delete Account</span></a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <div class="header">
                <h1>Be a real recruiter</h1>
                <div class="right-menu">
                    <a href="#" class="notification">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span> <!-- Thêm biểu tượng thông báo với số lượng -->
                        Notifications
                    </a>
                    <div class="dropdown ml-3">
                        <a class="dropdown-toggle user-info" id="dropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:if test="${empty sessionScope.account.getAvatar()}">
                                <!-- Đường dẫn ảnh trống -->
                                <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="">
                            </c:if>

                            <c:if test="${!empty sessionScope.account.getAvatar()}">
                                <!-- Đường dẫn ảnh không trống -->
                                <img src="${sessionScope.account.getAvatar()}" alt="">
                            </c:if>

                            <span>${sessionScope.account.getFullName()}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                            <li><a class="dropdown-item" href="#">Dashboard</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/recruiter/viewRecruiterProfile.jsp">Profile</a></li>
                            <li><a class="dropdown-item" href="#">Job Alert</a></li>
                            <li><a class="dropdown-item" href="#">Shortlist Job</a></li>
                            <li><a class="dropdown-item" href="#">Packages</a></li>
                            <li><a class="dropdown-item" href="#">Message</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/authen?action=change-password">Change Password</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/authen/logout.jsp">Log Out</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/user/deactivateAccount.jsp">Delete Account</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Dashboard Section -->
            <div class="dashboard-section">
                <h2>Dashboard Overview</h2>
                <div class="stats">
                    <div class="stat-item">
                        <h3>Total Jobs</h3>
                        <p>15</p>
                        <button><a>Detail</a></button>
                    </div>
                    <div class="stat-item">
                        <h3>Applicants</h3>
                        <p>250</p>
                        <button><a>Detail</a></button>
                    </div>
                    <div class="stat-item">
                        <h3>Messages</h3>
                        <p>23</p>
                        <button><a>Detail</a></button>
                    </div>
                    <div class="stat-item">
                        <h3>Total posting</h3>
                        <p>7</p>
                        <button><a>Detail</a></button>
                    </div>
                </div>
            </div>

            <!-- Recent Applicants Section -->
            <div class="dashboard-section mt-5">
                <h2>Recent Applicants</h2>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Position Applied</th>
                            <th>Date Applied</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>Software Engineer</td>
                            <td>2024-10-01</td>
                            <td><span class="badge badge-success">Reviewed</span></td>
                        </tr>
                        <tr>
                            <td>Jane Smith</td>
                            <td>Data Scientist</td>
                            <td>2024-10-02</td>
                            <td><span class="badge badge-warning">Pending</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Applicant Statistics Chart -->
            <div class="dashboard-section mt-5">
                <h2>Applicant Statistics</h2>
                <canvas id="applicantChart"></canvas>
            </div>
        </div>

        <!-- Popper.js (required for Bootstrap dropdowns) -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>

        <!-- ChartJS for charts -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Chart Initialization -->
        <script>
            var ctx = document.getElementById('applicantChart').getContext('2d');
            var applicantChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
                    datasets: [{
                            label: 'Applicants',
                            data: [12, 19, 3, 5, 2, 3, 9, 12, 15, 10],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    maintainAspectRatio: false,
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>
