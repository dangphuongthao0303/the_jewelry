/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;
import model.Product;

public class ProductRepository {

    private static final List<String> ALLOWED_FILTERS = Arrays.asList("Color", "Size", "Price");
    private static final List<String> ALLOWED_SORT = Arrays.asList("Price", "Size", "Color");

    public List<Product> findAll(int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        validateFilters(filters);
        validateSort(sortBy);

        String sql = buildQuery(filters, sortBy, sortOrder);
        List<Object> params = buildParams(filters, page, pageSize);

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            return mapProducts(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Database error", e);
        }
    }

    public int countAll(Map<String, String> filters) {
        validateFilters(filters);

        String sql = buildCountQuery(filters);
        List<Object> params = buildCountParams(filters);

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            throw new RuntimeException("Database error", e);
        }
    }

    private String buildQuery(Map<String, String> filters, String sortBy, String sortOrder) {
        StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity, p.Date, p.Description, p.ProductStatus ")
                .append("FROM Products p INNER JOIN ProductDetail pd ON p.ProductID = pd.ProductID ")
                .append("WHERE p.ProductStatus = 1 ");

        appendFilters(sql, filters);
        sql.append(" GROUP BY p.ProductID, p.ProductName, p.CategoryID, p.Quantity, p.SoldQuantity, p.Date, p.Description, p.ProductStatus ");

        if (sortBy != null) {
            sql.append("ORDER BY ").append(sortOrder.equalsIgnoreCase("DESC") ? "MAX" : "MIN")
                    .append("(pd.").append(sortBy).append(") ").append(sortOrder).append(" ");
        }

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        return sql.toString();
    }

    private String buildCountQuery(Map<String, String> filters) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT p.ProductID) FROM Products p ")
                .append("INNER JOIN ProductDetail pd ON p.ProductID = pd.ProductID ")
                .append("WHERE p.ProductStatus = 1 ");
        appendFilters(sql, filters);
        return sql.toString();
    }

    public static Map<String, String> extractFilters(HttpServletRequest request) {
        Map<String, String> filters = new HashMap<>();
        for (String filter : ProductRepository.ALLOWED_FILTERS) {
            String value = request.getParameter(filter);
            if (value != null && !value.isEmpty()) {
                filters.put(filter, value);
            }
        }
        return filters;
    }

    private void appendFilters(StringBuilder sql, Map<String, String> filters) {
        if (!filters.isEmpty()) {
            sql.append("AND ");
            Iterator<Map.Entry<String, String>> iterator = filters.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, String> entry = iterator.next();
                sql.append("pd.").append(entry.getKey()).append(" = ?");
                if (iterator.hasNext()) {
                    sql.append(" AND ");
                }
            }
        }
    }

    private List<Object> buildParams(Map<String, String> filters, int page, int pageSize) {
        List<Object> params = new ArrayList<Object>();
        params.addAll(filters.values());
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        return params;
    }

    private List<Object> buildCountParams(Map<String, String> filters) {
        List<Object> params = new ArrayList<>();
        for (String value : filters.values()) {
            params.add(value);
        }
        return params;
    }

    private void setParameters(PreparedStatement stmt, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
    }

    private List<Product> mapProducts(ResultSet rs) throws SQLException {
        List<Product> products = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getInt("ProductID"));
            product.setProductName(rs.getString("ProductName"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setQuantity(rs.getInt("Quantity"));
            product.setSoldQuantity(rs.getInt("SoldQuantity"));
            product.setDate(rs.getDate("Date"));
            product.setDescription(rs.getString("Description"));
            product.setProductStatus(rs.getInt("ProductStatus"));
            products.add(product);
        }
        return products;
    }

    private void validateFilters(Map<String, String> filters) {
        for (String key : filters.keySet()) {
            if (!ALLOWED_FILTERS.contains(key)) {
                throw new IllegalArgumentException("Invalid filter attribute: " + key);
            }
        }
    }

    private void validateSort(String sortBy) {
        if (sortBy != null && !ALLOWED_SORT.contains(sortBy)) {
            throw new IllegalArgumentException("Invalid sort attribute: " + sortBy);
        }
    }

}
