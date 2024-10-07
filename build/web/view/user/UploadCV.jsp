<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upload or Update Your CV</title>

        <!-- Common CSS and External Libraries -->
        <jsp:include page="../common/user/common-css-user.jsp"></jsp:include>

            <!-- Include your own CSS/JS -->
            <style>
                .tab-content {
                    display: none;
                }
                .tab-content.active {
                    display: block;
                }
                .notice {
                    padding: 15px;
                    background-color: #f9f9f9;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                }

                .notice ul {
                    margin: 10px 0;
                    padding-left: 20px;
                }

                .notice li {
                    margin-bottom: 10px;
                }

                .notice strong {
                    color: #333;
                    font-weight: 600;
                }

            </style>
        </head>
        <body class="template-dashboard">
            <!-- header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- header area end -->

            <!-- Content Area -->
            <div class="dashboard__content d-flex">
                <!-- Sidebar -->
            <jsp:include page="../common/user/sidebar-user.jsp"></jsp:include>
                <!-- Sidebar - End -->

                <div class="dashboard__right">
                    <div class="dash__content ">
                        <!-- Sidebar menu -->
                        <div class="sidebar__menu d-md-block d-lg-none">
                            <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                        </div>
                        <!-- Sidebar menu end -->

                        <!-- Tabs Navigation -->
                        <div class="my__profile__tab bg-white radius-16">
                            <nav>
                                <div class="nav nav-tabs">
                                    <a class="nav-link active" href="#info" onclick="showTab('cv-file')">CV File</a>
                                    <a class="nav-link" href="#education" onclick="showTab('education')">Education</a>
                                    <a class="nav-link" href="#skills" onclick="showTab('skills')">Skills & Experience</a>
                                    <a class="nav-link" href="#portfolio" onclick="showTab('portfolio')">Portfolio</a>
                                    <a class="nav-link" href="#awards" onclick="showTab('awards')">Awards</a>
                                </div>
                            </nav>

                            <!-- CV File Upload Form -->
                            <div class="tab-content active" id="cv-file">
                                <form action="uploadCV" method="post">
                                    <div class="info__top align-items-start flex-column">
                                        <!-- File Upload Section -->
                                        <div class="select__image">
                                            <label for="file" class="file-upload__label__two">
                                                <span>
                                                    <i class="fa-light fa-file-arrow-up"></i>
                                                    <b><u>Click To Upload</u></b> or Drag and Drop
                                                    <br>
                                                    Maximum File Size: 10 MB
                                                </span>
                                            </label>
                                            <input type="file" class="file-upload__input__two" id="file" required>
                                        </div>

                                        <!-- Included CV Files -->
                                        <div class="notice">
                                            <ul>
                                                <li><strong>Please upload your CV in PDF format.</strong></li>
                                                <li><strong>Ensure that your CV content fits on a single page (A4 size).</strong></li>
                                                <li>
                                                    <strong>Make sure your CV includes all relevant information:</strong>
                                                    <ul style="margin-left: 20px; list-style-type: disc;">
                                                        <li>Personal details (Name, Contact Information)</li>
                                                        <li>Education</li>
                                                        <li>Work experience</li>
                                                        <li>Skills</li>
                                                        <li>Certifications (if applicable)</li>
                                                        <li>References (optional)</li>
                                                    </ul>
                                                </li>
                                                <li><strong>Maximum file size: [10 MB].</strong></li>
                                                <li><strong>Only PDF files are accepted for the upload.</strong></li>
                                            </ul>
                                        </div>

                                    </div>
                                    <div class="info__field">
                                        <button type="button" class="rts__btn" onclick="window.location.href = '${pageContext.request.contextPath}/view/user/userHome.jsp'">Cancel</button>
                                        <button type="submit" class="rts__btn fill__btn">Submit CV</button>
                                    </div>
                                </form>

                            </div>

                            <!-- Education Form -->
                            <div class="tab-content" id="education">
                                <form action="EducationServlet" method="post">
                                    <div class="info__field">
                                        <div class="row row-cols-sm-2 row-cols-1 g-3">
                                            <div class="rt-input-group">
                                                <label for="institution">Institution</label>
                                                <input type="text" id="institution" name="institution" placeholder="Institution" required value="">
                                            </div>
                                            <div class="rt-input-group">
                                                <label for="degree">Degree</label>
                                                <input type="text" id="degree" name="degree" placeholder="Degree" required value="">
                                            </div>
                                            <div class="rt-input-group">
                                                <label for="fieldOfStudy">Field of Study</label>
                                                <input type="text" id="fieldOfStudy" name="fieldOfStudy" placeholder="Field of Study" required value="">
                                            </div>
                                            <div class="rt-input-group">
                                                <label for="startDate">Start Date</label>
                                                <input type="date" id="startDate" name="startDate" placeholder="startDate" required value="">
                                            </div>
                                            <div class="rt-input-group">
                                                <label for="endDate">End Date</label>
                                                <input type="date" id="endDate" name="endDate" placeholder="End Date" required value="">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="info__field">
                                        <button type="submit" class="rts__btn fill__btn mx-0" onclick="document.querySelector('#profile-form').submit()">Save Education</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Skills & Experience Form -->
                            <div class="tab-content" id="skills">
                                <form action="SkillsServlet" method="post">
                                    <label for="skills">Skills</label>
                                    <textarea id="skills" name="skills" required></textarea><br>

                                    <label for="experience">Experience</label>
                                    <textarea id="experience" name="experience" required></textarea><br>

                                    <button type="submit">Save Skills & Experience</button>
                                </form>
                            </div>

                            <!-- Portfolio and Awards can follow the same pattern -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="d-flex justify-content-center mt-30">
                <p class="copyright">Copyright © 2024 All Rights Reserved by Group 4 - SE1868-NJ</p>
            </div>

            <!-- all plugin js -->
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>

        <script>
            function showTab(tabId) {
                // Hide all tabs
                document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));

                // Show the selected tab
                document.getElementById(tabId).classList.add('active');
            }
        </script>
    </body>
</html>
