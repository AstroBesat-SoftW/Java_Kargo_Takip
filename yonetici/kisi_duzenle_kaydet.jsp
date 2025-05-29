
<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>

<%
    String kullanici = (String) session.getAttribute("yonetici");
    if (kullanici == null) {
        response.sendRedirect("../yonetici_giris.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String isim = request.getParameter("isim");
    String tc = request.getParameter("tc");
    String iletisim = request.getParameter("iletisim");
    String eposta = request.getParameter("eposta");
    String adres = request.getParameter("adres");
    String dogumTarihi = request.getParameter("dogum_tarihi");
    String cinsiyet = request.getParameter("cinsiyet");
    String sube = request.getParameter("sube");
    String mevki = request.getParameter("mevki");

    String dbname = "kargosistemi";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = VeritabaniBaglanti.getConnection(dbname);
        String sql = "UPDATE kullanici SET isim=?, tc=?, iletisim=?, eposta=?, adres=?, dogum_tarihi=?, cinsiyet=?, sube=?, mevki=? WHERE id=?";
        stmt = conn.prepareStatement(sql);

        stmt.setString(1, isim);
        stmt.setString(2, tc);
        stmt.setString(3, iletisim);
        stmt.setString(4, eposta);
        stmt.setString(5, adres);
        stmt.setString(6, dogumTarihi);
        stmt.setString(7, cinsiyet);
        stmt.setString(8, sube);
        stmt.setString(9, mevki);
        stmt.setInt(10, id);

        int guncellendi = stmt.executeUpdate();

         if (guncellendi > 0) {
            response.sendRedirect("ekip.jsp?durum=guncellendi");
        } else {
            response.sendRedirect("ekip.jsp?durum=basarisiz");
        }
         
    } catch (Exception e) {
        out.println("Hata oluştu: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
