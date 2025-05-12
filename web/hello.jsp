<%@ page import="java.sql.*" %>
<%@ page import="vt.VeritabaniBaglanti" %>
<%
    String dbName = "vt"; // Veritaban? ad?
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        conn = VeritabaniBaglanti.getConnection(dbName);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT b FROM b");

        while (rs.next()) {
            out.println("<p>" + rs.getString("b") + "</p>");
        }

    } catch (SQLException e) {
        out.println("Hata: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
