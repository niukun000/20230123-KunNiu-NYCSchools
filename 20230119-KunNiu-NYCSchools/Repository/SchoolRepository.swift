//
//  SchoolRepository.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import Foundation
import Combine

protocol SchoolRepository {
    func getSchools(for url: URL) async throws -> [SchoolDetails]
    func getAdditionalSchoolDetails(for url: URL) async throws -> SchoolAdditionlDetails?
}
struct SchoolRepositoryImpl {
    private let networkManager: NetworkActions
//    private var cancellables = Set<AnyCancellable>()
    init(networkManager: NetworkActions) {
        self.networkManager = networkManager
    }
}
extension SchoolRepositoryImpl: SchoolRepository {
    
    func getSchools(for url: URL) async throws -> [SchoolDetails] {
        let schoolData =  try await networkManager.get(url: url)
        let schools = try JSONDecoder().decode([SchoolDetails].self, from: schoolData )
        return schools
    }
    
    func getAdditionalSchoolDetails(for url: URL) async throws -> SchoolAdditionlDetails? {
        
        do{
            let schoolAdditionlData =  try await networkManager.get(url: url)
            let schoolAdditionalDetails = try JSONDecoder().decode([SchoolAdditionlDetails].self, from: schoolAdditionlData )
            if schoolAdditionalDetails.count > 0 {
                return schoolAdditionalDetails[0]
            }
            return nil

        }catch let error{
            print(error.localizedDescription)
            throw error
        }

    }
}

