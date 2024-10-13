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
            /* Main content next to the sidebar */
            .main-content {
                margin-left: 260px;
                padding: 20px;
                min-height: 100vh;
            }

            /* Main content next to the sidebar */
            .main-content {
                margin-left: 260px; /* Keeps content away from the sidebar */
                padding: 80px 20px 20px; /* Adjust top padding for the fixed header */
                min-height: 100vh;
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

            .metric-box:hover {
                transform: translateY(-5px);
            }

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
                .top-metrics {
                    flex-direction: column;
                }

                .metric-box {
                    margin-bottom: 20px;
                    margin-right: 0;
                }

                .nav-links {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header with Bootstrap Navbar -->
            <%@ include file="../recruiter/header-re.jsp" %>
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

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

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
            document.querySelectorAll('.sidebar a').forEach(link => {
                link.addEventListener('click', function (e) {
                    if (this.getAttribute('href') === '#') {
                        e.preventDefault();
                        var profileModal = new bootstrap.Modal(document.getElementById('profileModal'));
                        profileModal.show();
                    }
                });
            });
        </script>
    </body>
</html>