-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 12 May 2025, 16:47:35
-- Sunucu sürümü: 10.4.27-MariaDB
-- PHP Sürümü: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `kargosistemi`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kargo`
--

CREATE TABLE `kargo` (
  `id` int(11) NOT NULL,
  `gonderici_adsoyad` varchar(100) DEFAULT NULL,
  `gonderici_tel` varchar(20) DEFAULT NULL,
  `alici_adsoyad` varchar(100) DEFAULT NULL,
  `alici_tel` varchar(20) DEFAULT NULL,
  `kargo_turu` varchar(50) DEFAULT NULL,
  `agirlik` decimal(5,2) DEFAULT NULL,
  `gonderim_tarihi` date DEFAULT NULL,
  `tahmini_teslim_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `takip_no` varchar(30) DEFAULT NULL,
  `durum` varchar(50) DEFAULT 'Hazırlanıyor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `kargo`
--

INSERT INTO `kargo` (`id`, `gonderici_adsoyad`, `gonderici_tel`, `alici_adsoyad`, `alici_tel`, `kargo_turu`, `agirlik`, `gonderim_tarihi`, `tahmini_teslim_tarihi`, `adres`, `takip_no`, `durum`) VALUES
(1, 'besat arasd', '05347018132', 'sdf', 'sdfsd', 'Ekspres', '23.00', '2025-05-12', '2025-05-12', 'sdfsdfsdfsdf', '12323', 'Hazırlanıyor'),
(3, 'fgdfg', 'dfgdfg', 'dfgdfg', 'dfsdf', 'Yurt DÄ±ÅÄ±', '12.00', '2002-12-12', '2025-05-14', 'dfsd', '1322', 'Hazırlanıyor');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanici`
--

CREATE TABLE `kullanici` (
  `id` int(11) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  `pin` varchar(100) NOT NULL,
  `isim` varchar(255) DEFAULT NULL,
  `iletisim` varchar(20) DEFAULT NULL,
  `tc` varchar(11) DEFAULT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `cinsiyet` varchar(10) DEFAULT NULL,
  `mevki` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `kullanici`
--

INSERT INTO `kullanici` (`id`, `eposta`, `pin`, `isim`, `iletisim`, `tc`, `dogum_tarihi`, `adres`, `cinsiyet`, `mevki`) VALUES
(1, 'besat@gmail.com', '1234', 'Besat', '05347018131', '324234234', '2025-05-05', 'çorlu', 'erkek', 'Çalışan'),
(2, 'dilan@example.com', 'abcd', NULL, NULL, NULL, NULL, NULL, NULL, 'Çalışan'),
(3, 'cansu@gmail.com', '697021', 'Cansu Karasu', '3423423432', '2454325345', '2025-05-12', 'ankara', 'KadÄ±n', 'Kurye'),
(5, 'elif@gmail.com', '341730', 'Elif AydÄ±n', '34234234562', '24543245', '2025-05-12', 'jldsfnlsdf', 'KadÄ±n', 'Kurye');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yonetici`
--

CREATE TABLE `yonetici` (
  `id` int(11) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `isim` varchar(100) DEFAULT NULL,
  `iletisim` varchar(20) DEFAULT NULL,
  `tc` varchar(11) DEFAULT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `cinsiyet` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `yonetici`
--

INSERT INTO `yonetici` (`id`, `eposta`, `pin`, `isim`, `iletisim`, `tc`, `dogum_tarihi`, `adres`, `cinsiyet`) VALUES
(1, 'besatt@gmail.com', '1234', 'Besat', '05347018131', '35345345', '2025-05-05', 'Tekirdağ', 'Erkek');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `kargo`
--
ALTER TABLE `kargo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `takip_no` (`takip_no`);

--
-- Tablo için indeksler `kullanici`
--
ALTER TABLE `kullanici`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `eposta` (`eposta`);

--
-- Tablo için indeksler `yonetici`
--
ALTER TABLE `yonetici`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `eposta` (`eposta`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kargo`
--
ALTER TABLE `kargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `kullanici`
--
ALTER TABLE `kullanici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Tablo için AUTO_INCREMENT değeri `yonetici`
--
ALTER TABLE `yonetici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
