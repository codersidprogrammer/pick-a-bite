//
//  Untitled.swift
//  WeSplit
//
//  Created by Aristo Yongka on 06/04/25.
//

import SwiftUI

struct ModalView: View {
    var dataModel: UserHistoryModel
    var onDismiss: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(dataModel.createdAt.formattedLongDate())
                        .font(.title3)
                        .bold()

                    Spacer()

                    Button("Done", role: .cancel) {
                        onDismiss()
                    }
                    .font(.title3)
                }

//                Text("Spin #\(dataModel.spinSequence)")
//                    .font(.headline)
//                    .padding(.top)

                TenantCard(
                    title: dataModel.tenantName,
                    subtitle: "Selected based on your preferences",
                    imageName: "default_restaurant",
                    location: "See on Map",
                    distance: "",
                    buttonAction: {
                        if let url = URL(string: "http://maps.apple.com/?q=\(dataModel.tenantName)") {
                            UIApplication.shared.open(url)
                        }
                    },
                    buttonIconName: "safari.fill"
                )
                
                Text("You might also enjoy")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                HStack{
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Chong Qing")
                            Text("The Breeze")
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "safari.fill")
                            .foregroundColor(Color.kombuGreen)
                        Spacer()
                    }
                    .frame(width: 160, height: 70)
                    .background(Color.papayaWhip)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("D'Cost")
                            Text("The Breeze")
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "safari.fill")
                            .foregroundColor(Color.kombuGreen)
                        Spacer()
                    }
                    .frame(width: 160, height: 70)
                    .background(Color.papayaWhip)
                    .cornerRadius(10)
                }
                
                .padding(.horizontal, 0)
              
            }
            .padding()

        }
    }
}

struct TenantCard: View {
    var title: String
    var subtitle: String
    var imageName: String
    var location: String
    var distance: String
    var buttonAction: () -> Void
    var buttonIconName: String
   
   
   
   var body: some View {
       HStack(alignment: .center, spacing: Sizing.lg3) {
           Image(imageName)
               .resizable()
               .scaledToFit()
               .frame(width: Sizing.xl3 , height: Sizing.xl3)
               .clipShape(RoundedRectangle(cornerRadius: Sizing.sm))
           
           VStack(alignment: .leading) {
               Text(title)
                   .font(.title3)
               Text(subtitle)
                   .font(.caption)
                   .padding(.bottom, Sizing.md)
               
               Text(location)
                   .font(.caption)
                   .foregroundStyle(.gray)
           }
           Button(action: {
               buttonAction()
           }) {
               Image(systemName: buttonIconName)
                   .font(.title)
                   .foregroundColor(Color.kombuGreen)
           }
       }
   }
}

//#Preview {
//    ModalView(isPresented : .constant(true), dataModel: .constant(UserHistoryModel.dummy))
//}

//import SwiftUI
//
//struct ModalView: View {
//    @Binding var selectedSegment: SegmentData
//    @Binding var rouletteController: RouletteController
//    
//    var body: some View {
//        VStack(alignment: .center){
//            CardMediaComponentView(
//                title: selectedSegment.description,
//                subtitle: "",
//                imageName: "default_restaurant",
//                location: "Hope this is best for you",
//                distance: "",
//                buttonAction: {
//                    if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
//                        UIApplication.shared.open(url)
//                    }
//                },
//                buttonIconName: "safari.fill"
//            )
//            .padding(.vertical, Sizing.lg3)
//            .padding(.horizontal, Sizing.sm)
//            
//            Spacer()
//            VStack(alignment: .leading) {
//                Text("Maybe you'll like")
//                    .font(.headline)
//                    .padding(.leading, Sizing.md)
//                HStack(spacing: Sizing.xs) {
//                    let segmentData = Array(rouletteController.segmentData.enumerated())
//                    if segmentData.count > 1 {
//                        let takeTwo = segmentData.shuffled().prefix(2)
//                        ForEach(takeTwo, id: \.offset) { index, segment in
//                            SimpleCardComponentView(
//                                title: segment.description,
//                                subtitle: "Nice to try"
//                            )
//                            .padding(.trailing, Sizing.sm)
//                            .onTapGesture {
//                                if let url = URL(string: "http://maps.apple.com/?q=\(selectedSegment.description)") {
//                                    UIApplication.shared.open(url)
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, Sizing.md)
//                .padding(.bottom, Sizing.lg3)
//                //                ScrollView(.horizontal, showsIndicators: false) {
//                //
//                //                }
//                //                .padding(.bottom, Sizing.lg3)
//            }
//            
//            
//            VStack(alignment: .leading){
//                Text("Want try more?")
//                    .font(.headline)
//                
//                PrimaryButtonComponentView(
//                    "Spin more (\(rouletteController.countChances)x)",
//                    action: {
//                        rouletteController.isSelected.toggle()
//                        rouletteController.spin()
//                    },
//                    isDisabled: !rouletteController.havingChance
//                )
//            }
//            .padding(.horizontal, Sizing.md)
//            
//            
//        }
//        .background(Color.cosmicLatte)
//    }
//}
//
//#Preview {
//    @Previewable @State var segmentData: [SegmentData] = [
//        SegmentData(index: 0.2, color: Color.primary, description: "Starbucks"),
//        SegmentData(index: 0.1, color: Color.primary, description: "Kopi Kenangan"),
//        SegmentData(index: 0.05, color: Color.primary, description: "Janji Jiwa"),
//        SegmentData(index: 0.3, color: Color.primary, description: "Tomoro Coffee"),
//    ]
//    
//    ModalView(
//        selectedSegment: .constant(segmentData[0]),
//        rouletteController: .constant(RouletteController(segmentData: segmentData))
//    )
//}
//
