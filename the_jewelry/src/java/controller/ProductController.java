package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import model.PaginatedResponse;
import model.Product;
import repository.ProductRepository;
import service.ProductService;

public class ProductController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final ProductRepository productRepository = new ProductRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
            int pageSize = Integer.parseInt(request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "10");
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "asc";
            
            Map<String, String> filters = productRepository.extractFilters(request);
            
            PaginatedResponse<Product> paginatedResponse = productService.listProducts(page, pageSize, filters, sortBy, sortOrder);
            String jsonResponse = convertToJson(paginatedResponse);

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(jsonResponse);
            out.flush();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
            out.flush();
        }
    }
    
    private String convertToJson(Object object) {
        StringBuilder json = new StringBuilder("{");
        if (object instanceof PaginatedResponse) {
            PaginatedResponse<?> response = (PaginatedResponse<?>) object;
            json.append("\"total\":").append(response.getTotal()).append(",");
            json.append("\"data\":[");
            for (Object item : response.getData()) {
                json.append(item.toString()).append(",");
            }
            if (!response.getData().isEmpty()) {
                json.deleteCharAt(json.length() - 1);
            }
            json.append("]");
        }
        json.append("}");
        return json.toString();
    }
}
