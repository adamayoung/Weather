import Foundation
import OpenWeather

extension Condition {
    
    init(dto: ConditionDTO) {
        self.init(id: dto.id, main: dto.main, description: dto.description, iconURL: dto.iconURL)
    }
}
