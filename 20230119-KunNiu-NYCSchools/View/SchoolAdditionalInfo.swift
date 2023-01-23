//
//  SchoolAdditionalInfo.swift
//  20230119-KunNiu-NYCSchools
//
//  Created by Kun Niu on 2023-01-22.
//

import SwiftUI

struct SchoolAdditionalInfo: View {

    var dbn:  String
    @StateObject var schoolViewModel:  SchoolViewModel
    @State var fail = false
    @State var schoolName: String
    @State var schoolOverview: String
    var body: some View {
        VStack(alignment: .leading){
            if schoolViewModel.failToDownloadSat{
                ProgressView()
            }else{
                ScrollView{
                    Text(schoolName.uppercased())
                        
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
//                        .background(Color(.red))
                    Divider()
                    Text("Sat Test Takes: " + schoolViewModel.schoolSat
                        .numOfSatTestTakers.uppercased() )
                    .cornerRadius(10)
                    .padding()
                    Divider()
                    VStack {
                        Text("Average Scores").padding()
                        Divider()
                        HStack {
                            VStack{
                                Text("Reading")
                                Divider()
                                Text(schoolViewModel.schoolSat.satCriticalReadingAvgScore )
                            }
                            Divider()
                            VStack{
                                Text("Math")
                                Divider()
                                Text( schoolViewModel.schoolSat.satMathAvgScore)
                                
                            }
                            Divider()
                            VStack{
                                Text("Writting")
                                Divider()
                                Text( schoolViewModel.schoolSat.satWritingAvgScore)
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(.green))
                    .cornerRadius(30)
                    
                    
                    VStack {
                        Text("School OVerview")
                            .padding()
                        Divider()
                        Text(schoolOverview)
                            .padding(.horizontal, 26.0)
                            .padding(.bottom, 100)

                    }
                    .background(Color(.systemGray4))
                    .cornerRadius(30)

                }
                .multilineTextAlignment(.center)
                //                    .font(.system(size: Device.isIpad ? 32.0 : 20.0).bold())
                
            }
        }
        .foregroundColor(.black)
        .background(Color(.systemGray5))
        .onAppear{
            schoolViewModel.fetchSat(urlString: Endpoint.nycAdditionalInformationUrl, dbn: dbn)
            if schoolViewModel.failToDownloadSat{
                fail = true
            }
        }
        .alert(isPresented: $schoolViewModel.failToDownloadSat) {
            Alert(title: Text("School SAT Not Available"), message: Text("Could not find \(schoolName) SAT information"), dismissButton: .default(Text("Check School Overview")))
        }
    }
}

struct SchoolAdditionalInfo_Previews: PreviewProvider {
    static var previews: some View {
        SchoolAdditionalInfo(dbn: "17K548", schoolViewModel: SchoolViewModel(repository: SchoolRepositoryImpl(networkManager: NetworkManager())), schoolName: "my school", schoolOverview: "N/A")
    }
}
