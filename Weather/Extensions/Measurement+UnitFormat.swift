import Foundation

extension Measurement where UnitType == UnitTemperature {
    
    var formatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.locale = .current
        measurementFormatter.numberFormatter = numberFormatter
        return measurementFormatter.string(from: self)
    }
    
}
