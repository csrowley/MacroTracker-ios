//
//  SetUserGoalsView.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/21/24.
//

import SwiftUI

struct SetUserGoalsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("showHome") private var showHomeButton: Bool = false
    
    @AppStorage("setCalories") private var setCalories: Int = 2600
    @AppStorage("firstTimeLaunch") private var checkFirstLaunch: Bool?

    @State var strCals: String = ""

    @AppStorage("setProtein") private var setProtein: Int = 25
    @AppStorage("setCarbs") private var setCarbs: Int = 50
    @AppStorage("setFats") private var setFats: Int = 25
    
//    @AppStorage("progressCals") private var progressCals: Int
    
    @State private var dummmyProtein: Int = 25
    @State private var dummmyCarbs: Int = 50
    @State private var dummmyFats: Int = 25
    
    @State private var showPercentAlert = false
    @State private var percentTotal = 0
    
    let pickerRange = stride(from: 0, to: 100, by: 5)
    var body: some View {
        let percentSum = dummmyProtein + dummmyCarbs + dummmyFats
        
        NavigationStack{
            ZStack{
                VStack{
                    List{
                        HStack{
                            Text("Calories:")
                            TextField("\(setCalories)", text: $strCals)
                                .onChange(of: strCals){ newVal in
                                    setCalories = Int(newVal) ?? 0
                                }
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.blue)
                        }
                        HStack{
                            Text("Carbs:")
                            
                            Picker("", selection: $dummmyCarbs){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                }
                                
                            }
                            

                        }
                        HStack{
                            Text("Protein:")
                            Picker("", selection: $dummmyProtein){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                }
                            }
                        }
                        HStack{
                            Text("Fats:")
                            Picker("", selection: $dummmyFats){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                }
                            }

                        }
                        Button {
                            if percentSum != 100 {
                                showPercentAlert = true
                            } else {
                                setProtein = Int((Double(dummmyProtein) / 100.0) * Double(setCalories) / 4.0)
                                setCarbs = Int((Double(dummmyCarbs) / 100.0) * Double(setCalories) / 4.0)
                                setFats = Int((Double(dummmyFats) / 100.0) * Double(setCalories) / 9.0)
//                                print(setCarbs) // For debugging
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Button {
                                    showHomeButton = true
                                } label: {
                                    CircleLogButton(user_color1: Color.green, user_color2: Color.green, icon: "checkmark", noPortal: true)
                                }
                                Spacer()
                            }
                        }

                        .alert("Macro distribution must equal 100%", isPresented: $showPercentAlert){
                            Button("Ok", role: .cancel){}
                        }
                    }
                    

                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Set Your Goals")
                        .bold()
                }
            }
        }
        .font(Font.custom("Montserrat", size: 20))
    }
}

#Preview {
    SetUserGoalsView()
}
