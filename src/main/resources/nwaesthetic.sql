-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20260524.6165a6f84f
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 09, 2026 at 02:34 PM
-- Server version: 9.6.0
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nwaesthetic`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `pengguna_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username_snapshot` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `aksi` enum('LOGIN','LOGOUT','TAMBAH','UBAH','HAPUS','BATAL','CETAK','LAINNYA') COLLATE utf8mb4_general_ci NOT NULL,
  `modul` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `referensi_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ringkasan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `data_sebelum` json DEFAULT NULL,
  `data_sesudah` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_paket`
--

CREATE TABLE `detail_paket` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `paket_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `treatment_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah_sesi` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_paket_pasien`
--

CREATE TABLE `detail_paket_pasien` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `paket_pasien_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `treatment_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `total_sesi` int NOT NULL,
  `sisa_sesi` int NOT NULL,
  `status` enum('AKTIF','HABIS','KADALUARSA') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `transaksi_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `tipe_item` enum('TREATMENT','PAKET','PRODUK') COLLATE utf8mb4_general_ci NOT NULL,
  `treatment_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `paket_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `produk_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `paket_pasien_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Terisi jika treatment menggunakan sesi paket pasien',
  `nama_item_snapshot` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nama item saat transaksi terjadi',
  `qty` int NOT NULL DEFAULT '1',
  `harga_normal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `diskon_persen` decimal(5,2) NOT NULL DEFAULT '0.00',
  `diskon_nominal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `harga` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Harga final per unit saat transaksi',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subtotal` decimal(15,2) GENERATED ALWAYS AS ((`qty` * `harga`)) STORED
) ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_pengeluaran`
--

CREATE TABLE `kategori_pengeluaran` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_pengeluaran`
--

INSERT INTO `kategori_pengeluaran` (`id`, `nama`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
('8e4b95ad-db8c-11f1-80f1-0a002700000e', 'OPERASIONAL', 'Pengeluaran operasional umum klinik', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35'),
('8e4bef26-db8c-11f1-80f1-0a002700000e', 'GAJI', 'Pembayaran gaji atau honor', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35'),
('8e4bf116-db8c-11f1-80f1-0a002700000e', 'LISTRIK_AIR', 'Tagihan listrik dan air', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35'),
('8e4bf1b5-db8c-11f1-80f1-0a002700000e', 'SEWA', 'Biaya sewa tempat', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35'),
('8e4bf246-db8c-11f1-80f1-0a002700000e', 'PEMBELIAN_STOK', 'Pembelian persediaan produk', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35'),
('8e4bf2dc-db8c-11f1-80f1-0a002700000e', 'LAINNYA', 'Pengeluaran lain di luar kategori utama', 'AKTIF', '2026-11-08 15:53:35', '2026-11-08 15:53:35');

-- --------------------------------------------------------

--
-- Table structure for table `paket`
--

CREATE TABLE `paket` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `kode_paket` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `harga_normal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `jenis_diskon` enum('TANPA_DISKON','PERSEN','NOMINAL') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'TANPA_DISKON',
  `nilai_diskon` decimal(15,2) NOT NULL DEFAULT '0.00',
  `harga` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Harga jual akhir paket setelah diskon',
  `masa_berlaku_hari` int NOT NULL DEFAULT '30',
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `paket_pasien`
--

CREATE TABLE `paket_pasien` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `pasien_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `paket_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `detail_transaksi_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Detail transaksi saat paket dibeli',
  `total_sesi` int NOT NULL,
  `sisa_sesi` int NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tgl_kadaluarsa` date DEFAULT NULL,
  `status` enum('AKTIF','HABIS','KADALUARSA') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `kode_pasien` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `no_hp` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_general_ci,
  `catatan_kulit` text COLLATE utf8mb4_general_ci COMMENT 'Jenis kulit, alergi, atau keluhan yang relevan',
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `transaksi_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_bayar` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `jumlah` decimal(15,2) NOT NULL,
  `metode` enum('TUNAI','TRANSFER','QRIS','DEBIT','KREDIT') COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `pengaturan_keuangan`
--

CREATE TABLE `pengaturan_keuangan` (
  `id` tinyint UNSIGNED NOT NULL,
  `tanggal_efektif` date NOT NULL,
  `saldo_awal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `pengaturan_keuangan`
--

INSERT INTO `pengaturan_keuangan` (`id`, `tanggal_efektif`, `saldo_awal`, `updated_at`) VALUES
(1, '2026-11-08', 0.00, '2026-11-08 15:53:35');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `pengguna_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `kategori_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `status` enum('AKTIF','DIBATALKAN') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Hash BCrypt/Argon2, bukan password teks biasa',
  `role` enum('ADMIN','KASIR') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'KASIR',
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `username`, `password`, `role`, `status`, `created_at`, `updated_at`) VALUES
('6040d8c9-dc03-11f1-8ba7-0a002700000e', 'admin', '$2a$12$/zdb4Iu.k54m6aFpFqbhC.sN9a.77K61c0xb89ekVJOmGWNmYwQTS', 'ADMIN', 'AKTIF', '2026-11-09 06:04:08', '2026-11-09 06:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `kode_produk` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_general_ci,
  `harga_jual` decimal(15,2) NOT NULL DEFAULT '0.00',
  `stok` int NOT NULL DEFAULT '0',
  `stok_minimum` int NOT NULL DEFAULT '5',
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_stok`
--

CREATE TABLE `riwayat_stok` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `produk_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `pengguna_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `detail_transaksi_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jenis` enum('MASUK','KELUAR','PENYESUAIAN') COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah` int NOT NULL,
  `stok_sebelum` int NOT NULL,
  `stok_sesudah` int NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `nomor_transaksi` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `pasien_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `pengguna_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status_bayar` enum('BELUM_BAYAR','LUNAS') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'BELUM_BAYAR',
  `status_transaksi` enum('AKTIF','DIBATALKAN') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `catatan` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT (uuid()),
  `kode_treatment` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_general_ci,
  `durasi_menit` int DEFAULT NULL,
  `harga` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('AKTIF','NONAKTIF') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'AKTIF',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_laporan_data_treatment`
-- (See below for the actual view)
--
CREATE TABLE `v_laporan_data_treatment` (
`id` char(36)
,`kode_treatment` varchar(30)
,`nama` varchar(255)
,`harga` decimal(15,2)
,`durasi_menit` int
,`status` enum('AKTIF','NONAKTIF')
,`jumlah_transaksi` bigint
,`total_pelaksanaan` decimal(32,0)
,`pendapatan_langsung` decimal(37,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_laporan_keuangan`
-- (See below for the actual view)
--
CREATE TABLE `v_laporan_keuangan` (
`periode` varchar(7)
,`saldo_awal` decimal(39,2)
,`total_pemasukan` decimal(37,2)
,`total_pengeluaran` decimal(37,2)
,`saldo_akhir` decimal(39,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_laporan_penjualan_paket_produk`
-- (See below for the actual view)
--
CREATE TABLE `v_laporan_penjualan_paket_produk` (
`transaksi_id` char(36)
,`nomor_transaksi` varchar(40)
,`tanggal` datetime
,`nama_pasien` varchar(255)
,`kasir` varchar(50)
,`jenis_item` varchar(6)
,`nama_item` varchar(255)
,`qty` int
,`harga_normal` decimal(15,2)
,`diskon_persen` decimal(5,2)
,`diskon_nominal` decimal(15,2)
,`harga` decimal(15,2)
,`subtotal` decimal(15,2)
,`status_bayar` varchar(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_laporan_transaksi_treatment`
-- (See below for the actual view)
--
CREATE TABLE `v_laporan_transaksi_treatment` (
`transaksi_id` char(36)
,`nomor_transaksi` varchar(40)
,`tanggal` datetime
,`pasien` varchar(255)
,`treatment` varchar(255)
,`qty` int
,`harga` decimal(15,2)
,`subtotal` decimal(15,2)
,`sumber` varchar(14)
,`status_bayar` enum('BELUM_BAYAR','LUNAS')
,`kasir` varchar(50)
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_pengguna` (`pengguna_id`),
  ADD KEY `idx_audit_modul` (`modul`),
  ADD KEY `idx_audit_tanggal` (`created_at`),
  ADD KEY `idx_audit_aksi` (`aksi`);

--
-- Indexes for table `detail_paket`
--
ALTER TABLE `detail_paket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_detail_paket` (`paket_id`,`treatment_id`),
  ADD KEY `idx_detail_paket_treatment` (`treatment_id`);

--
-- Indexes for table `detail_paket_pasien`
--
ALTER TABLE `detail_paket_pasien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_paket_pasien_treatment` (`paket_pasien_id`,`treatment_id`),
  ADD KEY `idx_dpp_treatment` (`treatment_id`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dt_transaksi` (`transaksi_id`),
  ADD KEY `idx_dt_treatment` (`treatment_id`),
  ADD KEY `idx_dt_paket` (`paket_id`),
  ADD KEY `idx_dt_produk` (`produk_id`),
  ADD KEY `idx_dt_paket_pasien` (`paket_pasien_id`),
  ADD KEY `idx_dt_tipe_item` (`tipe_item`);

--
-- Indexes for table `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_kategori_pengeluaran_nama` (`nama`);

--
-- Indexes for table `paket`
--
ALTER TABLE `paket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_paket_kode` (`kode_paket`),
  ADD KEY `idx_paket_nama` (`nama`);

--
-- Indexes for table `paket_pasien`
--
ALTER TABLE `paket_pasien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pp_pasien` (`pasien_id`),
  ADD KEY `idx_pp_paket` (`paket_id`),
  ADD KEY `idx_pp_detail_transaksi` (`detail_transaksi_id`),
  ADD KEY `idx_pp_status_expiry` (`status`,`tgl_kadaluarsa`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pasien_kode` (`kode_pasien`),
  ADD KEY `idx_pasien_nama` (`nama`),
  ADD KEY `idx_pasien_no_hp` (`no_hp`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pembayaran_transaksi` (`transaksi_id`),
  ADD KEY `idx_pembayaran_tgl` (`tgl_bayar`);

--
-- Indexes for table `pengaturan_keuangan`
--
ALTER TABLE `pengaturan_keuangan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pengeluaran_tanggal` (`tanggal`),
  ADD KEY `idx_pengeluaran_kategori` (`kategori_id`),
  ADD KEY `idx_pengeluaran_pengguna` (`pengguna_id`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pengguna_username` (`username`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_produk_kode` (`kode_produk`),
  ADD KEY `idx_produk_nama` (`nama`),
  ADD KEY `idx_produk_stok` (`stok`);

--
-- Indexes for table `riwayat_stok`
--
ALTER TABLE `riwayat_stok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_riwayat_stok_produk` (`produk_id`),
  ADD KEY `idx_riwayat_stok_tanggal` (`created_at`),
  ADD KEY `idx_riwayat_stok_pengguna` (`pengguna_id`),
  ADD KEY `idx_riwayat_stok_detail` (`detail_transaksi_id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_transaksi_nomor` (`nomor_transaksi`),
  ADD KEY `idx_transaksi_tanggal` (`tanggal`),
  ADD KEY `idx_transaksi_pasien` (`pasien_id`),
  ADD KEY `idx_transaksi_pengguna` (`pengguna_id`),
  ADD KEY `idx_transaksi_status` (`status_transaksi`,`status_bayar`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_treatment_kode` (`kode_treatment`),
  ADD KEY `idx_treatment_nama` (`nama`);

-- --------------------------------------------------------

--
-- Structure for view `v_laporan_data_treatment`
--
DROP TABLE IF EXISTS `v_laporan_data_treatment`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_laporan_data_treatment`  AS SELECT `tr`.`id` AS `id`, `tr`.`kode_treatment` AS `kode_treatment`, `tr`.`nama` AS `nama`, `tr`.`harga` AS `harga`, `tr`.`durasi_menit` AS `durasi_menit`, `tr`.`status` AS `status`, coalesce(`x`.`jumlah_transaksi`,0) AS `jumlah_transaksi`, coalesce(`x`.`total_pelaksanaan`,0) AS `total_pelaksanaan`, coalesce(`x`.`pendapatan_langsung`,0.00) AS `pendapatan_langsung` FROM (`treatment` `tr` left join (select `d`.`treatment_id` AS `treatment_id`,count(distinct `t`.`id`) AS `jumlah_transaksi`,sum(`d`.`qty`) AS `total_pelaksanaan`,sum((case when (`d`.`paket_pasien_id` is null) then `d`.`subtotal` else 0 end)) AS `pendapatan_langsung` from (`detail_transaksi` `d` join `transaksi` `t` on((`t`.`id` = `d`.`transaksi_id`))) where ((`d`.`tipe_item` = 'TREATMENT') and (`t`.`status_transaksi` = 'AKTIF') and (`t`.`status_bayar` = 'LUNAS')) group by `d`.`treatment_id`) `x` on((`x`.`treatment_id` = `tr`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `v_laporan_keuangan`
--
DROP TABLE IF EXISTS `v_laporan_keuangan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_laporan_keuangan`  AS WITH   `arus_kas` as (select cast(`p`.`tgl_bayar` as date) AS `tanggal`,`p`.`jumlah` AS `pemasukan`,0.00 AS `pengeluaran` from (`pembayaran` `p` join `transaksi` `t` on((`t`.`id` = `p`.`transaksi_id`))) where (`t`.`status_transaksi` = 'AKTIF') union all select `e`.`tanggal` AS `tanggal`,0.00 AS `pemasukan`,`e`.`nominal` AS `pengeluaran` from `pengeluaran` `e` where (`e`.`status` = 'AKTIF')), `bulanan` as (select date_format(`arus_kas`.`tanggal`,'%Y-%m') AS `periode`,sum(`arus_kas`.`pemasukan`) AS `total_pemasukan`,sum(`arus_kas`.`pengeluaran`) AS `total_pengeluaran` from `arus_kas` group by date_format(`arus_kas`.`tanggal`,'%Y-%m')) select `b`.`periode` AS `periode`,(`k`.`saldo_awal` + coalesce((select sum((`a`.`pemasukan` - `a`.`pengeluaran`)) from `arus_kas` `a` where ((`a`.`tanggal` < str_to_date(concat(`b`.`periode`,'-01'),'%Y-%m-%d')) and (`a`.`tanggal` >= `k`.`tanggal_efektif`))),0.00)) AS `saldo_awal`,`b`.`total_pemasukan` AS `total_pemasukan`,`b`.`total_pengeluaran` AS `total_pengeluaran`,(`k`.`saldo_awal` + coalesce((select sum((`a`.`pemasukan` - `a`.`pengeluaran`)) from `arus_kas` `a` where ((date_format(`a`.`tanggal`,'%Y-%m') <= `b`.`periode`) and (`a`.`tanggal` >= `k`.`tanggal_efektif`))),0.00)) AS `saldo_akhir` from (`bulanan` `b` join `pengaturan_keuangan` `k` on((`k`.`id` = 1)))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_laporan_penjualan_paket_produk`
--
DROP TABLE IF EXISTS `v_laporan_penjualan_paket_produk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_laporan_penjualan_paket_produk`  AS SELECT `t`.`id` AS `transaksi_id`, `t`.`nomor_transaksi` AS `nomor_transaksi`, `t`.`tanggal` AS `tanggal`, `p`.`nama` AS `nama_pasien`, `u`.`username` AS `kasir`, 'PAKET' AS `jenis_item`, `d`.`nama_item_snapshot` AS `nama_item`, `d`.`qty` AS `qty`, `d`.`harga_normal` AS `harga_normal`, `d`.`diskon_persen` AS `diskon_persen`, `d`.`diskon_nominal` AS `diskon_nominal`, `d`.`harga` AS `harga`, `d`.`subtotal` AS `subtotal`, `t`.`status_bayar` AS `status_bayar` FROM (((`transaksi` `t` join `detail_transaksi` `d` on((`d`.`transaksi_id` = `t`.`id`))) join `pasien` `p` on((`p`.`id` = `t`.`pasien_id`))) join `pengguna` `u` on((`u`.`id` = `t`.`pengguna_id`))) WHERE ((`d`.`tipe_item` = 'PAKET') AND (`t`.`status_transaksi` = 'AKTIF'))union all select `t`.`id` AS `transaksi_id`,`t`.`nomor_transaksi` AS `nomor_transaksi`,`t`.`tanggal` AS `tanggal`,`p`.`nama` AS `nama_pasien`,`u`.`username` AS `kasir`,'PRODUK' AS `jenis_item`,`d`.`nama_item_snapshot` AS `nama_item`,`d`.`qty` AS `qty`,`d`.`harga_normal` AS `harga_normal`,`d`.`diskon_persen` AS `diskon_persen`,`d`.`diskon_nominal` AS `diskon_nominal`,`d`.`harga` AS `harga`,`d`.`subtotal` AS `subtotal`,`t`.`status_bayar` AS `status_bayar` from (((`transaksi` `t` join `detail_transaksi` `d` on((`d`.`transaksi_id` = `t`.`id`))) join `pasien` `p` on((`p`.`id` = `t`.`pasien_id`))) join `pengguna` `u` on((`u`.`id` = `t`.`pengguna_id`))) where ((`d`.`tipe_item` = 'PRODUK') and (`t`.`status_transaksi` = 'AKTIF'))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_laporan_transaksi_treatment`
--
DROP TABLE IF EXISTS `v_laporan_transaksi_treatment`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_laporan_transaksi_treatment`  AS SELECT `t`.`id` AS `transaksi_id`, `t`.`nomor_transaksi` AS `nomor_transaksi`, `t`.`tanggal` AS `tanggal`, `p`.`nama` AS `pasien`, `d`.`nama_item_snapshot` AS `treatment`, `d`.`qty` AS `qty`, `d`.`harga` AS `harga`, `d`.`subtotal` AS `subtotal`, (case when (`d`.`paket_pasien_id` is null) then 'BAYAR LANGSUNG' else 'POTONG PAKET' end) AS `sumber`, `t`.`status_bayar` AS `status_bayar`, `u`.`username` AS `kasir` FROM (((`detail_transaksi` `d` join `transaksi` `t` on((`t`.`id` = `d`.`transaksi_id`))) join `pasien` `p` on((`p`.`id` = `t`.`pasien_id`))) join `pengguna` `u` on((`u`.`id` = `t`.`pengguna_id`))) WHERE ((`d`.`tipe_item` = 'TREATMENT') AND (`t`.`status_transaksi` = 'AKTIF')) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_pengguna` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `detail_paket`
--
ALTER TABLE `detail_paket`
  ADD CONSTRAINT `fk_dp_paket` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`),
  ADD CONSTRAINT `fk_dp_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`);

--
-- Constraints for table `detail_paket_pasien`
--
ALTER TABLE `detail_paket_pasien`
  ADD CONSTRAINT `fk_dpp_paket_pasien` FOREIGN KEY (`paket_pasien_id`) REFERENCES `paket_pasien` (`id`),
  ADD CONSTRAINT `fk_dpp_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`);

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `fk_dt_paket` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`),
  ADD CONSTRAINT `fk_dt_paket_pasien` FOREIGN KEY (`paket_pasien_id`) REFERENCES `paket_pasien` (`id`),
  ADD CONSTRAINT `fk_dt_produk` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`),
  ADD CONSTRAINT `fk_dt_transaksi` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`),
  ADD CONSTRAINT `fk_dt_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`);

--
-- Constraints for table `paket_pasien`
--
ALTER TABLE `paket_pasien`
  ADD CONSTRAINT `fk_pp_detail_transaksi` FOREIGN KEY (`detail_transaksi_id`) REFERENCES `detail_transaksi` (`id`),
  ADD CONSTRAINT `fk_pp_paket` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`),
  ADD CONSTRAINT `fk_pp_pasien` FOREIGN KEY (`pasien_id`) REFERENCES `pasien` (`id`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `fk_pembayaran_transaksi` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`);

--
-- Constraints for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `fk_pengeluaran_kategori` FOREIGN KEY (`kategori_id`) REFERENCES `kategori_pengeluaran` (`id`),
  ADD CONSTRAINT `fk_pengeluaran_pengguna` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`id`);

--
-- Constraints for table `riwayat_stok`
--
ALTER TABLE `riwayat_stok`
  ADD CONSTRAINT `fk_rs_detail_transaksi` FOREIGN KEY (`detail_transaksi_id`) REFERENCES `detail_transaksi` (`id`),
  ADD CONSTRAINT `fk_rs_pengguna` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `fk_rs_produk` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_transaksi_pasien` FOREIGN KEY (`pasien_id`) REFERENCES `pasien` (`id`),
  ADD CONSTRAINT `fk_transaksi_pengguna` FOREIGN KEY (`pengguna_id`) REFERENCES `pengguna` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
