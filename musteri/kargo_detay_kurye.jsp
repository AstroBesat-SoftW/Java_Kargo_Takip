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
        <tr><td class="label">Kargo Türü</td><td><%= rs.getString("kargo_turu") %></td></tr>
        <tr><td class="label">Ağırlık</td><td><%= rs.getDouble("agirlik") %> kg</td></tr>
        <tr><td class="label">Gönderim Tarihi</td><td><%= rs.getDate("gonderim_tarihi") %></td></tr>
        <tr><td class="label">Tahmini Teslim Tarihi</td><td><%= rs.getDate("tahmini_teslim_tarihi") %></td></tr>
        <tr><td class="label">Adres</td><td><%= rs.getString("adres") %></td></tr>
        <tr><td class="label">Takip No</td><td><%= rs.getString("takip_no") %></td></tr>
        <tr><td class="label">Durum</td><td><%= rs.getString("durum") %></td></tr>
        <tr><td class="label">En</td><td><%= rs.getDouble("en") %> cm</td></tr>
        <tr><td class="label">Boy</td><td><%= rs.getDouble("boy") %> cm</td></tr>
        <tr><td class="label">Ücret</td><td><%= rs.getDouble("ucret") %> ₺</td></tr>
        <tr><td class="label">Şube</td><td><%= rs.getString("sube") %></td></tr>
        <tr><td class="label">Müşteri Notu</td><td><%= rs.getString("musteri_not") %></td></tr>
    </table>
    
         <br>
          
           <%    if ("Teslim Edilmek Uzere Yola Cikti".equalsIgnoreCase(rs.getString("durum")))

             { %>
  <style>
    .not-formu {
        background-color: #f8f9fa;
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 10px;
        margin-top: 15px;
        width: 100%;
        max-width: 400px;
    }

    .not-formu label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    .not-formu input[type="text"] {
        width: 100%;
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .not-formu button {
        margin-top: 10px;
        padding: 10px 15px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .not-formu button:hover {
        background-color: #218838;
    }
</style>

<form method="post" action="" class="not-formu">
    <label>Kuryeye Not Bırak:</label>
    <input type="text" name="musteri_not" required>
  
    <button type="submit">Notu Gönder</button>
</form>
       <%   }else {%>
              
 <%   }%>
<%
    String seciliKurye = request.getParameter("musteri_not");
    if (seciliKurye != null && !seciliKurye.isEmpty()) {
        Connection connGuncelle = null;
        PreparedStatement stmtGuncelle = null;
       
        try {
            connGuncelle = VeritabaniBaglanti.getConnection(dbname);
            String sqlGuncelle = "UPDATE kargo SET musteri_not = ? WHERE id = ?";
            stmtGuncelle = connGuncelle.prepareStatement(sqlGuncelle);
            stmtGuncelle.setString(1, seciliKurye);
            stmtGuncelle.setInt(2, id);

            int guncellenen = stmtGuncelle.executeUpdate();
            if (guncellenen > 0) {
                out.println("<p style='color:green;'>Not Eklendi ✅</p>");
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
    <a href="kargolar_kurye.jsp" class="back-btn">← Geri Dön</a>
</div>

</body>
</html>
