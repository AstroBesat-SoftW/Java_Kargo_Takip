
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

    String dbname = "kargosistemi";
    int id = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String isim = "", tc = "", iletisim = "", eposta = "", adres = "", cinsiyet = "", sube = "", mevki = "";
    Date dogumTarihi = null;

    try {
        conn = VeritabaniBaglanti.getConnection(dbname);
        String sql = "SELECT * FROM kullanici WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        rs = stmt.executeQuery();

        if (rs.next()) {
            isim = rs.getString("isim");
            tc = rs.getString("tc");
            iletisim = rs.getString("iletisim");
            eposta = rs.getString("eposta");
            adres = rs.getString("adres");
            dogumTarihi = rs.getDate("dogum_tarihi");
            cinsiyet = rs.getString("cinsiyet");
            sube = rs.getString("sube");
            mevki = rs.getString("mevki");
        }
    } catch (Exception e) {
        out.println("Hata: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Kişi Düzenle</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            padding: 40px;
        }

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.05);
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            padding: 12px 20px;
            font-size: 16px;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background-color: #27ae60;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>👤 Kişi Bilgilerini Düzenle</h2>
    <form action="kisi_duzenle_kaydet.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <label>İsim:</label>
        <input type="text" name="isim" value="<%= isim %>" required>

        <label>TC:</label>
        <input type="text" name="tc" value="<%= tc %>" required>

        <label>Telefon:</label>
        <input type="text" name="iletisim" value="<%= iletisim %>" required>

        <label>E-posta:</label>
        <input type="email" name="eposta" value="<%= eposta %>" required>

        <label>Adres:</label>
        <textarea name="adres" rows="3" required><%= adres %></textarea>

        <label>Doğum Tarihi:</label>
        <input type="date" name="dogum_tarihi" value="<%= dogumTarihi %>" required>

        <label>Cinsiyet:</label>
        <select name="cinsiyet" required>
            <option value="Erkek" <%= cinsiyet.equals("Erkek") ? "selected" : "" %>>Erkek</option>
            <option value="Kadın" <%= cinsiyet.equals("Kadın") ? "selected" : "" %>>Kadın</option>
        </select>

        <label>Şube:</label>
        <input type="text" name="sube" value="<%= sube %>" required>

        <label>Mevki:</label>
        <select name="mevki" required>
            <option value="Kurye" <%= mevki.equals("Kurye") ? "selected" : "" %>>Kurye</option>
            <option value="Calisan" <%= mevki.equals("Calisan") ? "selected" : "" %>>Calisan</option>
             <option value="Yok" <%= mevki.equals("Yok") ? "selected" : "" %>>Yok</option>
        </select>

        <button type="submit">💾 Kaydet</button>
    </form>
</div>
</body>
</html>
