import SwiftUI

struct EyeExerciseView: View {
    @StateObject private var progressManager = ProgressManager.shared
    @State private var selectedExercise: EyeExercise?
    @State private var showExercise = false
    
    let exercises: [EyeExercise] = [
        // BAŞLANGIÇ SEVİYESİ
        EyeExercise(
            id: "focus_near_far",
            title: "Yakın-Uzak Odaklama",
            description: "Göz kaslarınızı güçlendiren ve odak mesafenizi geliştiren temel egzersiz",
            difficulty: .beginner,
            duration: 90,
            type: .focusing,
            instructions: [
                "Rahat bir pozisyonda oturun ve omuzlarınızı gevşetin",
                "Başparmağınızı göz hizasında 25 cm uzaklıkta tutun (5 saniye)",
                "Uzaktaki bir nesneye odaklanın (5 saniye)",
                "Orta mesafedeki bir nesneye odaklanın (5 saniye)",
                "Yakın-orta-uzak sıralamasını düzenli tekrarlayın",
                "Her mesafe değişiminde iki kez göz kırpın",
                "10 tekrar sonrası 15 saniye dinlenin",
                "Egzersizi 3 set halinde yapın"
            ],
            category: .depthFocus
        ),
        
        EyeExercise(
            id: "palm_exercise",
            title: "Avuç İçi Dinlendirme",
            description: "Göz yorgunluğunu azaltan ve gözleri yenileyen rahatlama egzersizi",
            difficulty: .beginner,
            duration: 120,
            type: .focusing,
            instructions: [
                "Ellerinizi 15 saniye boyunca hızlıca ovuşturarak ısıtın",
                "Avuç içlerinizi çukurlaştırarak gözlerinizin üzerine yerleştirin",
                "Işık sızmasını tamamen engelleyin ama baskı uygulamayın",
                "Derin nefesler alarak karanlığa odaklanın",
                "Gözlerinizi yavaşça sağa-sola hareket ettirin",
                "Her 30 saniyede bir ellerinizi tekrar ısıtın",
                "Son 10 saniye gözlerinizi sıkıca kapatın",
                "Gözlerinizi açmadan önce 10 saniye bekleyin"
            ],
            category: .focus
        ),

        EyeExercise(
            id: "butterfly_blink",
            title: "Kelebek Kırpma",
            description: "Göz kuruluğunu önleyen ve göz kapaklarını güçlendiren egzersiz",
            difficulty: .beginner,
            duration: 60,
            type: .focusing,
            instructions: [
                "Gözlerinizi normal hızda 10 kez kırpın",
                "Çok yavaş şekilde 5 kez kırpın (her kırpma 3 saniye)",
                "Gözlerinizi sıkıca kapatıp 5 saniye tutun",
                "Gözlerinizi büyük açıp 3 saniye tutun",
                "Bu seriyi 3 kez tekrarlayın",
                "Her seri arasında 10 saniye dinlenin",
                "Son seride kırpma hızını artırın",
                "Egzersiz sonrası gözlerinizi dinlendirin"
            ],
            category: .focus
        ),

        // ORTA SEVİYE
        EyeExercise(
            id: "figure_eight",
            title: "8 Çizme",
            description: "Göz kaslarını çok yönlü çalıştıran ve koordinasyonu geliştiren egzersiz",
            difficulty: .intermediate,
            duration: 180,
            type: .movement,
            instructions: [
                "Gözlerinizin önünde büyük bir 8 rakamı hayal edin",
                "Yatay 8 çizmeye başlayın (40 saniye, her 8 için 5 saniye)",
                "Dikey 8 çizmeye geçin (40 saniye)",
                "Çapraz ve farklı boyutlarda 8'ler çizin (40 saniye)",
                "Her yön değişiminde 5 saniye dinlenin",
                "8'leri giderek küçültün ve büyütün",
                "Son 20 saniye gözleri zıt yönde hareket ettirin",
                "Baş sabit kalacak şekilde egzersizi tamamlayın"
            ],
            category: .horizontal
        ),
        
        EyeExercise(
            id: "clock_exercise",
            title: "Saat Yönü",
            description: "Dairesel göz hareketleriyle kas kontrolünü ve esnekliği geliştiren egzersiz",
            difficulty: .intermediate,
            duration: 240,
            type: .movement,
            instructions: [
                "Karşınızda büyük bir duvar saati hayal edin",
                "12'den başlayarak saat yönünde ilerleyin (her rakamda 3 saniye)",
                "Tam tur sonrası ters yönde ilerleyin",
                "Çapraz rakamlara atlayarak (1-7, 2-8 gibi) devam edin",
                "Rakamlar arası geçişleri yavaşça yapın",
                "Her 60 saniyede bir gözlerinizi dinlendirin",
                "Son turda rakamlar arası geçişleri hızlandırın",
                "Egzersizi küçük bir saat hayal ederek tekrarlayın"
            ],
            category: .focus
        ),

        EyeExercise(
            id: "square_rotation",
            title: "Kare Rotasyon",
            description: "Göz kaslarının kontrollü ve hassas hareketini geliştiren egzersiz",
            difficulty: .intermediate,
            duration: 150,
            type: .movement,
            instructions: [
                "Karşınızda bir kare hayal edin",
                "Her köşede 3 saniye durun ve odaklanın",
                "Köşeler arası geçişi düz çizgide yapın",
                "5 tur saat yönünde, 5 tur ters yönde dönün",
                "Kareyi döndürerek egzersizi tekrarlayın",
                "Karenin boyutunu değiştirerek devam edin",
                "Son 30 saniye köşeden köşeye çapraz geçin",
                "Her 50 saniyede bir kısa mola verin"
            ],
            category: .diagonal
        ),

        // İLERİ SEVİYE
        EyeExercise(
            id: "diagonal_tracking",
            title: "Çapraz Takip",
            description: "Göz kaslarını zorlayan ve koordinasyonu geliştiren ileri düzey egzersiz",
            difficulty: .advanced,
            duration: 210,
            type: .tracking,
            instructions: [
                "Sol üst köşeden sağ alt köşeye bakın (3 saniye)",
                "Sağ üst köşeden sol alt köşeye bakın (3 saniye)",
                "Köşeler arası zigzag çizerek ilerleyin (30 saniye)",
                "Zigzagları giderek küçültün ve hızlandırın",
                "Çapraz hareketleri farklı açılarla tekrarlayın",
                "Her 30 saniyede bir yön değiştirin",
                "Son 30 saniye gözleri bağımsız hareket ettirmeyi deneyin",
                "Baş dönmesi olursa hemen ara verin"
            ],
            category: .diagonal
        ),
        
        EyeExercise(
            id: "infinity_loop",
            title: "Sonsuzluk Döngüsü",
            description: "Karmaşık göz hareketleriyle koordinasyonu geliştirin",
            difficulty: .advanced,
            duration: 180,
            type: .coordination,
            instructions: [
                "Yatay sonsuzluk işareti çizmeye başlayın",
                "Hareketi giderek büyütün (30 saniye)",
                "Hareketi giderek küçültün (30 saniye)",
                "Dikey sonsuzluk işaretine geçin",
                "Farklı boyutlarda çizmeye devam edin",
                "Her boyut değişiminde 3 saniye bekleyin"
            ],
            category: .horizontal
        ),

        // UZMAN SEVİYE
        EyeExercise(
            id: "rapid_movement",
            title: "Hızlı Hareket",
            description: "Göz kaslarının tepki süresini geliştiren zorlu egzersiz",
            difficulty: .expert,
            duration: 210,
            type: .speed,
            instructions: [
                "Hızlı sağ-sol göz hareketleri (20 saniye)",
                "Hızlı yukarı-aşağı hareketleri (20 saniye)",
                "Çapraz hızlı hareketler (20 saniye)",
                "Her seri arasında 5 saniye dinlenin",
                "Hareketleri giderek hızlandırın",
                "Baş dönmesi olursa hemen durun"
            ],
            category: .horizontal
        ),
        
        EyeExercise(
            id: "complex_pattern",
            title: "Karmaşık Desen",
            description: "Tüm göz kaslarını zorlayan kapsamlı egzersiz",
            difficulty: .expert,
            duration: 240,
            type: .coordination,
            instructions: [
                "Kare çizin ve köşelerde 2'şer saniye durun",
                "Üçgen çizin ve kenarlarda zigzag yapın",
                "Daire çizin ve yarıçapı değiştirin",
                "Tüm şekilleri birleştiren bir desen çizin",
                "Deseni önce yavaş sonra hızlı tekrarlayın",
                "Her şekil değişiminde göz kırpın"
            ],
            category: .diagonal
        ),
        
        // ÖZEL EGZERSİZLER
        EyeExercise(
            id: "focus_training",
            title: "Odak Antrenmanı",
            description: "Odaklanma süresini ve netliğini artıran egzersiz",
            difficulty: .expert,
            duration: 300,
            type: .focusing,
            instructions: [
                "Bir kalem tutun ve kol boyu mesafede tutun",
                "Kalemi burnunuza doğru yavaşça yaklaştırın",
                "Odağı kaybetmeden en yakın noktayı bulun",
                "Bu noktada 3 saniye tutun ve geri uzaklaştırın",
                "Her tekrarda daha yakın noktalara odaklanın",
                "10 tekrar sonrası 15 saniye dinlenin"
            ],
            category: .depthFocus
        ),
        
        EyeExercise(
            id: "peripheral_vision",
            title: "Çevresel Görüş",
            description: "Görüş alanını genişleten ileri düzey egzersiz",
            difficulty: .expert,
            duration: 270,
            type: .tracking,
            instructions: [
                "Karşıya sabit bakın ve kollarınızı yana açın",
                "Parmakları oynatarak hareketi farkedin",
                "Kolları yavaşça arkaya doğru götürün",
                "Görüş alanı sınırını zorlayın",
                "Baş sabit kalacak şekilde görüş alanını genişletin",
                "Her 45 saniyede bir 15 saniye dinlenin"
            ],
            category: .focus
        )
    ]
    
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                ExerciseRowView(exercise: exercise)
                    .onTapGesture {
                        selectedExercise = exercise
                        showExercise = true
                    }
            }
        }
        .navigationTitle("Göz Egzersizleri")
        .sheet(isPresented: $showExercise) {
            if let exercise = selectedExercise {
                ExerciseDetailView(exercise: exercise)
            }
        }
    }
}

struct ExerciseRowView: View {
    let exercise: EyeExercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(exercise.title)
                    .font(.headline)
                Spacer()
                exercise.difficulty.badge
            }
            
            Text(exercise.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "clock")
                Text("\(exercise.duration) saniye")
                
                Spacer()
                
                Image(systemName: exercise.type.icon)
                Text(exercise.type.rawValue)
            }
            .font(.caption)
            .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
} 
