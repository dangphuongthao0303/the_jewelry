<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Category" %>
<%@page import="repository.CategoryRepository" %>

<%
    CategoryRepository categoryRepository = new CategoryRepository();
    List<Category> categories = categoryRepository.getAllCategories();
%>


<header class="header">
    <div class="header_inner d-flex flex-row align-items-center justify-content-start">
        <div class="logo"><a href="#">Wish</a></div>
        <nav class="main_nav">
            <ul>
                <li><a href="index.jsp">home</a></li>
                <% for (Category category : categories) { %>
                        <li><a href="categories.jsp?category=<%= category.getCategoryId() %>">
                            <%= category.getCategoryName() %>
                        </a></li>
                    <% } %>
            </ul>
        </nav>
        <div class="header_content ml-auto">
            <div class="search header_search">
                <form action="#">
                    <input type="search" class="search_input" required="required">
                    <button type="submit" id="search_button" class="search_button"><img src="images/magnifying-glass.svg" alt=""></button>
                </form>
            </div>
            <div class="shopping">
                <!-- Cart -->
                <a href="#">
                    <div class="cart">
                        <img src="images/shopping-bag.svg" alt="">
                        <div class="cart_num_container">
                            <div class="cart_num_inner">
                                <div class="cart_num">1</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Star -->
                <a href="#">
                    <div class="star">
                        <img src="images/star.svg" alt="">
                        <div class="star_num_container">
                            <div class="star_num_inner">
                                <div class="star_num">0</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Avatar -->
                <a href="#">
                    <div class="avatar">
                        <img src="images/avatar.svg" alt="">
                    </div>
                </a>
            </div>
        </div>

        <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm"><div></div><div></div><div></div></div>
    </div>
</header>