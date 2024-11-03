<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seeker's Education</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                background-color: #f4f4f9;
            }
            h1 {
                font-size: 2rem;
                color: #333;
                margin-top: 20px;
                text-transform: uppercase;
                text-align: center;
            }
            table thead th {
                background-color: #28a745; /* Màu xanh cho tiêu đề bảng */
                color: #fff;
                text-align: center;
                padding: 10px;
                text-transform: uppercase;
            }
            tbody tr:hover {
                background-color: #e9ecef;
            }
            .badge-pending {
                background-color: #ffc107; /* Màu vàng cho trạng thái pending */
                color: #212529;
            }
            .badge-reject {
                background-color: #dc3545; /* Màu đỏ cho trạng thái reject */
                color: #fff;
            }
            .badge-resolved {
                background-color: #28a745; /* Màu xanh cho trạng thái resolved */
                color: #fff;
            }
            .btn-add {
                background-color: #28a745;
                color: #fff;
                margin-bottom: 20px;
            }
            .btn-add:hover {
                background-color: #218838;
            }
            .table td, .table th {
                vertical-align: middle;
            }

            .table .text-center {
                text-align: center;
            }
            thead {
                background-color: #28a745; /* Màu xanh lá cây */
                color: #fff;
            }

            thead th {
                color: #fff; /* Đảm bảo chữ màu trắng */
                text-align: center;
                padding: 10px;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body>
        <!-- Header Area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- Header Area End -->
            <div class="container mt-5">
                <h1>Seeker's Feedback</h1>
                <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addFeedbackModal">
                    <i class="fas fa-plus"></i> Create New Feedback
                </button>
                <table class="table table-hover mt-3 table-bordered">
                    <thead class="thead">
                        <tr>
                            <th>Content</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="feedback" items="${feedbackList}">
                        <c:if test="${feedback.getStatus() != 4}">
                            <tr>
                                <td>${feedback.getContentFeedback()}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${feedback.getStatus() == 1}">
                                            <span class="badge badge-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${feedback.getStatus() == 2}">
                                            <span class="badge badge-resolved">Resolved</span>
                                        </c:when>
                                        <c:when test="${feedback.getStatus() == 3}">
                                            <span class="badge badge-reject ">Reject</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-reject">Delete</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <form action="feedbackSeeker" method="post" style="display:inline;">
                                        <input type="hidden" name="feedbackId" value="${feedback.getFeedbackID()}"/>
                                        <input type="hidden" name="action" value="delete"/>
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                    <button type="button" class="btn btn-warning btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#editFeedbackModal" 
                                            data-feedback-id="${feedback.getFeedbackID()}"
                                            data-feedback-content="${feedback.getContentFeedback()}"
                                            <c:if test="${feedback.getStatus() != 1}">disabled</c:if>>
                                                <i class="fas fa-edit"></i> Edit
                                            </button>    
                                    </td>
                                </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- Add Feedback Modal -->
        <div class="modal fade" id="addFeedbackModal" tabindex="-1" aria-labelledby="addFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="feedbackSeeker?action=create" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addFeedbackModalLabel">Create New Feedback</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="feedbackContent" class="form-label">Feedback Content</label>
                                <textarea class="form-control" id="feedbackContent" name="content" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="action" value="create"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Submit Feedback</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Feedback Modal -->
        <div class="modal fade" id="editFeedbackModal" tabindex="-1" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="feedbackSeeker" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editFeedbackModalLabel">Edit Feedback</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editFeedbackContent" class="form-label">Feedback Content</label>
                                <textarea class="form-control" id="editFeedbackContent" name="content" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" id="editFeedbackId" name="feedbackId"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <jsp:include page="../common/footer.jsp"></jsp:include>



        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Gán dữ liệu cho modal edit khi nút Edit được ấn
            var editFeedbackModal = document.getElementById('editFeedbackModal');
            editFeedbackModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var feedbackId = button.getAttribute('data-feedback-id');
                var feedbackContent = button.getAttribute('data-feedback-content');

                var modalContent = editFeedbackModal.querySelector('#editFeedbackContent');
                var modalFeedbackId = editFeedbackModal.querySelector('#editFeedbackId');

                modalContent.value = feedbackContent;
                modalFeedbackId.value = feedbackId;
            });
        </script>
    </body>
</html>
