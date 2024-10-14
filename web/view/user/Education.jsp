<%-- 
    Document   : Education
    Created on : Oct 13, 2024, 12:50:17 PM
    Author     : vanct
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seeker's Education</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
        <!-- Header Area End -->

        <div class='container mt-5 mb-5'>
            <!-- Display Success or Error Messages -->
            <c:if test="${not empty successEducation}">
                <div class="alert alert-success">
                    ${successEducation}
                </div>
            </c:if>
            <c:if test="${not empty errorEducation}">
                <div class="alert alert-danger">
                    ${errorEducation}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>

            <!-- Form for Adding or Updating Education -->
            <c:if test="${jobSeeker != null}">
                <form action="${pageContext.request.contextPath}/education" method="post">
                    <input type="hidden" name="action" value="${param.action == 'update-education' ? 'update-education' : 'add-education'}">

                    <div class="form-group mb-3">
                        <label for="institution">Institution:</label>
                        <input type="text" id="institution" name="institution" class="form-control" 
                               value="${not empty institution ? institution : (edu != null ? edu.institution : '')}" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="degree">Degree:</label>
                        <select id="degree" name="degree" class="form-control" required>
                            <option value="Bachelor" ${not empty degree && degree == 'Bachelor' ? 'selected' : (edu != null && edu.degree == 'Bachelor' ? 'selected' : '')}>Bachelor</option>
                            <option value="Master" ${not empty degree && degree == 'Master' ? 'selected' : (edu != null && edu.degree == 'Master' ? 'selected' : '')}>Master</option>
                            <option value="PhD" ${not empty degree && degree == 'PhD' ? 'selected' : (edu != null && edu.degree == 'PhD' ? 'selected' : '')}>PhD</option>
                            <option value="Khác" ${not empty degree && degree == 'Khác' ? 'selected' : (edu != null && edu.degree == 'Khác' ? 'selected' : '')}>Khác</option>
                        </select>
                    </div>

                    <div class="form-group mb-3">
                        <label for="fieldofstudy">Field of Study:</label>
                        <input type="text" id="fieldofstudy" name="fieldofstudy" class="form-control" 
                               value="${not empty fieldofstudy ? fieldofstudy : (edu != null ? edu.fieldOfStudy : '')}" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" 
                               value="${not empty startDate ? startDate : (edu != null ? edu.startDate : '')}" required>
                    </div>

                    <div class="form-group mb-3">
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" 
                               value="${not empty endDate ? endDate : (edu != null ? edu.endDate : '')}" ${edu != null && edu.endDate == null ? 'disabled' : ''}>
                        <!-- Hidden field to capture End Date value when disabled -->
                        <input type="hidden" id="hiddenEndDate" name="hiddenEndDate" value="${edu != null ? edu.endDate : ''}">
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="studying" name="studying" 
                               onclick="toggleEndDate()" ${edu != null && edu.endDate == null ? 'checked' : ''}>
                        <label class="form-check-label" for="studying">Currently Studying (No End Date)</label>
                    </div>

                    <button type="submit" class="btn btn-primary">${param.action == 'update-education' ? 'Update' : 'Add'}</button>
                </form>
            </c:if>
        </div>

        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>

        <script>
            function toggleEndDate() {
                var checkBox = document.getElementById("studying");
                var endDate = document.getElementById("endDate");
                var hiddenEndDate = document.getElementById("hiddenEndDate");

                if (checkBox.checked) {
                    endDate.disabled = true;
                    endDate.value = '';  // Clear the value if disabled
                    hiddenEndDate.value = 'N/A';  // Set a special value for no End Date
                } else {
                    endDate.disabled = false;
                    hiddenEndDate.value = endDate.value;  // Sync hidden field with the date field
                }
            }

            // Initialize the form based on the checkbox state on page load
            window.onload = function() {
                toggleEndDate();
            };

            // Sync hidden field with End Date field on form submission
            document.querySelector('form').addEventListener('submit', function () {
                var endDate = document.getElementById("endDate");
                var hiddenEndDate = document.getElementById("hiddenEndDate");

                // If the End Date is not disabled, sync the value
                if (!endDate.disabled) {
                    hiddenEndDate.value = endDate.value;
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </html>
    