package dao;
/*				
 * Copyright (C) FPT University , Ltd. 2023	
 * 30/09/2023 FPT 4USER
 */

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author 4USER
 * @param <T>
 */
public abstract class GenericDAO_HOLA<T> extends DBContext {

    protected PreparedStatement statement;
    protected ResultSet resultSet;
    protected Map<String, Object> parameterMap;
     // Các constant ??i di?n cho giá tr? true và false trong vi?c s? d?ng OR và AND
    public static final boolean CONDITION_AND = true;
    public static final boolean CONDITION_OR = false;
    private final Class<T> clazz;

    public GenericDAO_HOLA() {
        // L?y thông tin ki?u generic t? superclass
        Type genericSuperclass = getClass().getGenericSuperclass();
        
        // Ki?m tra xem genericSuperclass có ph?i là ParameterizedType
        if (genericSuperclass instanceof ParameterizedType) {
            Type[] arguments = ((ParameterizedType) genericSuperclass).getActualTypeArguments();
            if (arguments != null && arguments.length > 0) {
                // Ki?m tra an toàn tr??c khi ép ki?u
                Type argument = arguments[0];
                if (argument instanceof Class<?>) {
                    this.clazz = (Class<T>) argument;
                } else {
                    throw new IllegalArgumentException("Không th? xác ??nh lo?i T");
                }
            } else {
                throw new IllegalArgumentException("Không có ??i s? ki?u cho GenericDAO");
            }
        } else {
            throw new IllegalArgumentException("L?p này không ph?i là m?t ParameterizedType");
        }
    }

    /**
     * Hàm này s? d?ng ?? get d? li?u t? database lên d?a trên tên b?ng mà b?n
     * mong mu?n.Hàm s? m?c ??nh tr? v? m?t List có th? có giá tr? ho?c List
     * r?ng
     *
     * @param clazz: tên b?ng b?n mu?n get d? li?u v?
     * @return list
     */
    protected List<T> queryGenericDAO() {
        connection = new DBContext().connection;
        List<T> result = new ArrayList<>();
        try {
            // L?y k?t n?i

            // T?o câu l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT * FROM ").append(clazz.getSimpleName());

            // Chu?n b? câu l?nh
            statement = connection.prepareStatement(sqlBuilder.toString());
            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai báo danh sách k?t qu?
            // Duy?t result set
            while (resultSet.next()) {
                // G?i hàm mapRow ?? map ??i t??ng
                T obj = mapRow(resultSet);

                // Thêm vào danh sách k?t qu?
                result.add(obj);
            }

            return result;
        } catch (IllegalAccessException
                | IllegalArgumentException
                | InstantiationException
                | NoSuchMethodException
                | InvocationTargetException
                | SQLException e) {
            System.err.println("4USER: B?n Exception ? hàm query: " + e.getMessage());
        } finally {
            try {
                // ?óng k?t n?i và các tài nguyên
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                System.err.println("4USER: B?n Exception ? hàm query: " + e.getMessage());
            }
        }
        return result;
    }

    /**
     * Hàm này s? d?ng ?? get d? li?u t? database lên d?a trên tên b?ng mà b?n
     * mong mu?n Condition (optional) là ám ch? nh?ng giá tr? nh? and ho?c
     * or.Hãy s? d?ng nh?ng bi?n s?n có CONDITION_OR, CONDITION_AND ví d?:
     * GenericDAO_HOLA.CONDITION_OR ho?c GenericDAO_HOLA.CONDITION_AND.Hàm s?
     * m?c ??nh tr? v? m?t List có th? có giá tr? ho?c List r?ng
     *
     * @param clazz:        tên b?ng b?n mu?n get d? li?u v?
     * @param sql:          câu l?nh SQL
     * @param parameterMap: hashmap ch?a các parameter
     * @return list
     */
    protected List<T> queryGenericDAO(String sql) {
        connection = new DBContext().connection;
        List<T> result = new ArrayList<>();
        try {
            // L?y k?t n?i

            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Thêm ?i?u ki?n
            if (parameterMap != null && !parameterMap.isEmpty()) {
                // code thêm ?i?u ki?n
                for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
                    Object conditionValue = entry.getValue();

                    parameters.add(conditionValue);
                }
                // Xóa ph?n AND ho?c OR cu?i cùng kh?i câu truy v?n
            }

            // Chu?n b? câu l?nh
            statement = connection.prepareStatement(sql);

            // Gán giá tr? cho các tham s? c?a câu truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai báo danh sách k?t qu?
            // Duy?t result set
            while (resultSet.next()) {
                // G?i hàm mapRow ?? map ??i t??ng
                T obj = mapRow(resultSet);

                // Thêm vào danh sách k?t qu?
                result.add(obj);
            }

            return result;
        } catch (IllegalAccessException
                | IllegalArgumentException
                | InstantiationException
                | NoSuchMethodException
                | InvocationTargetException
                | SQLException e) {
            System.err.println("4USER: B?n Exception ? hàm query: " + e.getMessage());
        } finally {
            try {
                // ?óng k?t n?i và các tài nguyên
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm query: " + e.getMessage());
            }
        }
        return result;
    }

    private <T> T mapRow(ResultSet rs) throws SQLException,
            NoSuchMethodException,
            InstantiationException,
            IllegalArgumentException,
            IllegalAccessException,
            InvocationTargetException {

        // Kh?i t?o ??i t??ng
        T obj = (T) clazz.getDeclaredConstructor().newInstance();

        // L?y danh sách các field c?a l?p
        Field[] fields = clazz.getDeclaredFields();

        // Duy?t qua t?ng field
        for (Field field : fields) {

            // Set giá tr? cho field
            Object value = getFieldValue(rs, field);
            field.setAccessible(true);
            field.set(obj, value);
        }

        return obj;
    }

    /**
     * Hàm l?y giá tr? cho field t? result set
     *
     * @param rs
     * @param field
     * @return
     * @throws SQLException
     */
    private static Object getFieldValue(ResultSet rs, Field field) throws SQLException {

        Class<?> fieldType = field.getType();
        String fieldName = field.getName();

        // Ki?m tra ki?u d? li?u và convert sang ?úng ki?u
        if (fieldType == String.class) {
            return rs.getString(fieldName);
        } else if (fieldType == int.class || fieldType == Integer.class) {
            return rs.getInt(fieldName);
        } else if (fieldType == long.class || fieldType == Long.class) {
            return rs.getLong(fieldName);
        } else if (fieldType == double.class || fieldType == Double.class) {
            return rs.getDouble(fieldName);
        } else if (fieldType == boolean.class || fieldType == Boolean.class) {
            return rs.getBoolean(fieldName);
        } else if (fieldType == float.class || fieldType == Float.class) {
            return rs.getFloat(fieldName);
        } else if (fieldType == Date.class || fieldType == Date.class) {
            return rs.getDate(fieldName);
        } else if (fieldType == Character.class || fieldType == char.class) {
            return rs.getString(fieldName);
        } else if (fieldType == Character.class || fieldType == char.class ) {
            String s = rs.getString(fieldName);
            return s.charAt(0);
        }
        else {
            return rs.getObject(fieldName);
        }
    }

    /**
     * Hàm này s? d?ng ?? update thông tin c?a m?t ??i t??ng trong Database.Hãy
     * nh? r?ng hàm này không update ID vì m?c ??nh các b?ng s? ?? ID t? ??ng
     * t?ng
     *
     * @param sql
     * @param parameterMap: hashmap ch?a các parameter
     * @return true: update thành công | false: update th?t b?i
     */
    protected boolean updateGenericDAO(String sql) {

        List<Object> parameters = new ArrayList<>();

        for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
            Object conditionValue = entry.getValue();

            parameters.add(conditionValue);
        }

        try {

            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }
            statement.executeUpdate();
            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.err.println("4USER: B?n Exception ? hàm update: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm update: " + e.getMessage());
            }
        }
    }

    /**
     * Hàm này s? d?ng ?? update thông tin c?a m?t ??i t??ng trong Database.Hãy
     * nh? r?ng hàm này không update ID vì m?c ??nh các b?ng s? ?? ID t? ??ng
     * t?ng
     *
     * @param sql
     * @param parameterMap: hashmap ch?a các parameter
     * @return true: delete thành công | false: delete th?t b?i
     */
    protected boolean deleteGenericDAO(String sql) {
        List<Object> parameters = new ArrayList<>();

        for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
            Object conditionValue = entry.getValue();
            parameters.add(conditionValue);
        }

        try {

            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }
            statement.executeUpdate();
            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.err.println("4USER: B?n Exception ? hàm delete: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm update: " + e.getMessage());
            }
        }
    }

    // /**
    // * Hàm này s? d?ng ?? insert m?t d? li?u c?a m?t ??i t??ng vào m?t b?ng
    // * trong database
    // *
    // * @param object: ??i t??ng ch?a các thông tin mu?n insert
    // * @return 0: insert th?t b?i: || !0 : insert thành công
    // */
    // protected int insertGenericDAO(T object) {
    // Class<?> clazz = object.getClass();
    // Field[] fields = clazz.getDeclaredFields();
    //
    // StringBuilder sqlBuilder = new StringBuilder();
    // sqlBuilder.append("INSERT INTO ").append(clazz.getSimpleName()).append(" (");
    //
    // List<Object> parameters = new ArrayList<>();
    //
    // // Xây d?ng danh sách các tr??ng và giá tr? tham s? c?a câu truy v?n
    // for (Field field : fields) {
    // field.setAccessible(true);
    // String fieldName = field.getName();
    // Object fieldValue;
    // try {
    // fieldValue = field.get(object);
    // } catch (IllegalAccessException e) {
    // fieldValue = null;
    // }
    //
    // if (fieldValue != null ) {
    // sqlBuilder.append(fieldName).append(", ");
    // parameters.add(fieldValue);
    // }
    // }
    //
    // // Xóa d?u ph?y cu?i cùng
    // if (sqlBuilder.charAt(sqlBuilder.length() - 2) == ',') {
    // sqlBuilder.delete(sqlBuilder.length() - 2, sqlBuilder.length());
    // }
    //
    // sqlBuilder.append(") VALUES (");
    // for (int i = 0; i < parameters.size(); i++) {
    // sqlBuilder.append("?, ");
    // }
    //
    // // Xóa d?u ph?y cu?i cùng
    // if (sqlBuilder.charAt(sqlBuilder.length() - 2) == ',') {
    // sqlBuilder.delete(sqlBuilder.length() - 2, sqlBuilder.length());
    // }
    //
    // sqlBuilder.append(")");
    //
    // int id = 0;
    // try {
    // // B?t ??u giao d?ch và chu?n b? câu truy v?n
    // connection.setAutoCommit(false);
    // statement = connection.prepareStatement(sqlBuilder.toString());
    //
    // int index = 1;
    // for (Object value : parameters) {
    // statement.setObject(index, value);
    // index++;
    // }
    //
    // // Th?c thi câu truy v?n
    // statement.executeUpdate();
    //
    // System.err.println("insertGenericDAO: " + sqlBuilder.toString());
    // // Xác nh?n giao d?ch thành công
    // connection.commit();
    // } catch (SQLException e) {
    // try {
    // System.err.println("4USER: B?n Exception ? hàm insert: " + e.getMessage());
    // // Hoàn tác giao d?ch n?u x?y ra l?i
    // connection.rollback();
    // } catch (SQLException ex) {
    // System.err.println("4USER: B?n Exception ? hàm insert: " + ex.getMessage());
    // }
    // } finally {
    // // ??m b?o ?óng k?t n?i và tài nguyên
    // try {
    // if (connection != null) {
    // connection.close();
    // }
    // if (statement != null) {
    // statement.close();
    // }
    // if (resultSet != null) {
    // resultSet.close();
    // }
    // } catch (SQLException e) {
    // System.err.println("4USER: B?n Exception ? hàm insert: " + e.getMessage());
    // }
    // }
    // // Tr? v? ID ???c t?o t? ??ng (n?u có)
    // return id;
    // }
    /**
     * Tìm s? l??ng record c?a 1 b?ng nào ?ó
     *
     * @param clazz: b?ng mu?n tìm
     * @return s? l??ng record
     */
    protected int findTotalRecordGenericDAO() {
        int total = 0;
        try {
            // L?y k?t n?i

            // T?o câu l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT COUNT(*) FROM ").append(clazz.getSimpleName());
            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Chu?n b? câu l?nh
            statement = connection.prepareStatement(sqlBuilder.toString());

            // Gán giá tr? cho các tham s? c?a câu truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai báo danh sách k?t qu?
            // Duy?t result set
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (IllegalArgumentException | SQLException e) {
            System.err.println("4USER: B?n Exception ? hàm findTotalRecord: " + e.getMessage());
        } finally {
            try {
                // ?óng k?t n?i và các tài nguyên
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm findTotalRecord: " + e.getMessage());
            }
        }
        return total;
    }

    /**
     * Tìm s? l??ng record c?a 1 b?ng nào ?ó, ?i?u ki?n (optional)
     *
     * @param clazz:        b?ng mu?n tìm
     * @param parameterMap: hashmap ch?a các parameter
     * @return s? l??ng record
     */
    protected int findTotalRecordGenericDAO(String sql) {
        int total = 0;
        try {
            // L?y k?t n?i

            // T?o câu l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT COUNT(*) FROM ").append(clazz.getSimpleName());
            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Thêm ?i?u ki?n
            if (parameterMap != null && !parameterMap.isEmpty()) {
                // code thêm ?i?u ki?n
                for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
                    Object conditionValue = entry.getValue();

                    parameters.add(conditionValue);
                }
            }

            // Chu?n b? câu l?nh
            statement = connection.prepareStatement(sql);

            // Gán giá tr? cho các tham s? c?a câu truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai báo danh sách k?t qu?
            // Duy?t result set
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (IllegalArgumentException | SQLException e) {
            System.err.println("4USER: B?n Exception ? hàm findTotalRecord: " + e.getMessage());
        } finally {
            try {
                // ?óng k?t n?i và các tài nguyên
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm findTotalRecord: " + e.getMessage());
            }
        }
        return total;
    }

    protected void insertGenericDAO(String sql) {

        List<Object> parameters = new ArrayList<>();

        for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
            Object conditionValue = entry.getValue();

            parameters.add(conditionValue);
        }

        try {

            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }
            statement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.err.println("4USER: B?n Exception ? hàm update: " + ex.getMessage());
            }
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? hàm insert: " + e.getMessage());
            }
        }
    }

    public abstract List<T> findAll();

    public abstract int insert(T t);

}
