<%-- 
    Document   : adminHome
    Created on : Sep 15, 2024, 4:26:38 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.CompanyDAO"%>
<%@page import="dao.AccountDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Account"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <!-- Add custom styles -->
        <style>
            .seeker-status.active {
                color: green; /* Active seekers in green */
                font-weight: bold;
            }
            .seeker-status.inactive {
                color: red; /* Inactive seekers in red */
                font-weight: bold;
            }
            .table-responsive {
                margin-top: 20px;
            }
            .verify-badge {
                font-size: 1.2em;
            }
            .verify-badge.verified {
                color: green;
            }
            .verify-badge.unverified {
                color: red;
            }
            .table-title {
                text-align: center;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <!-- header area -->
        <jsp:include page="../common/admin/header-admin.jsp"></jsp:include>
            <!-- header area end -->

            <!-- content area -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <!--Side bar-->
                    <jsp:include page="../common/admin/sidebar-admin.jsp"></jsp:include>
                        <!--side bar-end-->
                    </div>

                    <div class="col-md-9">
                        <!--content-main can fix-->
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2 class="mt-4 mb-4 table-title">Recruiter Confirm</h2>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <thead class="table-success">
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Verify</th>
                                                    <th>Company</th>
                                                    <th>Position</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                         // Tạo một đối tượng CompanyDAO
                                            CompanyDAO companyDao = new CompanyDAO();
                                         // tao doi tuong account 
                                            AccountDAO accountDao = new AccountDAO();
                                            %>
                                            <c:forEach items="${listConfirm}" var="recruiter">
                                                <c:if test="${recruiter.isIsVerify() == false}">
                                                    <c:set var="accountId" value="${recruiter.getAccountID()}" />
                                                    <%int accountId = (Integer) pageContext.getAttribute("accountId");%>
                                                    <tr>
                                                        <td>
                                                            <%
                                                                Account account = accountDao.findUserById(accountId);
                                                            %>
                                                            <%= account.getFullName() %>
                                                        </td>
                                                        <td>
                                                        <td>
                                                            <form action="${pageContext.request.contextPath}/confirm" method="POST" onsubmit="return confirmAction()">
                                                                <input type="hidden" name="recruiterId" value="${recruiter.getRecruiterID()}">
                                                                <button type="submit" class="btn btn-success">Confirm</button>
                                                            </form>
                                                        </td>

                                                        </td>
                                                        <td>

                                                            <%
                                                                List<Company> companies = companyDao.getCompanyNameByAccountId(accountId);
                                                                String companyName = "";
                                                                if (companies != null && !companies.isEmpty()) {
                                                                    companyName = companies.get(0).getName(); // Lấy tên công ty từ danh sách
                                                                }
                                                            %>
                                                            <%= companyName %> <!-- Hiển thị tên công ty -->
                                                        </td>
                                                        <td>${recruiter.getPosition()}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--content-main can fix end-->
                </div>

                <!-- Back to Top Button -->


                <!-- Footer -->
            </div>
        </div>

        <!-- Rest of the file remains unchanged -->

        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
            <!-- Offcanvas content remains unchanged -->
        </div>

        <!-- THEME PRELOADER START -->
        <div class="loader-wrapper">
            <div class="loader">
            </div>
            <div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>
        </div>
        <!-- THEME PRELOADER END -->
        <button type="button" class="rts__back__top" id="rts-back-to-top">
            <i class="fas fa-arrow-up"></i>
        </button>
        <!-- all plugin js -->
        <jsp:include page="../common/admin/common-js-admin.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
        function confirmAction() {
                return confirm("Are you sure you want to confirm this recruiter?");
         }
        </script>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>