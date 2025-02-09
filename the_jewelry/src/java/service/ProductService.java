package service;

import java.util.List;
import java.util.Map;
import model.PaginatedResponse;
import model.Product;
import repository.ProductRepository;

public class ProductService {

    private final ProductRepository productRepository = new ProductRepository();

    public PaginatedResponse<Product> listProducts(int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        List<Product> products = productRepository.findAll(page, pageSize, filters, sortBy, sortOrder);
        int total = productRepository.countAll(filters);
        int totalPages = (int) Math.ceil((double) total / pageSize);
        return new PaginatedResponse<>(products, page, pageSize, total, totalPages);
    }

    public PaginatedResponse<Product> listProductsByCategory(int categoryId, int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        List<Product> products = productRepository.findByCategory(page, pageSize, filters, sortBy, sortOrder);
        int total = productRepository.countByCategory(categoryId, filters);
        int totalPages = (int) Math.ceil((double) total / pageSize);
        return new PaginatedResponse<>(products, page, pageSize, total, totalPages);
    }
}
