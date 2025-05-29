<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>

<%@page import="VeritabaniBaglanti.VeritabaniBaglanti"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    String dbName = "vt";
    String tc = request.getParameter("tc");
    String pin = request.getParameter("pin");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = VeritabaniBaglanti.getConnection(dbName);
        pstmt = conn.prepareStatement("SELECT * FROM ekip WHERE tc = ? AND pin = ?");
        pstmt.setString(1, tc);
        pstmt.setString(2, pin);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            out.println("<h2>Hoşgeldin, " + rs.getString("ad") + " " + rs.getString("soyad") + "</h2>");
            out.println("<p>İletişim: " + rs.getString("iletisim") + "</p>");
            out.println("<p>Kayıt Tarihi: " + rs.getDate("date") + "</p>");
        } else {
            out.println("<h2>Giriş başarısız. TC veya PIN yanlış.</h2>");
        }

    } catch (SQLException e) {
        out.println("Veritabanı hatası: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
