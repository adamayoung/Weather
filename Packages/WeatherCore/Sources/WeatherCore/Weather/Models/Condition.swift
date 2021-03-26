import Foundation

public struct Condition: Identifiable, Codable {

    public let id: Int
    public let main: String
    public let description: String
    public let iconURL: URL

}

extension Condition {
    
    public static var cloudsData: Condition {
        Condition(id: 803, main: "Clouds", description: "broken clouds",
                  iconURL: URL(string: "http://openweathermap.org/img/wn/04d@2x.png")!)
    }
    
}
