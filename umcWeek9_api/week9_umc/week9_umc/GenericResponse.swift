//
//  GenericResponse.swift
//  week9_umc
//
//  Created by 김아림 on 2022/12/02.
//

import Foundation
struct GenericResponse<T: Codable>: Codable {
    // Codable: 데이터를 JSON 데이터 포맷으로 자유롭게 Decoding, Encoding 할 수 있도록 해주는 protocol
    var message: String
    var data: T? //요 타입도 임의로 만들어줘야 함
    
    enum CodingKeys: String, CodingKey {
        //json은 key, data값을 가지고있는데
        //json의 key값을 swift 타입으로 디코딩할때 이름이 똑같아야해서
        //CodingKeys를 통해 data변수의 key랑 struct를 이어주는 역할
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        //데이터로 들어오는 값이 없을수도 있고 있을수도 있어서 먼저 처리해주는 것
        //데이터가 없을 때 nil로 처리
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
