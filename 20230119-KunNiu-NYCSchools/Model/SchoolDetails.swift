//
//  SchoolDetails.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import Foundation

struct SchoolDetails: Decodable, Identifiable {
    var id = UUID()
    let dbn: String
    let schoolName: String
    let overviewParagraph: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
    }
}
