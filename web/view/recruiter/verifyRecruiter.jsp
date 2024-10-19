<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Submit Verification Request</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Submit Verification Request</h2>
            <form action="${pageContext.request.contextPath}/verifyRecruiter" method="post">
                <!-- Nhập ID công ty thay vì chọn từ danh sách -->
                <div class="mb-3">
                    <label for="companyId" class="form-label">Enter Company ID</label>
                    <input type="text" class="form-control" id="companyId" name="companyId" required>
                </div>
                
                <div class="mb-3">
                    <label for="position" class="form-label">Position</label>
                    <input type="text" class="form-control" id="position" name="position" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Submit Request</button>
                
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                </div>
            </form>

            <!-- Hiển thị thông báo sau khi submit -->
            <c:if test="${requestScope.verify != null}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.verify}
                </div>
            </c:if>
        </div>
    </body>
</html>
