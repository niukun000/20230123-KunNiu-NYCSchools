//
//  ContentView.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import SwiftUI

struct SchoolListView: View {
    
    @StateObject var schoolViewModel:  SchoolViewModel
    @State var a: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(schoolViewModel.schools) {
                    school in
                    
                        NavigationLink {
                            SchoolAdditionalInfo(dbn: school.dbn, schoolViewModel: schoolViewModel, schoolName: school.schoolName, schoolOverview: school.overviewParagraph )

                        } label: {
                            Text(school.schoolName)
                        }
                }
            }
        }
        .onAppear{
            schoolViewModel.fetchSchools(urlStr: Endpoint.nycListUrl )
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView(schoolViewModel: SchoolViewModel(repository: SchoolRepositoryImpl(networkManager: NetworkManager())))
    }
}
