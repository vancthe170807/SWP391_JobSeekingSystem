<header class="bg-light shadow-sm">
    <div class="container">
        <div class="d-flex align-items-center justify-content-between py-3">
            <div class="rts__logo">
                <a href="${pageContext.request.contextPath}/view/home.jsp">
                    <img class="logo__image" src="${pageContext.request.contextPath}/assets/img/logo/header__one.svg" width="160" height="40" alt="logo">
                </a>
            </div>
            <div class="rts__menu d-flex gap-4 align-items-center">
                <div class="navigation d-none d-lg-block">
                    <nav class="navigation__menu" id="offcanvas__menu">
                        <ul class="nav">
                            <!-- Add your navigation items here -->
                            <li class="nav-item">
                                <a class="nav-link" href="#">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">About</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Services</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Contact</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="header__right__btn d-flex gap-3">
                    <a href="${pageContext.request.contextPath}/authen" class="btn btn-success d-none d-sm-flex border-2">Sign In</a>
                    <button class="btn btn-outline-secondary d-md-block d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvas" aria-controls="offcanvas">
                        <i class="fa-sharp fa-regular fa-bars"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</header>
