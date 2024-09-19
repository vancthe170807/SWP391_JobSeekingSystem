<%-- 
    Document   : footer
    Created on : Sep 15, 2024, 3:24:59 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer class="rts__section  footer__home__one">
    <div class="container">
        <div class="row">
            <div class="footer__wrapper d-flex flex-wrap flex-column flex-sm-row gap-4 gap-md-0 gap-sm-3 justify-content-between pt-60 pb-60">
                <div class="rts__footer__widget max-320">
                    <a href="index.html" class="footer__logo" aria-label="logo">
                        <img src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
                    </a>
                    <p class="mt-4">Whether you're an experienced professional or a fresh graduate eager to dive into the workforce, we have something for everyone.
                    </p>
                </div>

                <!-- footer menu -->
                <div class="rts__footer__widget max-content">
                    <div class="font-20 fw-medium mb-3 h6">Links</div>
                    <ul class="list-unstyled">
                        <li><a href="job-list-1.html" aria-label="footer__menu__link">Browse Jobs</a></li>
                        <li><a href="candidate-1.html" aria-label="footer__menu__link">Browse Candidates</a></li>
                        <li><a href="blog-1.html" aria-label="footer__menu__link">Blog & News</a></li>
                        <li><a href="faq.html" aria-label="footer__menu__link">FAQ Question</a></li>
                        <li><a href="#" aria-label="footer__menu__link">Job Alerts</a></li>
                    </ul>
                </div>

                <div class="rts__footer__widget max-content">
                    <div class="font-20 fw-medium mb-3 h6 ">Contact Us</div>
                    <ul class="list-unstyled mb-3">
                        <li><a href="#"><i class="fa-light fa-location-dot"></i>Thach That district, Ha Noi city</a></li>
                        <li><a href="callto:+880171234578"><i class="fa-light fa-phone"></i>+(61) 545-432-234</a></li>
                        <li><a href="mailto:jobpath@gmail.com"><i class="fa-light fa-envelope"></i> jobpath@gmail.com</a></li>
                    </ul>
                    <div class="font-20 fw-medium mb-20 text-dark">Social Link</div>
                    <div class="rts__social d-flex gap-4">
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

                <!-- newsletter form -->
                <div class="rts__footer__widget max-320">
                    <div class="font-20 fw-medium mb-3 h6 ">Subscribe Our Newsletter</div>
                    <p class="br-sm-none">Subscribe Our Newsletter get <br> Update our New Course</p>
                    <form action="#" class="d-flex align-items-center justify-content-between mt-4 newsletter">
                        <input type="email" name="semail" id="semail" placeholder="Enter your email" required>
                        <button type="submit" class="rts__btn fill__btn">Subscribe</button>
                    </form>
                </div>
                <!-- newsletter form end -->

            </div>
        </div>
    </div>
    <div class="rts__copyright">
        <div class="container">
            <p class="text-center fw-medium py-4">
                Copyright &copy; 2024 All Rights Reserved by Group 4 - SE1868-NJ
            </p>
        </div>
    </div>
</footer>

