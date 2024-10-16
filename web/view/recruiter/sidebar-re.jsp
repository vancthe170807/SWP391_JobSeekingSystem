<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<div class="sidebar">
    <div class="brand">
        Job<span>Path</span>
    </div>
    <a href="${pageContext.request.contextPath}/Dashboard"><i class="fas fa-home"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/view/recruiter/viewRecruiterProfile.jsp"><i class="fas fa-user"></i> Profile</a>
    <a href="${pageContext.request.contextPath}/jobPost"><i class="fas fa-user"></i> Job Posting</a>
    <a href="${pageContext.request.contextPath}/view/recruiter/seeker-manager.jsp"><i class="fas fa-user"></i> Seeker manager</a>
    <a href="${pageContext.request.contextPath}/view/recruiter/feedback-re.jsp"><i class="fas fa-user"></i> Feed Back</a>

    <!--    <a href="#" onclick="submitForm(); return false;" class="job-posting-link">
            <i class="fas fa-users"></i> Job Posting
        </a>
        <form id="jobPostingForm" action="${pageContext.request.contextPath}/jobPost?action=listJobPosting" method="post" style="display:none;">
            <input type="hidden" name="action" value="listJobPosting" />
        </form>-->

</div>
<header>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</header>
<style>
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
        padding: 15px 20px; /* Điều chỉnh padding giữa icon và chữ */
        text-decoration: none;
        font-size: 16px;
        color: #333;
        display: flex;
        align-items: center; /* Căn giữa theo chiều dọc */
    }

    .sidebar a i {
        margin-right: 15px; /* Điều chỉnh khoảng cách giữa icon và chữ */
        font-size: 15px;
        display: inline-block;
    }

    .sidebar a:hover {
        background-color: #f0f0f0;
    }

    /* Đảm bảo icon và chữ thẳng hàng */
    .sidebar a i, .sidebar a span {
        display: flex;
        align-items: center; /* Đảm bảo icon và text được căn giữa */
    }

</style>


<script>
//    function submitForm() {
//        document.getElementById("jobPostingForm").submit();
//    }
</script>
