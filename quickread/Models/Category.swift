import Foundation

enum Category: String, CaseIterable {
    case story = "Hikaye"
    case science = "Bilim"
    case history = "Tarih"
    case literature = "Edebiyat"
    case technology = "Teknoloji"
    case article = "Makale"
    
    var icon: String {
        switch self {
        case .story: return "book"
        case .science: return "atom"
        case .history: return "clock"
        case .literature: return "text.book.closed"
        case .technology: return "cpu"
        case .article: return "doc.text"
        }
    }
} 