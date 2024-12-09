import Foundation

// First, let's fix the Status enum syntax and add some functionality
enum Status: Int {
    case horrible = 0
    case bad = 1
    case good = 2
    case perfect = 3
    
    var description: String {
        switch self {
        case .horrible: return "Need to revise immediately"
        case .bad: return "Need more practice"
        case .good: return "Almost perfect"
        case .perfect: return "Mastered"
        }
    }
}

class Surah {
    var name: String
    var number: Int
    var memorization: Int
    var lastRevisionDate: Date?
    var notes: String?
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
        self.memorization = 0
    }
    
    // Update memorization status
    func updateStatus(_ status: Status) {
        self.memorization = status.rawValue
        self.lastRevisionDate = Date()
    }
    
    // Add notes about specific verses or areas of improvement
    func addNotes(_ newNotes: String) {
        self.notes = newNotes
    }
    
    // Get current status as enum
    var currentStatus: Status? {
        return Status(rawValue: memorization)
    }
    
    // Check if surah needs revision (e.g., if it's been more than 7 days)
    var needsRevision: Bool {
        guard let lastRevision = lastRevisionDate else { return true }
        let calendar = Calendar.current
        let daysSinceLastRevision = calendar.dateComponents([.day],
                                                          from: lastRevision,
                                                          to: Date()).day ?? 0
        return daysSinceLastRevision >= 7 || memorization < Status.good.rawValue
    }
    
    // Get a readable status description
    var statusDescription: String {
        guard let status = Status(rawValue: memorization) else {
            return "Unknown"
        }
        return status.description
    }
}

// A simple manager class to handle multiple surahs
class RevisionManager {
    private var surahs: [Surah] = []
    
    // Add a new surah
    func addSurah(_ surah: Surah) {
        surahs.append(surah)
    }
    
    // Get all surahs
    func getAllSurahs() -> [Surah] {
        return surahs
    }
    
    // Get surahs that need revision
    func getSurahsNeedingRevision() -> [Surah] {
        return surahs.filter { $0.needsRevision }
    }
    
    // Get surahs by status
    func getSurahs(withStatus status: Status) -> [Surah] {
        return surahs.filter { $0.memorization == status.rawValue }
    }
    
    // Get a specific surah by number
    func getSurah(byNumber number: Int) -> Surah? {
        return surahs.first { $0.number == number }
    }
}
