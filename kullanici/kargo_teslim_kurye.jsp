<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>


<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>

<%
    String idStr = request.getParameter("id");
    if (idStr == null || idStr.isEmpty()) {
        out.println("<h3>Hatalı istek. Kargo ID'si bulunamadı.</h3>");
        return;
    }

    int id = Integer.parseInt(idStr);
    String dbname = "kargosistemi";
%>

<!-- bu alt kurye seçimi için -->

<%
     String sube = request.getParameter("sube");
    // Şubeleri listelemek için
    Connection connSube = null;
    PreparedStatement stmtSube = null;
    ResultSet rsSube = null;
    List<String> subeListesi = new ArrayList<>();

    try {
         connSube = VeritabaniBaglanti.getConnection("kargosistemi");
    String sqlSube = "SELECT isim FROM kullanici WHERE sube = ? AND mevki = 'Kurye'";
    stmtSube = connSube.prepareStatement(sqlSube);
    stmtSube.setString(1, sube);  
        rsSube = stmtSube.executeQuery();

        while (rsSube.next()) {
            subeListesi.add(rsSube.getString("isim"));
        }

    } catch (Exception e) {
        out.println("⚠️ Şube verileri çekilemedi: " + e.getMessage());
    } finally {
        if (rsSube != null) rsSube.close();
        if (stmtSube != null) stmtSube.close();
        if (connSube != null) connSube.close();
    }
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Kargo Detayı</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            padding: 40px;
        }
        .container {
            background: white;
            padding: 30px;
            max-width: 900px;
            margin: auto;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        td.label {
            font-weight: bold;
            background-color: #f0f0f0;
            width: 250px;
        }
        .back-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📦 Kargo Detayları</h2>
    <% 
        try {
            Connection conn = VeritabaniBaglanti.getConnection(dbname);
            String sql = "SELECT * FROM kargo WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
    %>
    <table>
        <tr><td class="label">Gönderici</td><td><%= rs.getString("gonderici_adsoyad") %> - <%= rs.getString("gonderici_tel") %></td></tr>
        <tr><td class="label">Alıcı</td><td><%= rs.getString("alici_adsoyad") %> - <%= rs.getString("alici_tel") %></td></tr>
   
        <tr><td class="label">Adres</td><td><%= rs.getString("adres") %></td></tr>
        <tr><td class="label">Takip No</td><td><%= rs.getString("takip_no") %></td></tr>
   
        <tr><td class="label">Teslim Eden Kurye</td><td><%= rs.getString("teslim_eden") %></td></tr>
        


    </table>
        <br>
  <form method="post" action="">
    <label>Kurye Seç:</label><br>
    <select name="seciliKurye" required>
        <% for(String kurye : subeListesi) { %>
            <option value="<%= kurye %>"><%= kurye %></option>
        <% } %>
        <option value="Belirtmek istemiyorum">-</option>
    </select>
    <br><br>
    <button type="submit">Teslim Edeni Güncelle</button>
</form>
<%
    String seciliKurye = request.getParameter("seciliKurye");
    if (seciliKurye != null && !seciliKurye.isEmpty()) {
        Connection connGuncelle = null;
        PreparedStatement stmtGuncelle = null;

        try {
            connGuncelle = VeritabaniBaglanti.getConnection(dbname);
            String sqlGuncelle = "UPDATE kargo SET teslim_eden = ? WHERE id = ?";
            stmtGuncelle = connGuncelle.prepareStatement(sqlGuncelle);
            stmtGuncelle.setString(1, seciliKurye);
            stmtGuncelle.setInt(2, id);

            int guncellenen = stmtGuncelle.executeUpdate();
            if (guncellenen > 0) {
                out.println("<p style='color:green;'>Teslim eden başarıyla güncellendi ✅</p>");
            } else {
                out.println("<p style='color:red;'>Güncelleme başarısız ❌</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Hata oluştu: " + e.getMessage() + "</p>");
        } finally {
            if (stmtGuncelle != null) stmtGuncelle.close();
            if (connGuncelle != null) connGuncelle.close();
        }
    }
%>

    <br>
    <%
            } else {
                out.println("<p>Kargo bulunamadı.</p>");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Hata oluştu: " + e.getMessage() + "</p>");
        }
    %>
    <a href="kargolar.jsp" class="back-btn">← Geri Dön</a>
</div>

</body>
</html>
