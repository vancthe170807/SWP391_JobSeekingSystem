<%-- 
    Document   : sidebar-re
    Created on : Oct 9, 2024, 4:18:01 PM
    Author     : nhanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<div class="sidebar">
    <div class="brand">
        Job<span>Path</span>
    </div>
    <a href="${pageContext.request.contextPath}/view/recruiter/recruiterHome.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/recruiter/viewRecruiterProfile.jsp"><i class="fas fa-user"></i> Profile</a>
<!--    <a href="${pageContext.request.contextPath}/view/recruiter/jobPosting.jsp"><i class="fas fa-users"></i> Job Posting</a>-->
    <a href="${pageContext.request.contextPath}/view/recruiter/jobPost-manager.jsp"><i class="fas fa-users"></i> Job Posting</a>
    <a href="#"><i class="fas fa-envelope"></i> Messages</a>
    <a href="#"><i class="fas fa-cog"></i> Settings</a>
</div>
<style>
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

</style>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
