# 📋 Dokumentasi Firebase Integration - Laporan Kegiatan

## 🎯 Overview
Fitur **Tambah, Edit, dan Delete Laporan** sudah terintegrasi dengan **Firebase** (Firestore + Storage) untuk menyimpan data laporan dan image secara cloud-based.

---

## 📁 Struktur File Baru

```
lib/
├── models/
│   └── laporan_model.dart          ✨ Model untuk Firestore data
├── service/
│   └── laporan_service.dart        ✨ Service untuk Firebase operations
└── pages_laporan dkm/
    ├── tambahlaporan.dart          ✏️ Updated: Firebase integration
    ├── editlaporan.dart            ✏️ Updated: Firebase integration
    └── laporanadmin.dart           ✏️ Updated: Firebase integration
```

---

## 🔧 Dependencies yang Ditambahkan
Pastikan file `pubspec.yaml` memiliki:
```yaml
firebase_storage: ^12.0.0  # Untuk upload image ke Cloud Storage
cloud_firestore: ^6.3.0     # Untuk menyimpan data laporan
firebase_auth: ^6.4.0       # Untuk autentikasi
firebase_core: ^4.7.0       # Core Firebase
```

**Update dependencies dengan menjalankan:**
```bash
flutter pub get
```

---

## 🚀 Fitur yang Tersedia

### 1️⃣ **Tambah Laporan** (TambahLaporanPage)
- ✅ Upload foto dari gallery
- ✅ Input judul dan deskripsi
- ✅ Simpan ke Firebase Firestore + Firebase Storage
- ✅ Loading indicator saat proses upload
- ✅ Validasi input field

**Alur:**
```
User pilih foto → Input judul & deskripsi → Click "Simpan" → 
  Upload foto ke Firebase Storage → 
  Simpan data + image URL ke Firestore → 
  Pop kembali ke list laporan
```

### 2️⃣ **Edit & Delete Laporan** (EditLaporanPage)
- ✅ Edit judul, deskripsi, dan foto
- ✅ Hapus laporan dengan konfirmasi dialog
- ✅ Support image dari URL (Firebase Storage) atau local file
- ✅ Auto replace image lama dengan image baru
- ✅ Loading indicator untuk update dan delete

**Alur Edit:**
```
User edit data → Upload foto baru (opsional) → Click "Update" → 
  Delete foto lama dari Storage (jika ada foto baru) → 
  Upload foto baru → 
  Update dokumen di Firestore → 
  Pop kembali to list
```

**Alur Delete:**
```
User click delete → Konfirmasi dialog → 
  Delete foto dari Storage → 
  Delete dokumen dari Firestore → 
  Pop kembali to list
```

### 3️⃣ **List Laporan** (LaporanAdmin)
- ✅ Fetch data real-time dari Firestore
- ✅ Display image dari Firebase Storage
- ✅ Button edit & delete untuk admin only
- ✅ Empty state dengan Lottie animation
- ✅ Loading state saat fetch data

---

## 🔐 Firebase Setup (PENTING!)

### Step 1: Setup Firebase Project
1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Buat project baru atau gunakan project yang sudah ada
3. Tambahkan app Android/iOS

### Step 2: Setup Firestore Database
1. Di Firebase Console → **Firestore Database**
2. Klik **Create Database**
3. Pilih **Start in test mode** (untuk development)
4. Pilih lokasi database
5. Buat collection baru dengan nama `laporan`

**Struktur collection `laporan`:**
```
laporan (collection)
├── [doc-id-1] (auto-generated)
│   ├── deskripsi: "Deskripsi kegiatan..."
│   ├── gambar: "https://firebasestorge.com/..."
│   ├── judul: "Nama Kegiatan"
│   └── tanggal: Timestamp
├── [doc-id-2]
│   └── ...
```

### Step 3: Setup Firebase Storage
1. Di Firebase Console → **Storage**
2. Klik **Get Started**
3. Atur security rules ke **test mode** dulu
4. Folder path akan otomatis: `laporan/[timestamp].jpg`

### Step 4: Security Rules untuk Production
**Firestore Rules** (`firestore.rules`):
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Admin bisa read/write semua laporan
    match /laporan/{document=**} {
      allow read: if request.auth != null;
      allow create, update, delete: if request.auth != null && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

**Storage Rules** (`storage.rules`):
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /laporan/{allPaths=**} {
      // Anyone authenticated can read
      allow read: if request.auth != null;
      // Only admin can write/delete
      allow write, delete: if request.auth != null && 
        get(/databases/(default)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

---

## 🛠️ Menggunakan LaporanService

### Tambah Laporan
```dart
final service = LaporanService();

await service.addLaporan(
  judul: "Judul Kegiatan",
  deskripsi: "Deskripsi detail kegiatan",
  imageFile: File('/path/to/image.jpg'),
);
```

### Ambil Semua Laporan
```dart
final laporan = await service.getLaporan();
// Returns: List<LaporanModel>
```

### Update Laporan
```dart
await service.updateLaporan(
  laporanId: "doc-id",
  judul: "Judul baru",
  deskripsi: "Deskripsi baru",
  imageFile: newImageFile, // Opsional
  oldImageUrl: "https://firebasestorage.com/...",
);
```

### Hapus Laporan
```dart
await service.deleteLaporan(
  laporanId: "doc-id",
  imageUrl: "https://firebasestorage.com/...",
);
```

### Stream Real-time (Opsional)
```dart
service.getLaporanStream().listen((laporan) {
  // Update UI dengan data real-time
  setState(() {
    laporanList = laporan;
  });
});
```

---

## 📊 LaporanModel Properties

```dart
class LaporanModel {
  final String id;           // Document ID dari Firestore
  final String judul;        // Judul kegiatan
  final String deskripsi;    // Deskripsi kegiatan
  final String gambar;       // URL dari Firebase Storage
  final DateTime tanggal;    // Timestamp laporan dibuat
}
```

---

## ⚠️ Error Handling

Semua method di `LaporanService` menggunakan try-catch dan menampilkan:
- 📌 Log di console (print statements dengan emoji)
- 📌 Exception handling dengan `rethrow`
- 📌 SnackBar error message di UI

**Contoh error UI:**
```
"Gagal menyimpan laporan: [error message]"
```

---

## 🎨 UI/UX Updates

### TambahLaporanPage
- ✨ Loading indicator di button saat upload
- ✨ Validasi form (foto, judul, deskripsi)
- ✨ Success/error snackbar notification

### EditLaporanPage
- 🎨 Tombol Update & Delete side-by-side
- 🎨 Konfirmasi dialog untuk delete
- 🎨 Preview image (local/URL)
- 🎨 Loading indicator untuk semua action

### Laporanadmin
- 📸 Image dari Firebase Storage (network image)
- 📸 Error handler untuk broken image
- 📸 Real-time data update dengan FutureBuilder

---

## 🔍 Testing Checklist

- [ ] Upload laporan dengan foto sukses
- [ ] Data muncul di Firestore Console
- [ ] Foto terupload ke Storage
- [ ] Edit laporan berhasil (data + foto)
- [ ] Delete laporan menghapus dari Firestore & Storage
- [ ] List laporan menampilkan data dari Firestore
- [ ] Image loading dari URL Firebase Storage
- [ ] Error handling berfungsi

---

## 🚨 Common Issues & Solutions

### ❌ Issue: "Permission denied for Firestore"
**Solution:** Update security rules atau check user authenticated

### ❌ Issue: "Image tidak muncul di list"
**Solution:** Check Firebase Storage URL dan pastikan user punya read access

### ❌ Issue: "Upload slow/timeout"
**Solution:** Check internet connection dan ukuran file image

### ❌ Issue: "Old image tidak terhapus saat update"
**Solution:** Pastikan `oldImageUrl` dikirim dengan benar di update method

---

## 📚 File Reference

| File | Purpose |
|------|---------|
| `laporan_model.dart` | Model + serialization |
| `laporan_service.dart` | Firebase CRUD operations |
| `tambahlaporan.dart` | Create laporan UI |
| `editlaporan.dart` | Edit/Delete laporan UI |
| `laporanadmin.dart` | List laporan UI |

---

## 🎯 Next Steps (Optional Improvements)

1. **Pagination** - Limit query per page
2. **Search/Filter** - Filter laporan by date range
3. **Image Compression** - Compress image sebelum upload
4. **Offline Support** - Sync dengan local database saat offline
5. **Share Laporan** - Share ke social media
6. **Comments** - Tambah fitur komentar di laporan

---

**✅ Setup selesai! Selamat menggunakan Firebase integration untuk Laporan Kegiatan** 🚀
