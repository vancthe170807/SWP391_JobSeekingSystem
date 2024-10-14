<%-- 
    Document   : footer-re
    Created on : Oct 9, 2024, 4:08:52 PM
    Author     : nhanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer>
    <p>© 2024 JobPath. All rights reserved.</p>
    <a href="#">Privacy Policy</a>
    <a href="#">Terms of Service</a>
</footer>
<style>
    footer {
        background-color: #389354;
        color: white;
        text-align: center;
        padding: 20px 0;
        position: relative;
        width: calc(100% - 260px); /* Adjusting for the sidebar width */
        margin-left: 260px; /* Offset to avoid footer overlapping the sidebar */
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

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

