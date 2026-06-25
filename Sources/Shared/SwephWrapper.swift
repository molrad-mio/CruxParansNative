import Foundation

/// 占星術計算のコアとなるスイスエフェメリスのラッパークラス
/// スイスエフェメリスのC言語関数をSwiftから安全に呼び出すための窓口
public class SwephWrapper {
    
    public static let shared = SwephWrapper()
    
    private init() {
        // スイスエフェメリスの初期化
        // 内部のMoshier推算暦（ビルドイン）を使用するため、ディレクトリ設定は空でOK
        swe_set_ephe_path("")
    }
    
    /// 指定されたユリウス日における惑星の赤道座標（赤経・赤緯）を計算する
    /// - Parameters:
    ///   - julianDay: 計算対象のユリウス日
    ///   - planetId: 惑星のID（例: SE_SUN = 0, SE_MOON = 1）
    /// - Returns: 惑星の赤経（度）と赤緯（度）
    public func calculatePlanetPosition(julianDay: Double, planetId: Int32) -> (ra: Double, dec: Double) {
        var x = [Double](repeating: 0.0, count: 6)
        var serr = [CChar](repeating: 0, count: 256)
        
        // SEFLG_SWIEPH (2): スイスエフェメリスを使用
        // SEFLG_SPEED (256): 速度も計算
        // SEFLG_EQUATORIAL (2048): 赤道座標（赤経・赤緯）を取得
        let flags: Int32 = 2 | 256 | 2048
        
        let result = swe_calc_ut(julianDay, planetId, flags, &x, &serr)
        
        if result < 0 {
            // エラー時（通常はMoshier推算暦フォールバックが機能するため発生しにくい）
            let errorString = String(cString: serr)
            print("Sweph Error: \(errorString)")
            return (0.0, 0.0)
        }
        
        // x[0] = 赤経(RA), x[1] = 赤緯(Declination)
        return (x[0], x[1])
    }
    
    /// グレゴリオ暦の日付をユリウス日に変換する
    public func getJulianDay(year: Int32, month: Int32, day: Int32, hour: Double) -> Double {
        return swe_julday(year, month, day, hour, 1) // 1 = SE_GREG_CAL
    }
    
    /// グリニッジ恒星時(GST)を計算する
    public func getGreenwichSiderealTime(julianDay: Double) -> Double {
        return swe_sidtime(julianDay) // 戻り値は時間単位(0-24)
    }
    
    /// リソースを解放する
    public func close() {
        swe_close()
    }
}
