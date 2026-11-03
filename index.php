<?php
$pesan = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nama = trim($_POST["nama"] ?? "");
    $kategori = $_POST["kategori"] ?? "";
    $ratingTeks = trim($_POST["rating"] ?? "");
    $kalori = filter_var(
        $_POST["kalori"] ?? "",
        FILTER_VALIDATE_FLOAT
    );
    $rating = $ratingTeks === ""
        ? null
        : filter_var($ratingTeks, FILTER_VALIDATE_FLOAT);

    if (
        $nama === "" ||
        mb_strlen($nama) > 100 ||
        !in_array($kategori, ["sarapan", "makan siang", "snack"], true) ||
        $kalori === false || !is_finite($kalori) ||
        $kalori < 0 || $kalori > 99999999.99 ||
        ($rating !== null &&
            ($rating === false || $rating < 1 || $rating > 5))
    ) {
        $pesan = "Data tidak valid. Periksa kembali isian.";
    } else {
        try {
            // Sesuaikan username dan password MySQL jika berbeda.
            $db = new PDO(
                "mysql:host=localhost;dbname=mbg;charset=utf8mb4",
                "root",
                "",
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );

            $sql = "INSERT INTO Menu
                    (nama_menu, kategori, tingkat_kesukaan, total_kalori)
                    VALUES (?, ?, ?, ?)";

            $db->prepare($sql)->execute([
                $nama, $kategori, $rating, $kalori
            ]);

            $pesan = "Data menu berhasil disimpan.";
        } catch (PDOException $e) {
            $pesan = "Gagal menyimpan data. Periksa koneksi database.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Form Menu MBG</title>
</head>
<body>
    <h2>Form Tambah Menu MBG</h2>

    <form method="post">
        <p>
            <label>Nama menu:<br>
                <input name="nama" maxlength="100" required>
            </label>
        </p>

        <p>
            <label>Kategori:<br>
                <select name="kategori">
                    <option value="sarapan">Sarapan</option>
                    <option value="makan siang">Makan siang</option>
                    <option value="snack">Snack</option>
                </select>
            </label>
        </p>

        <p>
            <label>Tingkat kesukaan (opsional):<br>
                <input type="number" name="rating"
                       min="1" max="5" step="0.01">
            </label>
        </p>

        <p>
            <label>Total kalori (kkal):<br>
                <input type="number" name="kalori"
                       min="0" max="99999999.99"
                       step="0.01" required>
            </label>
        </p>

        <button type="submit">Simpan</button>
    </form>

    <p><?= htmlspecialchars($pesan, ENT_QUOTES, "UTF-8") ?></p>
</body>
</html>
