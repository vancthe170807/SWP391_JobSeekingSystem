<%@page import="model.CV"%>
<%@page import="model.JobSeekers"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seeker's CV</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- Header area end -->

            <div class="container mt-5 mb-5">
                <h2>CV Management</h2>

                <h2>${jobSeeker != null && cv != null ? "Update Your CV" : "Upload Your CV"}</h2>

            <c:if test="${not empty errorCV}">
                <div class="alert alert-danger">
                    ${errorCV}
                </div>
            </c:if>

            <c:if test="${not empty successCV}">
                <div class="alert alert-success">
                    ${successCV}
                </div>
            </c:if>
            
            <c:if test="${jobSeeker != null && cv != null}">
                <iframe src="${cv.getFilePath()}" width="100%" height="600px" style="border: none;"></iframe>
            </c:if>

            <form action="${pageContext.request.contextPath}/cv" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="${jobSeeker != null && cv != null ? 'update-cv' : 'upload-cv'}" />
                <div class="mb-3">
                    <label for="cvFile" class="form-label">Select CV File</label>
                    <input type="file" class="form-control" id="cvFile" name="cvFile" accept=".pdf" required>
                </div>
                <button type="submit" class="btn btn-success">
                    ${jobSeeker != null && cv != null ? "Update CV" : "Upload CV"}
                </button>
            </form>

            
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
