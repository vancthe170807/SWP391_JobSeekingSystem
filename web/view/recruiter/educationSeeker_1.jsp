<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Education</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .education-container {
                max-width: 800px;
                margin: 80px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .education-header {
                text-align: center;
                margin-bottom: 20px;
            }
            .education-header h2 {
                color: #007b5e;
                font-weight: bold;
            }
            .education-item {
                border-bottom: 1px solid #ddd;
                padding: 15px 0;
            }
            .education-item:last-child {
                border-bottom: none;
            }
            .degree-img {
                max-width: 100px;
                height: auto;
                border-radius: 5px;
                margin-top: 10px;
            }
            .back-button {
                display: inline-block;
                margin-top: 20px;
                color: #007b5e;
                text-decoration: none;
                font-weight: bold;
            }
            .back-button:hover {
                color: #005f46;
            }
        </style>
    </head>
    <body>
        <div class="education-container">
            <%@ include file="../recruiter/sidebar-re.jsp" %>
            <%@ include file="../recruiter/header-re.jsp" %>

            <div class="education-header">
                <h2>Education Details</h2>
            </div>

            <c:forEach var="education" items="${educations}">
                <div class="education-item">
                    <p><strong>Institution:</strong> ${education.institution}</p>
                    <p><strong>Degree:</strong> ${education.degree}</p>
                    <p><strong>Field of Study:</strong> ${education.fieldOfStudy}</p>
                    <p><strong>Start Date:</strong> <fmt:formatDate value="${education.startDate}" pattern="dd-MM-yyyy" /></p>
                    <p><strong>End Date:</strong> <fmt:formatDate value="${education.endDate}" pattern="dd-MM-yyyy" /></p>

                    <!-- Display Degree Image if available -->
                    <c:if test="${not empty education.degreeImg}">
                        <p><strong>Degree Image:</strong></p>
                        <img src="${pageContext.request.contextPath}/${education.degreeImg}" alt="Degree Image" class="degree-img">
                    </c:if>
                </div>
            </c:forEach>

            <!-- Back Button -->
            <div class="text-center">
                <a href="javascript:history.back()" class="back-button">
                    <i class="fas fa-arrow-left"></i> Back to Applications
                </a>
            </div>
        </div>

        <%@ include file="../recruiter/footer-re.jsp" %>
    </body>
</html>
