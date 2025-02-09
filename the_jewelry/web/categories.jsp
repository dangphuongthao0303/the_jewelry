<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Categories</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="Wish shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="styles/categories.css">
        <link rel="stylesheet" type="text/css" href="styles/categories_responsive.css">
    </head>
    <body>

        <div class="super_container">

            <!-- Header -->

            <%@ include file="header.jsp" %>

            <!-- Menu -->

            <%@ include file="menu.jsp" %>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/categories.jpg" data-speed="0.8"></div>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="home_container">
                                <div class="home_content">
                                    <div class="home_title">Woman</div>
                                    <div class="breadcrumbs">
                                        <ul>
                                            <li><a href="index.html">Home</a></li>
                                            <li>Woman</li>
                                            <li>Accessories</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products -->

            <div class="products">
                <div class="container">
                    <div class="row">
                        <div class="col-12">

                            <!-- Sidebar Left -->

                            <div class="sidebar_left clearfix">

                                <!-- Categories -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Categories</div>
                                    <div class="sidebar_section_content">
                                        <ul>
                                            <% for (Category category : categories) { %>
                                            <li><a href="categories.jsp?category=<%= category.getCategoryId() %>">
                                                    <%= category.getCategoryName() %>
                                                </a></li>
                                                <% } %>
                                        </ul>
                                    </div>
                                </div>


                                <!-- Size -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Size</div>
                                    <div class="sidebar_section_content">
                                        <ul>
                                            <li><a href="#">Small S (30ML)</a></li>
                                            <li><a href="#">Medium M (50ML)</a></li>
                                            <li><a href="#">Large L (100ML)</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Price -->
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Price</div>
                                    <div class="sidebar_section_content">
                                        <div class="filter_price">
                                            <div id="slider-range" class="slider_range"></div>
                                            <p><input type="text" id="amount" class="amount" readonly style="border:0; font-weight:bold;"></p>
                                            <div class="clear_price_btn">Clear Price</div>
                                        </div>
                                    </div>
                                </div>


                                <!-- Size -->
                                <div class="sidebar_section sidebar_options">
                                    <div class="sidebar_section_content">

                                        <!-- Option Item -->
                                        <div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
                                            <div class="option_image"><img src="images/option_1.png" alt=""></div>
                                            <div class="option_content">
                                                <div class="option_title">30 Days Returns</div>
                                                <div class="option_subtitle">No questions asked</div>
                                            </div>
                                        </div>

                                        <!-- Option Item -->
                                        <div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
                                            <div class="option_image"><img src="images/option_2.png" alt=""></div>
                                            <div class="option_content">
                                                <div class="option_title">Free Delivery</div>
                                                <div class="option_subtitle">On all orders</div>
                                            </div>
                                        </div>

                                        <!-- Option Item -->
                                        <div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
                                            <div class="option_image"><img src="images/option_3.png" alt=""></div>
                                            <div class="option_content">
                                                <div class="option_title">Secure Payments</div>
                                                <div class="option_subtitle">No need to worry</div>
                                            </div>
                                        </div>

                                        <!-- Option Item -->
                                        <div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
                                            <div class="option_image"><img src="images/option_4.png" alt=""></div>
                                            <div class="option_content">
                                                <div class="option_title">24/7 Support</div>
                                                <div class="option_subtitle">Just call us</div>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </div>

                            <div class="current_page">Woman's Fashion</div>
                        </div>
                        <div class="col-12">
                            <div class="product_sorting clearfix">
                                <div class="view">
                                    <div class="view_box box_view"><i class="fa fa-th-large" aria-hidden="true"></i></div>
                                    <div class="view_box detail_view"><i class="fa fa-bars" aria-hidden="true"></i></div>
                                </div>
                                <div class="sorting">
                                    <ul class="item_sorting">
                                        <li>
                                            <span class="sorting_text">Show all</span>
                                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                                            <ul>
                                                <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><span>Show All</span></li>
                                                <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><span>Price</span></li>
                                                <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "stars" }'><span>Stars</span></li>
                                            </ul>
                                        </li>
                                        <li>
                                            <span class="sorting_text">Show</span>
                                            <span class="num_sorting_text">12</span>
                                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                                            <ul>
                                                <li class="num_sorting_btn"><span>3</span></li>
                                                <li class="num_sorting_btn"><span>6</span></li>
                                                <li class="num_sorting_btn"><span>12</span></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row products_container">
                        <div class="col">

                            <!-- Products -->
                            <%@ include file="listProduct.jsp" %>
                        </div>

                    </div>

                    <div class="row page_num_container">
                        <div class="col text-right">
                            <ul class="page_nums">
                                <li><a href="#">01</a></li>
                                <li class="active"><a href="#">02</a></li>
                                <li><a href="#">03</a></li>
                                <li><a href="#">04</a></li>
                                <li><a href="#">05</a></li>
                            </ul>
                        </div>
                    </div>

                </div>

                <!-- Sidebar Right -->

                <div class="sidebar_right clearfix">

                    <!-- Promo 1 -->
                    <div class="sidebar_promo_1 sidebar_promo d-flex flex-column align-items-center justify-content-center">
                        <div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_1.jpg)"></div>
                        <div class="sidebar_promo_content text-center">
                            <div class="sidebar_promo_title">30%<span>off</span></div>
                            <div class="sidebar_promo_subtitle">On all shoes</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">check out</a></div>
                        </div>
                    </div>

                    <!-- Promo 2 -->
                    <div class="sidebar_promo_2 sidebar_promo">
                        <div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_2.jpg)"></div>
                        <div class="sidebar_promo_content text-center">
                            <div class="sidebar_promo_title">30%<span>off</span></div>
                            <div class="sidebar_promo_subtitle">On all shoes</div>
                            <div class="sidebar_promo_button"><a href="checkout.html">check out</a></div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Extra -->



            <!-- Newsletter -->

            <div class="newsletter">
                <div class="newsletter_content">
                    <div class="newsletter_image" style="background-image:url(images/newsletter.jpg)"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="section_title_container text-center">
                                    <div class="section_subtitle">only the best</div>
                                    <div class="section_title">subscribe for a 20% discount</div>
                                </div>
                            </div>
                        </div>
                        <div class="row newsletter_container">
                            <div class="col-lg-10 offset-lg-1">
                                <div class="newsletter_form_container">
                                    <form action="#">
                                        <input type="email" class="newsletter_input" required="required" placeholder="E-mail here">
                                        <button type="submit" class="newsletter_button">subscribe</button>
                                    </form>
                                </div>
                                <div class="newsletter_text">Integer ut imperdiet erat. Quisque ultricies lectus tellus, eu tristique magna pharetra nec. Fusce vel lorem libero. Integer ex mi, facilisis sed nisi ut, vestib ulum ultrices nulla. Aliquam egestas tempor leo.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->

            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col text-center">
                            <div class="footer_logo"><a href="#">Wish</a></div>
                            <nav class="footer_nav">
                                <ul>
                                    <li><a href="index.html">home</a></li>
                                    <li><a href="categories.html">clothes</a></li>
                                    <li><a href="categories.html">accessories</a></li>
                                    <li><a href="categories.html">lingerie</a></li>
                                    <li><a href="contact.html">contact</a></li>
                                </ul>
                            </nav>
                            <div class="footer_social">
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-reddit-alien" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                            <div class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/Isotope/isotope.pkgd.min.js"></script>
        <script src="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.js"></script>
        <script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
        <script src="js/categories_custom.js"></script>
    </body>
</html>