import Foundation

public struct PrecipitationMeasurement: Codable {

    public let inLastHour: Measurement<UnitLength>
    public let inLastThreeHours: Measurement<UnitLength>?

}

extension PrecipitationMeasurement {
    
    public static var rainfallData: PrecipitationMeasurement {
        PrecipitationMeasurement(inLastHour: .init(value: 10, unit: .millimeters),
                                 inLastThreeHours: .init(value: 20, unit: .millimeters))
    }
    
    public static var snowfallData: PrecipitationMeasurement {
        PrecipitationMeasurement(inLastHour: .init(value: 4, unit: .millimeters),
                                 inLastThreeHours: .init(value: 8, unit: .millimeters))
    }
    
}
