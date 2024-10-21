<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Profile</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Styling for the profile container */
            .main-content {
                margin-left: 260px; /* Account for the sidebar */
                padding: 14px 20px 20px; /* Account for the fixed header */
                min-height: calc(100vh - 100px); /* Adjust height to ensure space for footer */
                background-color: #f8f9fa; /* Light background */
                display: flex;
                justify-content: center; /* Center the content horizontally */
                align-items: center; /* Center the content vertically */
                box-sizing: border-box;
            }

            .profile-card {
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
                max-width: 800px; /* Increase width of the profile card */
                width: 100%;
                padding: 40px;
                display: flex;
                flex-direction: column;
                align-items: center; /* Center avatar and content */
                position: relative;
            }

            .profile-avatar {
                margin-bottom: 20px;
                text-align: center;
            }

            .profile-avatar img {
                width: 200px; /* Increase avatar size */
                height: 200px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .profile-avatar h4 {
                font-size: 28px; /* Larger font size */
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }

            .profile-avatar p {
                font-size: 18px; /* Larger font size */
                color: #666;
            }

            .profile-info {
                width: 100%;
                margin-top: 20px;
            }

            .profile-info table {
                width: 100%;
                margin-bottom: 20px;
            }

            .profile-info td {
                padding: 12px; /* Increased padding */
                font-size: 16px; /* Larger font size */
                color: #333;
            }

            .profile-info td:first-child {
                font-weight: bold;
                width: 30%;
                color: #555;
                text-transform: uppercase;
            }

            .edit-profile-btn {
                text-align: center;
                margin-top: 20px;
            }

            .edit-profile-btn a {
                padding: 12px 30px; /* Larger padding for button */
                font-size: 16px;
                background-color: #28a745;
                color: #fff;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }
            
            .edit-profile-btn a:hover {
                background-color: #218838;
            }

            /* Profile card hover effect */
            .profile-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 20px rgba(0, 0, 0, 0.15);
            }

            /* Additional responsive styling */
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding-top: 80px;
                }

                header {
                    width: 100%;
                    left: 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main Content Section -->
        <div class="main-content">
            <div class="profile-card">
                <!-- Profile Avatar -->
                <div class="profile-avatar">
                    <c:if test="${empty sessionScope.account.avatar}">
                        <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="rounded-circle">
                    </c:if>
                    <c:if test="${!empty sessionScope.account.avatar}">
                        <img src="${sessionScope.account.avatar}" alt="Avatar" class="rounded-circle">
                    </c:if>
                    <h4>${sessionScope.account.getFullName()}</h4>
                    <p>Recruiter Information</p>
                </div>

                <!-- Profile Information -->
                <div class="profile-info">
                    <table>
                        <tr>
                            <td>Name:</td>
                            <td>${sessionScope.account.getFullName()}</td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>${sessionScope.account.getEmail()}</td>
                        </tr>
                        <tr>
                            <td>Phone:</td>
                            <td>${sessionScope.account.getPhone()}</td>
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td>${sessionScope.account.isGender() == true ? 'Male' : 'Female'}</td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td>${sessionScope.account.getAddress()}</td>
                        </tr>
                        <tr>
                            <td>Birth:</td>
                            <td>${sessionScope.account.getDob()}</td>
                        </tr>
                    </table>
                </div>

                <!-- Edit Profile Button -->
                <div class="edit-profile-btn">
                    <a href="${pageContext.request.contextPath}/view/recruiter/editRecruiterProfile.jsp">
                        <i class="fas fa-edit"></i> Edit Profile
                    </a>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../recruiter/footer-re.jsp" %>

    </body>
</html>
