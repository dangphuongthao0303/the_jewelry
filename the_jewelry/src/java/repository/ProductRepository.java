package repository;

import jakarta.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.*;
import model.ProductResponse;

public class ProductRepository {

    private static final List<String> ALLOWED_FILTERS = Arrays.asList("Color", "Size", "Price");
    private static final List<String> ALLOWED_SORT = Arrays.asList("Price", "Size", "Color");

    private static final String BASE_QUERY = "SELECT p.ProductID, p.ProductName, pd.Price, pd.Size, pd.Color, pd.Image "
            + "FROM ProductDetail pd "
            + "INNER JOIN Products p ON pd.ProductID = p.ProductID "
            + "WHERE p.ProductStatus = 1 AND p.CategoryID = ?";

    private static final String COUNT_QUERY = "SELECT COUNT(*) FROM ProductDetail pd "
            + "INNER JOIN Products p ON pd.ProductID = p.ProductID "
            + "WHERE p.ProductStatus = 1 AND p.CategoryID = ?";

    public List<ProductResponse> findByCategory(int categoryId, int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        System.out.println("===========================");
        System.out.println("category id " +  categoryId);
        System.out.println("===========================");
        validateFilters(filters);
        validateSort(sortBy);

        String sql = buildCategoryQuery(filters, sortBy, sortOrder);
        List<Object> params = buildParams(categoryId, filters, page, pageSize);

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            setParameters(stmt, params);
            ResultSet rs = stmt.executeQuery();
            return mapProductResponses(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Database error while fetching products by category", e);
        }
    }

    private List<ProductResponse> mapProductResponses(ResultSet rs) throws SQLException {
        List<ProductResponse> productResponses = new ArrayList<>();
        while (rs.next()) {
            ProductResponse productResponse = new ProductResponse(
                    rs.getInt("ProductID"),
                    rs.getString("ProductName"),
                    rs.getInt("Price"),
                    rs.getString("Size"),
                    rs.getString("Color"),
                    rs.getString("Image")
            );
            productResponses.add(productResponse);
        }
        return productResponses;
    }

    public static Map<String, String> extractFilters(HttpServletRequest request) {
        Map<String, String> filters = new HashMap<>();
        for (String filter : ALLOWED_FILTERS) {
            String value = request.getParameter(filter);
            if (value != null && !value.isEmpty()) {
                filters.put(filter, value);
            }
        }
        return filters;
    }

    private String buildCategoryQuery(Map<String, String> filters, String sortBy, String sortOrder) {
        StringBuilder sql = new StringBuilder(BASE_QUERY);
        appendFilters(sql, filters);

        if (sortBy != null) {
            sql.append(" ORDER BY pd.").append(sortBy).append(" ").append(sortOrder);
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        return sql.toString();
    }

    private void appendFilters(StringBuilder sql, Map<String, String> filters) {
        if (!filters.isEmpty()) {
            sql.append(" AND ");
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

    public int countByCategory(int categoryId, Map<String, String> filters) {
        StringBuilder sql = new StringBuilder(COUNT_QUERY);
        appendFilters(sql, filters);

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            List<Object> params = new ArrayList<>();
            params.add(categoryId);
            params.addAll(filters.values());

            setParameters(stmt, params);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error while counting products by category", e);
        }
        return 0;
    }

    private List<Object> buildParams(int categoryId, Map<String, String> filters, int page, int pageSize) {
        List<Object> params = new ArrayList<>();
        params.add(categoryId);
        params.addAll(filters.values());
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        return params;
    }

    private void setParameters(PreparedStatement stmt, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            stmt.setObject(i + 1, params.get(i));
        }
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
