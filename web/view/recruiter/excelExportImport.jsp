<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
            .theh2{
                margin-top: 10%;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <%@ include file="../recruiter/sidebar-re.jsp" %>

        <!-- Header -->
        <%@ include file="../recruiter/header-re.jsp" %>

        <!-- Main content -->
        <div class="container content">
            <div>
                <h2 class="theh2">Export/Import Job Postings</h2>
                <hr>

                <!-- Back Button -->
                <div class="mb-3">
                    <button class="btn btn-secondary" onclick="window.history.back();">
                        <i class="fas fa-arrow-left"></i> Back to Job Postings
                    </button>
                </div>

                <!-- Export Excel Button -->
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/exportExcel" class="btn btn-success">
                        <i class="fas fa-file-excel"></i> Export Job Postings to Excel
                    </a>
                </div>

                <!-- Import Excel Form -->
                <form action="${pageContext.request.contextPath}/importExcel" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="excelFile" class="form-label">Import Job Postings from Excel</label>
                        <input class="form-control" type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls">
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-upload"></i> Import Excel File
                    </button>
                </form>
            </div>
        </div>

    </body>
</html>
