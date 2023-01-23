//
//  SchoolViewModel.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import Foundation
import Combine

protocol SchoolViewModelAction: ObservableObject {
    func fetchSchools(urlStr: String)
}


final class SchoolViewModel {
    @Published private(set) var schools: [SchoolDetails] = []
    @Published var schoolSat : SchoolAdditionlDetails = SchoolAdditionlDetails(dbn: "", schoolName: "", numOfSatTestTakers: "", satCriticalReadingAvgScore: "", satMathAvgScore: "", satWritingAvgScore: "")
    @Published var failToDownloadSat = false
    private let repository: SchoolRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: SchoolRepository) {
        self.repository = repository
    }
}


extension SchoolViewModel: SchoolViewModelAction {
        func fetchSat(urlString: String, dbn: String) {
            let url = "\(urlString)?dbn=\(dbn)"
            print(url)
            guard let url = URL(string: url) else {
                return
            }
            
            failToDownloadSat = false

            Task{
                do {
                    guard let schoolAdditionalInfo = try await repository.getAdditionalSchoolDetails(for: url) else{
                        DispatchQueue.main.async {
                            self.failToDownloadSat = true
                            self.schoolSat = SchoolAdditionlDetails(dbn: "N/A", schoolName: "N/A", numOfSatTestTakers: "N/A", satCriticalReadingAvgScore: "N/A", satMathAvgScore: "N/A", satWritingAvgScore: "N/A")
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.schoolSat = schoolAdditionalInfo
                    }
                    
                }catch let error{
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.failToDownloadSat = true
                    }

                }
            }
        }
    
    func fetchSchools(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        
        Task {
            do {
                let schoolsArray = try await repository.getSchools(for: url)
                DispatchQueue.main.async {
                    self.schools = schoolsArray
                }
            }catch {
                self.schools = []
            }
        }
    }
}

