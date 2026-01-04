import 'dart:io';

// Enum değişkenlerin alabileceği degerler sabit olduğunda kullanılır
enum BookCategory {
  Novel,
  Science,
  History,
  Technology
}


class Book {
  String title;
  String author;
  int pageCount;
  BookCategory category;
  bool isAvailable;

  // constructor
  Book({
    required this.title,
    required this.author,
    required this.pageCount,
    required this.category,
    this.isAvailable = true
  });
}


class Library {

  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
    print("\n[EKLEME] '${book.title}' kütüphaneye eklendi.");
  }

  // Tüm kitapları listeleme
  void listBooks() {
    if (books.isEmpty) {
      print("Kütüphanede hiç kitap yok.");
      return;
    }
    print("--- TÜM KİTAPLAR ---");
    for (var book in books) {
      String availability = book.isAvailable ? "Müsait" : "Ödünçte";
      print("- ${book.title} (Yazar: ${book.author}, Kategori: ${book.category.name}, Durum: $availability)");
    }
  }

  void listAvailableBooks() {
    print("--- MÜSAİT KİTAPLAR ---");
    bool found = false;
    for (var book in books) {
      if (book.isAvailable) {
        print("- ${book.title} (Yazar: ${book.author})");
        found = true;
      }
    }
    if (!found) {
      print("Şu anda müsait kitap bulunmamaktadır.");
    }
  }

  void search(String keyword) {
    print("--- ARAMA SONUÇLARI ('$keyword') ---");
    bool found = false;
    for (var book in books) {
      if (book.title.toLowerCase().contains(keyword.toLowerCase())) {
        String availability = book.isAvailable ? "Müsait" : "Ödünçte";
        print("Bulundu: ${book.title} (Yazar: ${book.author}, Durum: $availability)");
        found = true;
      }
    }
    if (!found) {
      print("Kitap bulunamadı.");
    }
  }
}

void main() {
  Library lib = Library();

  lib.addBook(Book(
      title: "Masumiyet Müzesi",
      author: "Orhan Pamuk",
      pageCount: 500,
      category: BookCategory.Novel
  ));

  lib.addBook(Book(
      title: "Kozmos",
      author: "Carl Sagan",
      pageCount: 300,
      category: BookCategory.Science
  ));

  lib.addBook(Book(
      title: "Nutuk",
      author: "Mustafa Kemal Atatürk",
      pageCount: 450,
      category: BookCategory.History,
      isAvailable: false // ödunc
  ));

  while (true) { // kullanıcı çıkışa basmadığı sürece menüyü ekrana getirmesi için yaptim
    print("=============================");
    print("=== KÜTÜPHANE YÖNETİM SİSTEMİ ===");
    print("1 - Tüm kitapları listele");
    print("2 - Müsait kitapları listele");
    print("3 - Kitap ara");
    print("4 - Çıkış");
    print("=============================");

    stdout.write("Lütfen bir seçim yapın (1-4): "); // imlecin aynı satırda kalması
    var input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("Lütfen geçerli bir değer girin.");
      continue;
    }

    var choice = int.tryParse(input);

    if (choice == null) {
      print("Hatalı giriş! Lütfen bir sayı girin.");
      continue;
    }


    switch (choice) {
      case 1:
        lib.listBooks();
        break;
      case 2:
        lib.listAvailableBooks();
        break;
      case 3:
        stdout.write("Aramak istediğiniz kitap adı veya kelimeyi girin: ");
        var key = stdin.readLineSync(); // Kullanıcı  d alma
        if (key != null && key.isNotEmpty) {
          lib.search(key);
        } else {
          print("Arama kelimesi boş olamaz.");
        }
        break;
      case 4:
        print("Kütüphane sisteminden çıkılıyor. Hoşça kalın!");
        return;
      default:
        print("Geçersiz seçim ($choice). Lütfen 1 ile 4 arasında bir değer girin.");
    }
  }
}
