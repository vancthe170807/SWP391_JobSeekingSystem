<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<footer>
    <p>© 2024 JobPath. All rights reserved.</p>
    <a href="#">Privacy Policy</a>
    <a href="#">Terms of Service</a>
</footer>

<style>
    /* Setup flexbox layout for body and html */
    html, body {
        height: 100%; /* Ensure the body takes full height */
        margin: 0;
        display: flex;
        flex-direction: column;
    }

    /* Main container to push the footer down */
    .job-posting-container {
        flex: 1; /* Make sure content area grows to fill available space */
        padding: 20px;
        margin-left: 260px; /* Adjust for sidebar */
        background-color: #f5f5f5;
    }

    /* Footer styling */
    footer {
        background-color: #389354;
        color: white;
        text-align: center;
        padding: 20px 0;
        width: calc(100% - 260px); /* Adjusting for sidebar width */
        margin-left: 260px; /* Prevent footer from overlapping the sidebar */
        position: relative;
        bottom: 0;
    }

    footer a {
        color: white;
        text-decoration: none;
        margin: 0 15px;
    }

    footer a:hover {
        text-decoration: underline;
    }
</style>


