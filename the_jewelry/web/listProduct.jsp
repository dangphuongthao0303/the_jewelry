<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="service.ProductService"%>
<%@page import="model.ProductResponse"%>
<%@page import="repository.ProductRepository"%>
<%@page import="model.PaginatedResponse"%>

<%
    // Retrieve categoryId from request, default to 1 if not provided
    String categoryIdParam = request.getParameter("category");
    int categoryId = (categoryIdParam != null) ? Integer.parseInt(categoryIdParam) : 1;

    // Handle optional parameters
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1; // Renamed `page` to `currentPage`
    int pageSize = 10; // Default page size

    // Sorting and filtering
    String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "Price"; // Default sort by Price
    String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "ASC"; // Default ascending order
    Map<String, String> filters = ProductRepository.extractFilters(request); // Extract filters from request

    // Call service to get product list
    ProductService productService = new ProductService();
    PaginatedResponse<ProductResponse> productResponse = productService.listProductsByCategory(categoryId, currentPage, pageSize, filters, sortBy, sortOrder); // Renamed `response` to `productResponse`
    List<ProductResponse> products = productResponse.getData();
%>

<!-- Product Grid -->
<div class="product_grid">
    <% if (products.isEmpty()) { %>
    <p>No products found.</p>
    <% } else { %>
    <% for (ProductResponse product : products) { %>
    <!-- Product -->
    <div class="product">
        <div class="product_image" style="display: flex; justify-content: center; align-items: center; height: 360px; overflow: hidden;">
            <img src="<%= product.getProductImage() != null ? product.getProductImage() : "images/default-product.jpg" %>" alt="" style="max-height: 360px; width: auto;">
        </div>
        <div class="product_content clearfix">
            <div class="product_info">
                <div class="product_name">
                    <a href="productDetail.jsp?productId=<%= product.getProductId() %>"><%= product.getProductName() %> <%= product.getProductId() %></a>
                </div>
                <div class="product_price"><%= product.getProductPrice() %> VND</div>
                <div class="product_details">
                    <span>Size: <%= product.getProductSize() %></span> |
                    <span>Color: <%= product.getProductColor() %></span>
                </div>
            </div>
            <div class="product_options">
                <div class="product_buy product_option"><img src="images/shopping-bag-white.svg" alt=""></div>
                <div class="product_fav product_option">+</div>
            </div>
        </div>
    </div>
    <% } %>
    <% } %>
</div>
