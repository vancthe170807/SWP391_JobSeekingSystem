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
     // C�c constant ??i di?n cho gi� tr? true v� false trong vi?c s? d?ng OR v� AND
    public static final boolean CONDITION_AND = true;
    public static final boolean CONDITION_OR = false;
    private final Class<T> clazz;

    public GenericDAO_HOLA() {
        // L?y th�ng tin ki?u generic t? superclass
        Type genericSuperclass = getClass().getGenericSuperclass();
        
        // Ki?m tra xem genericSuperclass c� ph?i l� ParameterizedType
        if (genericSuperclass instanceof ParameterizedType) {
            Type[] arguments = ((ParameterizedType) genericSuperclass).getActualTypeArguments();
            if (arguments != null && arguments.length > 0) {
                // Ki?m tra an to�n tr??c khi �p ki?u
                Type argument = arguments[0];
                if (argument instanceof Class<?>) {
                    this.clazz = (Class<T>) argument;
                } else {
                    throw new IllegalArgumentException("Kh�ng th? x�c ??nh lo?i T");
                }
            } else {
                throw new IllegalArgumentException("Kh�ng c� ??i s? ki?u cho GenericDAO");
            }
        } else {
            throw new IllegalArgumentException("L?p n�y kh�ng ph?i l� m?t ParameterizedType");
        }
    }

    /**
     * H�m n�y s? d?ng ?? get d? li?u t? database l�n d?a tr�n t�n b?ng m� b?n
     * mong mu?n.H�m s? m?c ??nh tr? v? m?t List c� th? c� gi� tr? ho?c List
     * r?ng
     *
     * @param clazz: t�n b?ng b?n mu?n get d? li?u v?
     * @return list
     */
    protected List<T> queryGenericDAO() {
        connection = new DBContext().connection;
        List<T> result = new ArrayList<>();
        try {
            // L?y k?t n?i

            // T?o c�u l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT * FROM ").append(clazz.getSimpleName());

            // Chu?n b? c�u l?nh
            statement = connection.prepareStatement(sqlBuilder.toString());
            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai b�o danh s�ch k?t qu?
            // Duy?t result set
            while (resultSet.next()) {
                // G?i h�m mapRow ?? map ??i t??ng
                T obj = mapRow(resultSet);

                // Th�m v�o danh s�ch k?t qu?
                result.add(obj);
            }

            return result;
        } catch (IllegalAccessException
                | IllegalArgumentException
                | InstantiationException
                | NoSuchMethodException
                | InvocationTargetException
                | SQLException e) {
            System.err.println("4USER: B?n Exception ? h�m query: " + e.getMessage());
        } finally {
            try {
                // ?�ng k?t n?i v� c�c t�i nguy�n
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                System.err.println("4USER: B?n Exception ? h�m query: " + e.getMessage());
            }
        }
        return result;
    }

    /**
     * H�m n�y s? d?ng ?? get d? li?u t? database l�n d?a tr�n t�n b?ng m� b?n
     * mong mu?n Condition (optional) l� �m ch? nh?ng gi� tr? nh? and ho?c
     * or.H�y s? d?ng nh?ng bi?n s?n c� CONDITION_OR, CONDITION_AND v� d?:
     * GenericDAO_HOLA.CONDITION_OR ho?c GenericDAO_HOLA.CONDITION_AND.H�m s?
     * m?c ??nh tr? v? m?t List c� th? c� gi� tr? ho?c List r?ng
     *
     * @param clazz:        t�n b?ng b?n mu?n get d? li?u v?
     * @param sql:          c�u l?nh SQL
     * @param parameterMap: hashmap ch?a c�c parameter
     * @return list
     */
    protected List<T> queryGenericDAO(String sql) {
        connection = new DBContext().connection;
        List<T> result = new ArrayList<>();
        try {
            // L?y k?t n?i

            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Th�m ?i?u ki?n
            if (parameterMap != null && !parameterMap.isEmpty()) {
                // code th�m ?i?u ki?n
                for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
                    Object conditionValue = entry.getValue();

                    parameters.add(conditionValue);
                }
                // X�a ph?n AND ho?c OR cu?i c�ng kh?i c�u truy v?n
            }

            // Chu?n b? c�u l?nh
            statement = connection.prepareStatement(sql);

            // G�n gi� tr? cho c�c tham s? c?a c�u truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai b�o danh s�ch k?t qu?
            // Duy?t result set
            while (resultSet.next()) {
                // G?i h�m mapRow ?? map ??i t??ng
                T obj = mapRow(resultSet);

                // Th�m v�o danh s�ch k?t qu?
                result.add(obj);
            }

            return result;
        } catch (IllegalAccessException
                | IllegalArgumentException
                | InstantiationException
                | NoSuchMethodException
                | InvocationTargetException
                | SQLException e) {
            System.err.println("4USER: B?n Exception ? h�m query: " + e.getMessage());
        } finally {
            try {
                // ?�ng k?t n?i v� c�c t�i nguy�n
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? h�m query: " + e.getMessage());
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

        // L?y danh s�ch c�c field c?a l?p
        Field[] fields = clazz.getDeclaredFields();

        // Duy?t qua t?ng field
        for (Field field : fields) {

            // Set gi� tr? cho field
            Object value = getFieldValue(rs, field);
            field.setAccessible(true);
            field.set(obj, value);
        }

        return obj;
    }

    /**
     * H�m l?y gi� tr? cho field t? result set
     *
     * @param rs
     * @param field
     * @return
     * @throws SQLException
     */
    private static Object getFieldValue(ResultSet rs, Field field) throws SQLException {

        Class<?> fieldType = field.getType();
        String fieldName = field.getName();

        // Ki?m tra ki?u d? li?u v� convert sang ?�ng ki?u
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
     * H�m n�y s? d?ng ?? update th�ng tin c?a m?t ??i t??ng trong Database.H�y
     * nh? r?ng h�m n�y kh�ng update ID v� m?c ??nh c�c b?ng s? ?? ID t? ??ng
     * t?ng
     *
     * @param sql
     * @param parameterMap: hashmap ch?a c�c parameter
     * @return true: update th�nh c�ng | false: update th?t b?i
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
                System.err.println("4USER: B?n Exception ? h�m update: " + ex.getMessage());
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
                System.err.println("4USER: B?n Exception ? h�m update: " + e.getMessage());
            }
        }
    }

    /**
     * H�m n�y s? d?ng ?? update th�ng tin c?a m?t ??i t??ng trong Database.H�y
     * nh? r?ng h�m n�y kh�ng update ID v� m?c ??nh c�c b?ng s? ?? ID t? ??ng
     * t?ng
     *
     * @param sql
     * @param parameterMap: hashmap ch?a c�c parameter
     * @return true: delete th�nh c�ng | false: delete th?t b?i
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
                System.err.println("4USER: B?n Exception ? h�m delete: " + ex.getMessage());
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
                System.err.println("4USER: B?n Exception ? h�m update: " + e.getMessage());
            }
        }
    }

    // /**
    // * H�m n�y s? d?ng ?? insert m?t d? li?u c?a m?t ??i t??ng v�o m?t b?ng
    // * trong database
    // *
    // * @param object: ??i t??ng ch?a c�c th�ng tin mu?n insert
    // * @return 0: insert th?t b?i: || !0 : insert th�nh c�ng
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
    // // X�y d?ng danh s�ch c�c tr??ng v� gi� tr? tham s? c?a c�u truy v?n
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
    // // X�a d?u ph?y cu?i c�ng
    // if (sqlBuilder.charAt(sqlBuilder.length() - 2) == ',') {
    // sqlBuilder.delete(sqlBuilder.length() - 2, sqlBuilder.length());
    // }
    //
    // sqlBuilder.append(") VALUES (");
    // for (int i = 0; i < parameters.size(); i++) {
    // sqlBuilder.append("?, ");
    // }
    //
    // // X�a d?u ph?y cu?i c�ng
    // if (sqlBuilder.charAt(sqlBuilder.length() - 2) == ',') {
    // sqlBuilder.delete(sqlBuilder.length() - 2, sqlBuilder.length());
    // }
    //
    // sqlBuilder.append(")");
    //
    // int id = 0;
    // try {
    // // B?t ??u giao d?ch v� chu?n b? c�u truy v?n
    // connection.setAutoCommit(false);
    // statement = connection.prepareStatement(sqlBuilder.toString());
    //
    // int index = 1;
    // for (Object value : parameters) {
    // statement.setObject(index, value);
    // index++;
    // }
    //
    // // Th?c thi c�u truy v?n
    // statement.executeUpdate();
    //
    // System.err.println("insertGenericDAO: " + sqlBuilder.toString());
    // // X�c nh?n giao d?ch th�nh c�ng
    // connection.commit();
    // } catch (SQLException e) {
    // try {
    // System.err.println("4USER: B?n Exception ? h�m insert: " + e.getMessage());
    // // Ho�n t�c giao d?ch n?u x?y ra l?i
    // connection.rollback();
    // } catch (SQLException ex) {
    // System.err.println("4USER: B?n Exception ? h�m insert: " + ex.getMessage());
    // }
    // } finally {
    // // ??m b?o ?�ng k?t n?i v� t�i nguy�n
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
    // System.err.println("4USER: B?n Exception ? h�m insert: " + e.getMessage());
    // }
    // }
    // // Tr? v? ID ???c t?o t? ??ng (n?u c�)
    // return id;
    // }
    /**
     * T�m s? l??ng record c?a 1 b?ng n�o ?�
     *
     * @param clazz: b?ng mu?n t�m
     * @return s? l??ng record
     */
    protected int findTotalRecordGenericDAO() {
        int total = 0;
        try {
            // L?y k?t n?i

            // T?o c�u l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT COUNT(*) FROM ").append(clazz.getSimpleName());
            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Chu?n b? c�u l?nh
            statement = connection.prepareStatement(sqlBuilder.toString());

            // G�n gi� tr? cho c�c tham s? c?a c�u truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai b�o danh s�ch k?t qu?
            // Duy?t result set
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (IllegalArgumentException | SQLException e) {
            System.err.println("4USER: B?n Exception ? h�m findTotalRecord: " + e.getMessage());
        } finally {
            try {
                // ?�ng k?t n?i v� c�c t�i nguy�n
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? h�m findTotalRecord: " + e.getMessage());
            }
        }
        return total;
    }

    /**
     * T�m s? l??ng record c?a 1 b?ng n�o ?�, ?i?u ki?n (optional)
     *
     * @param clazz:        b?ng mu?n t�m
     * @param parameterMap: hashmap ch?a c�c parameter
     * @return s? l??ng record
     */
    protected int findTotalRecordGenericDAO(String sql) {
        int total = 0;
        try {
            // L?y k?t n?i

            // T?o c�u l?nh SELECT
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT COUNT(*) FROM ").append(clazz.getSimpleName());
            // List parameter
            List<Object> parameters = new ArrayList<>();

            // Th�m ?i?u ki?n
            if (parameterMap != null && !parameterMap.isEmpty()) {
                // code th�m ?i?u ki?n
                for (Map.Entry<String, Object> entry : parameterMap.entrySet()) {
                    Object conditionValue = entry.getValue();

                    parameters.add(conditionValue);
                }
            }

            // Chu?n b? c�u l?nh
            statement = connection.prepareStatement(sql);

            // G�n gi� tr? cho c�c tham s? c?a c�u truy v?n
            int index = 1;
            for (Object value : parameters) {
                statement.setObject(index, value);
                index++;
            }

            // Th?c thi truy v?n
            resultSet = statement.executeQuery();

            // Khai b�o danh s�ch k?t qu?
            // Duy?t result set
            if (resultSet.next()) {
                total = resultSet.getInt(1);
            }

        } catch (IllegalArgumentException | SQLException e) {
            System.err.println("4USER: B?n Exception ? h�m findTotalRecord: " + e.getMessage());
        } finally {
            try {
                // ?�ng k?t n?i v� c�c t�i nguy�n
                if (resultSet != null) {

                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("4USER: B?n Exception ? h�m findTotalRecord: " + e.getMessage());
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
                System.err.println("4USER: B?n Exception ? h�m update: " + ex.getMessage());
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
                System.err.println("4USER: B?n Exception ? h�m insert: " + e.getMessage());
            }
        }
    }

    public abstract List<T> findAll();

    public abstract int insert(T t);

}
