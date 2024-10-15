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
                <h1 class="text-center">Education Profile</h1>

                <!-- Display error messages if any -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <!-- Display success messages if any -->
            <c:if test="${not empty successEducation}">
                <div class="alert alert-success" role="alert">
                    ${successEducation}
                </div>
            </c:if>

            <!-- Display education details -->
            <c:if test="${not empty institution}">
                <div class="card" style="max-width: 500px; align-self: center">
                    <div class="card-header">
                        Education Details
                    </div>
                    <div class="card-body">
                        <p><strong>Institution:</strong> ${institution}</p>
                        <p><strong>Degree:</strong> ${degree}</p>
                        <p><strong>Field of Study:</strong> ${fieldOfStudy}</p>
                        <p><strong>Start Date:</strong> ${startDate}</p>
                        <c:if test="${not empty endDate}">
                            <p><strong>End Date:</strong> ${endDate}</p>
                        </c:if>
                        <c:if test="${empty endDate}">
                            <p><strong>End Date:</strong> N/A</p>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <!-- Button to trigger the modal for adding/updating education -->
            <button type="button" class="btn btn-success mt-4" data-bs-toggle="modal" data-bs-target="#educationModal">
                ${institution != null ? "Update Education" : "Add Education"}
            </button>
        </div>

        <!-- Modal for adding/updating education -->
        <div class="modal fade" id="educationModal" tabindex="-1" aria-labelledby="educationModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="educationModalLabel">${institution != null ? "Update Education" : "Add Education"}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/education" method="post" id="educationForm">
                            <input type="hidden" name="action" value="${institution != null ? 'update-education' : 'add-education'}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                <label for="institution">Institution</label>
                                <input type="text" class="form-control" id="institution" name="institution" value="${institution}" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="degree">Degree</label>
                                <select class="form-select" id="degree" name="degree" required>
                                    <option value="Bachelor" ${degree == 'Bachelor' ? 'selected' : ''}>Bachelor</option>
                                    <option value="Master" ${degree == 'Master' ? 'selected' : ''}>Master</option>
                                    <option value="PhD" ${degree == 'PhD' ? 'selected' : ''}>PhD</option>
                                    <option value="Different" ${degree == 'Different' ? 'selected' : ''}>Different</option>
                                </select>
                            </div>

                            <div class="form-group mb-3">
                                <label for="fieldofstudy">Field of Study</label>
                                <input type="text" class="form-control" id="fieldofstudy" name="fieldofstudy" value="${fieldOfStudy}" required>
                            </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}">
                                <input type="hidden" name="hiddenEndDate" value="${endDate == null ? 'N/A' : endDate}">
                            </div>
                            <span style="color: green; font-style: italic">If you haven't graduated yet and are still in school, you can enter your anticipated graduation date here. You may update this information at a later time if your completion date changes. Regards</span>
                                </div>
                            </div>
                            
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" form="educationForm" class="btn btn-success">${institution != null ? "Update Education" : "Add Education"}</button>
                    </div>
                </div>
            </div>
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
            window.onload = function () {
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
