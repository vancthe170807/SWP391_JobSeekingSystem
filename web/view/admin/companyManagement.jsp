<%-- 
    Document   : companyManagement
    Created on : Oct 8, 2024, 10:46:34 PM
    Author     : Admin
--%>

<%-- 
    Document   : adminHome
    Created on : Sep 15, 2024, 4:26:38 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <!--css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        

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
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
                        <div class="container-fluid" style="margin-bottom: 20px; margin-top: 20px">
                            <div class="dash__content">
                                <!-- sidebar menu -->
                                <div class="sidebar__menu d-md-block d-lg-none">
                                    <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                                </div>
                                <!-- sidebar menu end -->
                                <div class="dash__overview">

                                    <h6 class="fw-medium mb-30 text-center fs-2">COMPANY MANAGEMENT</h6>
                                    <!--drop-down filter company-->
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <!-- Form filter -->
                                        <form action="${pageContext.request.contextPath}/companies" method="GET" class="d-flex align-items-center">
                                        <label for="company-filter" class="me-2">Filter</label>
                                        <select id="company-filter" name="filter" class="form-select me-3" onchange="this.form.submit()">
                                            <option value="all" ${param.filter == null || param.filter == 'all' ? 'selected' : ''}>All Companies</option>
                                            <option value="accept" ${param.filter == 'accept' ? 'selected' : ''}>Active Companies</option>
                                            <option value="violate" ${param.filter == 'violate' ? 'selected' : ''}>Inactive Companies</option>
                                        </select>
                                    </form>

                                    <!-- Error message and Add button -->
                                    <div class="d-flex align-items-center">
                                        <!-- Error message (displayed in red) -->
                                        <span class="text-danger me-3">${requestScope.error}</span>

                                        <!-- Button add new company -->
                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCompanyModal">
                                            <i class="fas fa-plus"></i> Add New Company
                                        </button>
                                    </div>
                                </div>

                                <hr/>
                                <!--search company-->
                                <form action="${pageContext.request.contextPath}/companies" method="GET">
                                    <div class="d-flex justify-content-center mb-3">
                                        <input type="hidden" name="filter" value="${param.filter != null ? param.filter : 'all'}"> <!-- Thay đổi tại đây -->
                                        <input type="text" id="searchCompany"  name="searchQuery" class="form-control" style="width: 60%;" placeholder="Search for name...">
                                        <button type="submit" class="btn btn-primary ms-2">Search</button>
                                    </div>
                                </form>

                                <!--search company end-->
                                <div class="modal fade" id="addCompanyModal" tabindex="-1" aria-labelledby="addCompanyModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header bg-success text-white">
                                                <h5 class="modal-title" id="addCompanyModalLabel">Add New Company</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <!--form add company-->
                                                <form id="addCompanyForm" action="${pageContext.request.contextPath}/companies?action=add-company" method="POST" enctype="multipart/form-data">

                                                    <div class="mb-3">
                                                        <label for="companyName" class="form-label">Company Name</label>
                                                        <input type="text" class="form-control" id="companyName" name="name" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="companyDescription" class="form-label">Description</label>
                                                        <textarea class="form-control" id="companyDescription" name="description" rows="3"></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="companyLocation" class="form-label">Location</label>
                                                        <input type="text" class="form-control" id="companyLocation" name="location">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="verificationStatus" class="form-label">Verification Status</label>
                                                        <select class="form-select" id="verificationStatus" name="verificationStatus">
                                                            <option value="accept">Accept</option>
                                                            <option value="violate">Violate</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="businessLicense" class="form-label">Business License</label>
                                                        <input type="file" class="form-control" id="businessLicense" name="businessLicense" accept="image/*" required="">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-success">Add Company</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="seeker-list">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Company Name</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Table rows will go here (populated dynamically) -->
                                            <c:forEach items="${listCompanies}" var="company">
                                                <tr>
                                                    <!-- CompanyName Column -->

                                                    <td>
                                                        ${company.getName()}
                                                    </td>
                                                    <!-- Status Column -->
                                                    <td>
                                                        <div class="form-check form-switch">
                                                            <input class="form-check-input" type="checkbox" role="switch" 
                                                                   id="flexSwitchCheck${company.id}" 
                                                                   ${company.verificationStatus ? 'checked' : ''} 
                                                                   data-company-id="${company.id}">
                                                            <label class="form-check-label" for="flexSwitchCheck${company.id}"></label>
                                                        </div>
                                                    </td>
                                                    <!--Edit Column-->
                                                    <td>
                                                        <!-- Nút Edit với biểu tượng búa -->
                                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editCompanyModal${company.id}">
                                                            <i class="fas fa-hammer"></i> 
                                                        </button>

                                                        <!-- Nút View với biểu tượng con mắt -->
                                                        <a href="${pageContext.request.contextPath}/companies?action=view&id=${company.id}" class="btn btn-primary me-2">
                                                            <i class="fas fa-eye"></i> 
                                                        </a>
                                                    </td>

                                                </tr>
                                                <!--Modal Edit Company--> 
                                            <div class="modal fade" id="editCompanyModal${company.id}" tabindex="-1" aria-labelledby="editCompanyModalLabel${company.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header bg-success text-white">
                                                            <h5 class="modal-title" id="editCompanyModalLabel${company.id}">Edit Company Profile</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <!--Form to edit company details--> 
                                                            <form action="${pageContext.request.contextPath}/companies?action=edit-company" method="POST">
                                                                <input type="hidden" name="id-company" value="${company.id}">

                                                                <div class="mb-3">
                                                                    <label for="companyName${company.id}" class="form-label">Company Name</label>
                                                                    <input type="text" class="form-control" id="companyName${company.id}" name="name" value="${company.getName()}" required>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label for="companyDescription${company.id}" class="form-label">Description</label>
                                                                    <textarea class="form-control" id="companyDescription${company.id}" name="description" rows="3" required>${company.getDescription()}</textarea>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label for="companyLocation${company.id}" class="form-label">Location</label>
                                                                    <input type="text" class="form-control" id="companyLocation${company.id}" name="location" value="${company.getLocation()}" required>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success">Save Changes</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center" id="pagination">
                                            <c:forEach begin="1" end="${pageControl.getTotalPages()}" var="pageNumber">
                                                <li>
                                                    <a class="page-link page-number" href="${pageControl.getUrlPattern()}page=${pageNumber}">${pageNumber}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item">
                                                <a class="page-link" href="#" id="next-page" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>

                                    <!-- Add more seekers here -->
                                </div>
                            </div>
                        </div>
                        <!-- content area end -->

                    </div>
                    <!-- Back to Top Button -->
                    <button type="button" class="btn btn-primary position-fixed" id="rts-back-to-top" style="bottom: 20px; right: 20px;">
                        <i class="fas fa-arrow-up"></i>
                    </button>

                    <!-- Footer -->

                </div>
            </div>
        </div>



        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
            <div class="offcanvas-header p-0 mb-5 mt-4">
                <a href="index.html" class="offcanvas-title" id="offcanvasLabel">
                    <img src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" alt="logo">
                </a> 
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <!-- login offcanvas -->
            <div class="mb-4 d-block d-sm-none">
                <div class="header__right__btn d-flex justify-content-center gap-3">
                    <!--                    <a href="#" class="small__btn no__fill__btn border-6 font-xs" aria-label="Login Button" data-bs-toggle="modal" data-bs-target="#loginModal"> <i class="rt-login"></i>Sign In</a>-->
                    <a href="#" class="small__btn d-xl-flex fill__btn border-6 font-xs" aria-label="Job Posting Button">Add Job</a>
                </div>
            </div>
            <div class="offcanvas-body p-0">
                <div class="rts__offcanvas__menu overflow-hidden">
                    <div class="offcanvas__menu"></div>
                </div>
                <p class="max-auto font-20 fw-medium text-center text-decoration-underline mt-4">Our Social Links</p>
                <div class="rts__social d-flex justify-content-center gap-3 mt-3">
                    <a href="https://facebook.com"  aria-label="facebook">
                        <i class="fa-brands fa-facebook"></i>
                    </a>
                    <a href="https://instagram.com"  aria-label="instagram">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="https://linkedin.com"  aria-label="linkedin">
                        <i class="fa-brands fa-linkedin"></i>
                    </a>
                    <a href="https://pinterest.com"  aria-label="pinterest">
                        <i class="fa-brands fa-pinterest"></i>
                    </a>
                    <a href="https://youtube.com"  aria-label="youtube">
                        <i class="fa-brands fa-youtube"></i>
                    </a>
                </div>
            </div>
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
                                            $(document).ready(function () {
                                                $('.form-check-input').change(function () {
                                                    var companyId = $(this).data('company-id');
                                                    var isActive = this.checked;
                                                    var label = $(this).siblings('.form-check-label');

                                                    $.ajax({
                                                        url: '${pageContext.request.contextPath}/companies',
                                                        type: 'POST',
                                                        data: {
                                                            action: isActive ? 'accept' : 'violate',
                                                            'id-company': companyId
                                                        },
                                                        success: function (response) {
                                                            console.log('Company status updated successfully');
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error updating company status');
                                                            $(this).prop('checked', !isActive);
                                                        }
                                                    });
                                                });
                                            });
        </script>
        <script>
            // Get the current page parameter from the URL
            function getCurrentPage() {
                const urlParams = new URLSearchParams(window.location.search);
                return parseInt(urlParams.get('page')) || 1;
            }

            // Add click event listener to the "Next" button
            document.getElementById('next-page').addEventListener('click', function (event) {
                event.preventDefault();
                const currentPage = getCurrentPage();
                const totalPages = ${pageControl.getTotalPages()};
                if (currentPage < totalPages) {
                    window.location.href = '${pageControl.getUrlPattern()}page=' + (currentPage + 1);
                }
            });

            // Highlight the current page
            const pageLinks = document.querySelectorAll('.page-number');
            const currentPage = getCurrentPage();
            pageLinks.forEach(function (link, index) {
                if (index + 1 === currentPage) {
                    link.parentElement.classList.add('active');
                } else {
                    link.parentElement.classList.remove('active');
                }
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</html>
