<%-- 
    Document   : editUserProfile
    Created on : Sep 18, 2024, 5:45:45 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!--css-->
        <jsp:include page="../common/user/common-css-user.jsp"></jsp:include>
        </head>
        <body class="template-dashboard">
            <!-- header area -->
        <jsp:include page="../common/user/header-user.jsp"></jsp:include>
            <!-- header area end -->

            <!-- content area -->
            <div class="dashboard__content d-flex">
                <!--side bar-->
                <div class="dashboard__left">
                    <!-- sidebar menu -->
                    <div class="dashboard__sidebar">
                        <div class="dash__menu">
                            <ul>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">
                                    <svg width="21" height="26" viewBox="0 0 21 26" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M10.466 10.4661C13.08 10.4661 15.199 8.34702 15.199 5.73303C15.199 3.11905 13.08 1 10.466 1C7.85202 1 5.73297 3.11905 5.73297 5.73303C5.73297 8.34702 7.85202 10.4661 10.466 10.4661Z"
                                        stroke="#595959" />
                                    <path
                                        d="M19.9321 19.3413C19.9321 22.2817 19.9321 24.6659 10.4661 24.6659C1 24.6659 1 22.2817 1 19.3413C1 16.4009 5.23843 14.0166 10.4661 14.0166C15.6937 14.0166 19.9321 16.4009 19.9321 19.3413Z"
                                        stroke="#595959" />
                                    </svg> Profile </a>
                            </li>
                        </ul>
                    </div>
                    <div class="dash__logout">
                        <figure class="logout__image">
                            <img src="assets/img/dashboard/logout.png" alt="">
                        </figure>
                        <a class="logout__btn" href="#"><i class="rt-login"></i> Logout</a>
                    </div>
                </div>
                <!-- sidebar menu end -->
            </div>
            <!--side bar end-->

            <!--content-main-->
            <div class="dashboard__right">
                <div class="dash__content ">
                    <!-- sidebar menu -->
                    <div class="sidebar__menu d-md-block d-lg-none">
                        <div class="sidebar__action"><i class="fa-sharp fa-regular fa-bars"></i> Sidebar</div>
                    </div>
                    <!-- sidebar menu end -->

                    <div class="my__profile__tab radius-16 bg-white">
                        <nav>
                            <div class="nav nav-tabs">
                                <a class="nav-link active" href="#info">My Details</a>
                                <a class="nav-link " href="#social">Social Links</a>
                                <a class="nav-link" href="#address">Contact Information</a>                         
                            </div>
                        </nav>
                        <div class="my__details" id="info">
                            <div class="info__top">
                                <div class="author__image">
                                    <img src="${pageContext.request.contextPath}/assets/img/dashboard/proifle.svg" alt="">
                                </div>
                                <div class="select__image">
                                    <label for="file" class="file-upload__label">Upload New Photo</label>
                                    <input type="file" class="file-upload__input" id="file" required>
                                </div>

                                <div class="delete__data">
                                    <i class="fa-light fa-trash-can"></i>
                                </div>
                            </div>
                            <div class="info__field">
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="name">Full Name</label>
                                        <input type="text" id="name" placeholder="Full Name" required>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" placeholder="jobpath@gmqail.com" required>
                                    </div>
                                </div>
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="phone">Phone</label>
                                        <input type="text" id="phone" placeholder="+880171234567" required>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="dob">Date of Birth</label>
                                        <input type="date" id="dob" required>
                                    </div>
                                </div>
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="gender">Gender</label>
                                        <select name="gender" id="gender" class="form-select">
                                            <option value="male">Male</option>
                                            <option value="female">Female</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="age">Age</label>
                                        <select name="age" id="age" class="form-select">
                                            <option value="18">18</option>
                                            <option value="19">19</option>
                                            <option value="20">20</option>
                                            <option value="21">21</option>
                                            <option value="22">22</option>
                                            <option value="23">23</option>
                                            <option value="24">24</option>
                                            <option value="25">25</option>
                                            <option value="26">26</option>
                                            <option value="27">27</option>
                                            <option value="28">28</option>
                                            <option value="29">29</option>
                                            <option value="30">30</option>
                                            <option value="31">31</option>
                                            <option value="32">32</option>
                                            <option value="33">33</option>
                                            <option value="34">34</option>
                                            <option value="35">35</option>
                                            <option value="36">36</option>
                                            <option value="37">37</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- salary type -->
                                <div class="row row-cols-sm-3 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="salary">Salary Type</label>
                                        <select name="salary" id="salary" class="form-select">
                                            <option value="hourly">Hourly</option>
                                            <option value="monthly">Monthly</option>
                                            <option value="yearly">Yearly</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="jobcat">Job Category</label>
                                        <select name="jobcat" id="jobcat" class="form-select">
                                            <option value="1">Select Job Category</option>
                                            <option value="2">it consultancy</option>
                                            <option value="3">Job Category 2</option>
                                            <option value="4">Job Category 3</option>
                                            <option value="5">Job Category 4</option>
                                            <option value="6">Job Category 5</option>
                                            <option value="7">Job Category 6</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="jobtitle">Job Title</label>
                                        <input type="text" id="jobtitle" placeholder="Enter Job Title" required>
                                    </div>
                                </div>
                                <!-- salary type end -->

                                <!-- qualification -->
                                <div class="row row-cols-sm-3 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="qualification">qualification</label>
                                        <select name="qualification" id="qualification" class="form-select">
                                            <option value="1">Select Qualification</option>
                                            <option value="2">SSC</option>
                                            <option value="3">HSC</option>
                                            <option value="4">Diploma</option>
                                            <option value="5">Graduation</option>
                                            <option value="6">Post Graduation</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="lang">Language</label>
                                        <select name="lang" id="lang" class="form-select">
                                            <option value="1">Select Language</option>
                                            <option value="2">English</option>
                                            <option value="3">Hindi</option>
                                            <option value="4">French</option>
                                            <option value="5">Spanish</option>
                                            <option value="6">Chinese</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="tags">Tags</label>
                                        <input type="text" id="tags" placeholder="Enter Tags" required>
                                    </div>
                                </div>
                                <!-- qualification end -->

                                <!-- experience -->
                                <div class="row row-cols-sm-2 row-cols-1 g-3">
                                    <div class="rt-input-group">
                                        <label for="experience">experience</label>
                                        <select name="experience" id="experience" class="form-select">
                                            <option value="1">Experience</option>
                                            <option value="2">1 Year</option>
                                            <option value="3">2 Year</option>
                                            <option value="4">3 Year</option>
                                            <option value="5">4 Year</option>
                                        </select>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="show">Show my profile</label>
                                        <select name="show" id="show" class="form-select">
                                            <option value="1">Yes</option>
                                            <option value="2">No</option>
                                        </select>
                                    </div>

                                </div>
                                <!-- experience end -->
                                <!-- editor area -->
                                <div class="rt-input-group">
                                    <label for="editor">Candidate Description</label>
                                    <textarea name="editor" id="editor" class="form-control" placeholder="Enter Description" cols="10" rows="5"></textarea>
                                </div>
                                <!-- editor area end -->
                            </div>
                        </div>
                    </div>
                    <h6 class="fw-medium mt-4 mb-4">Social Links</h6>
                    <div class="social__links p-30 radius-16 bg-white" id="social">
                        <div class="info__field">
                            <div class="row row-cols-sm-2 row-cols-1 g-3">
                                <div class="rt-input-group">
                                    <label for="Facebook">Facebook</label>
                                    <input type="url" id="Facebook" placeholder="WWW.facebook.com/jobpath" required>
                                </div>
                                <div class="rt-input-group">
                                    <label for="Linkedin">Linkedin</label>
                                    <input type="url" id="Linkedin" placeholder="WWW.Linkedin.com/jobpath" required>
                                </div>
                            </div>
                            <div class="row row-cols-sm-2 row-cols-1 g-3">
                                <div class="rt-input-group">
                                    <label for="Behance">Behance</label>
                                    <input type="url" id="Behance" placeholder="WWW.behance.com/jobpath" required>
                                </div>
                                <div class="rt-input-group">
                                    <label for="Dribbble">Dribbble</label>
                                    <input type="url" id="Dribbble" placeholder="WWW.dribbble.com/jobpath" required>
                                </div>
                                <div class="d-block mt-30">
                                    <a href="#" class="added__social__link">Add Another Network</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- address area -->
                    <h6 class="fw-medium mt-4 mb-4">Address / Location</h6>
                    <div class="social__links radius-16 p-30 bg-white" id="address">
                        <div class="row row-cols-md-2 row-cols-lg-2 row-cols-1 g-30">
                            <div class="info__field">
                                <div class="rt-input-group">
                                    <label for="Country">Country</label>
                                    <select name="Country" id="Country" class="form-select">
                                        <option value="1">Select Country</option>
                                        <option value="2">Bangladesh</option>
                                        <option value="3">India</option>
                                        <option value="4">Pakistan</option>
                                        <option value="5">Nepal</option>
                                        <option value="6">Srilanka</option>
                                        <option value="7">China</option>
                                        <option value="8">USA</option>
                                    </select>
                                </div>
                                <div class="rt-input-group">
                                    <label for="State">State</label>
                                    <select name="State" id="State" class="form-select">
                                        <option value="1">Select State</option>
                                        <option value="2">Dhaka</option>
                                        <option value="3">Chittagong</option>
                                        <option value="4">Sylhet</option>
                                        <option value="5">Rajshahi</option>
                                        <option value="6">Khulna</option>
                                        <option value="7">Barishal</option>
                                        <option value="8">Mymensingh</option>
                                    </select>
                                </div>
                                <div class="rt-input-group">
                                    <label for="pr">Present Address</label>
                                    <input type="text" id="pr" placeholder="2715 Ash Dr. San Jose,USA" required>
                                </div>
                                <div class="rt-input-group">
                                    <label for="ps">Postal Code</label>
                                    <input type="text" id="ps" placeholder="8340" required>
                                </div>
                                <div class="rt-input-group">
                                    <label for="lt">latitude</label>
                                    <input type="text" id="lt" placeholder="0.000000" required>
                                </div>
                            </div>
                            <div>
                                <div class="info__field">
                                    <h6 class="font-20 fw-medium mb-2 mt-4 mt-md-0">My location</h6>
                                    <div class="gmap">
                                        <div class="user__location">
                                            <iframe src="https://maps.google.com/maps?width=100%25&amp;height=600&amp;hl=en&amp;q=reacthemes+(reacthemes)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe>
                                        </div>
                                    </div>
                                    <div class="rt-input-group">
                                        <label for="longitude">longitude</label>
                                        <input type="text" id="longitude" placeholder="0.00.000.0000" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="info__field">
                            <button type="submit" class="rts__btn fill__btn mx-0">Save Profile</button>
                        </div>
                    </div>
                    <!-- address area end -->
                </div>
                <div class="d-flex justify-content-center mt-30">
                    <p class="copyright">Copyright © 2024 All Rights Reserved by jobpath</p>
                </div>
            </div>
        </div>
        <!-- content area end -->



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
                    <a href="#" class="small__btn no__fill__btn border-6 font-xs" aria-label="Login Button" data-bs-toggle="modal" data-bs-target="#loginModal"> <i class="rt-login"></i>Sign In</a>
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
        <jsp:include page="../common/user/common-js-user.jsp"></jsp:include>

    </body>
</html>
