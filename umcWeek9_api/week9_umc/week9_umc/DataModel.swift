// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dataModel = try? newJSONDecoder().decode(DataModel.self, from: jsonData)

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let currentCount: Int
    let data: [Datum]
    let matchCount, page, perPage, totalCount: Int
}

// MARK: - Datum
struct Datum: Codable {
    let 군인입장료: Int
    let 데이터기준일자, 도립공원명: String
    let 어른입장료, 어린이입장료: Int
    let 입장료, 재지정일, 지정면적제곱킬로미터: String
    let 청소년입장료: Int
    let 최초지정일: String

    enum CodingKeys: String, CodingKey {
        case 군인입장료 = "군인 입장료"
        case 데이터기준일자, 도립공원명
        case 어른입장료 = "어른 입장료"
        case 어린이입장료 = "어린이 입장료"
        case 입장료, 재지정일
        case 지정면적제곱킬로미터 = "지정면적(제곱킬로미터)"
        case 청소년입장료 = "청소년 입장료"
        case 최초지정일
    }
}
