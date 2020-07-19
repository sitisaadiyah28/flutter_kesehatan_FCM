-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 19 Jul 2020 pada 15.43
-- Versi Server: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kesehatan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kesehatan`
--

CREATE TABLE `tb_kesehatan` (
  `id_kesehatan` int(11) NOT NULL,
  `judul` varchar(191) NOT NULL,
  `deskripsi` text NOT NULL,
  `image` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kesehatan`
--

INSERT INTO `tb_kesehatan` (`id_kesehatan`, `judul`, `deskripsi`, `image`, `date`) VALUES
(1, 'Atasi Stunting Pada Anak', 'Atasi Stunting Pada Anak', 'Stunting1.jpg', '2019-07-19'),
(12, 'Diare Pada Anak', 'Diare adalah kondisi yang ditandai dengan meningkatnya frekuensi buang air besar (BAB) menjadi 3 kali atau lebih dalam sehari, dengan tinja yang lebih cair. Laporan dari Badan Kesehatan Dunia (WHO) menunjukkan bahwa sekitar 525.000 anak balita meninggal setiap tahunnya akibat diare.', 'image_picker3588208494057409201.jpg', '2019-07-19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_kesehatan`
--
ALTER TABLE `tb_kesehatan`
  ADD PRIMARY KEY (`id_kesehatan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_kesehatan`
--
ALTER TABLE `tb_kesehatan`
  MODIFY `id_kesehatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
