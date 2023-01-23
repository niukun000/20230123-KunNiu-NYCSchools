//
//  _0230119_KunNiu_NYCSchoolsApp.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import SwiftUI

@main
struct _0230119_KunNiu_NYCSchoolsApp: App {
    
    var body: some Scene {
        WindowGroup {
            SchoolListView(schoolViewModel: SchoolViewModel(repository: SchoolRepositoryImpl(networkManager: NetworkManager())))
        }
    }
}
