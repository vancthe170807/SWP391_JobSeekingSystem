<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <!-- Navigation Links -->
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
        <a href="#" class="notification">
            <i class="fas fa-bell"></i>
            <span class="badge">5</span>
        </a>
        <button class="btn dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
            <c:if test="${empty sessionScope.account.getAvatar()}">
                <img src="${pageContext.request.contextPath}/assets/img/dashboard/avatar-mail.png" alt="Avatar" class="rounded-circle avatar-img">
            </c:if>
            <c:if test="${!empty sessionScope.account.getAvatar()}">
                <img src="${sessionScope.account.getAvatar()}" alt="User Avatar" class="avatar-img">
            </c:if>
            ${sessionScope.account.getFullName()}
        </button>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
            <li><a class="dropdown-item" href="#"><i class="fas fa-user"></i> Profile</a></li>
            <li><a class="dropdown-item" href="#"><i class="fas fa-bell"></i> Deactive account</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view/recruiter/changePW-re.jsp"><i class="fas fa-lock"></i> Change Password</a></li>
            <li><hr class="dropdown-divider"></li>
            <li>
                <a class="dropdown-item logout" href="${pageContext.request.contextPath}/view/authen/logout.jsp" style="color: red;">
                    <i class="fas fa-sign-out-alt" style="color: red;"></i> Log Out
                </a>
            </li>
        </ul>
    </div>
</header>
<style>
    /* Header styling */
    header {
        background-color: #389354;
        padding: 15px 30px;
        color: white;
        display: flex;
        justify-content: space-between; /* Space between navigation links and user menu */
        align-items: center;
        position: fixed;
        top: 0;
        left: 260px; /* This leaves room for the sidebar */
        width: calc(100% - 260px); /* Adjust the header width to not overlap the sidebar */
        z-index: 1000;
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

    /* Center the Navigation Links */
    .nav-links {
        display: flex;
        justify-content: center;
        flex-grow: 1;
    }

    .nav-item {
        margin: 0 20px;
    }

    .nav-item a {
        color: white;
        text-decoration: none;
    }

    .nav-item a:hover {
        color: #f8f9fa;
    }

    /* User Profile Menu */
    .user-menu {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .user-menu .notification {
        position: relative;
    }

    .user-menu .notification .badge {
        position: absolute;
        top: -10px;
        right: -10px;
        background-color: red;
        color: white;
        border-radius: 50%;
        padding: 5px;
    }

    .avatar-img {
        width: 30px; /* Adjust the width of the avatar */
        height: 30px; /* Adjust the height of the avatar */
        border-radius: 50%; /* Makes the avatar circular */
        object-fit: cover; /* Ensures the image covers the area without distortion */
        margin-right: 10px; /* Optional: Adds some space between the avatar and the name */
    }
</style>
<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
