//
//  SetUserGoalsView.swift
//  MacroTracker
//
//  Created by Chris Rowley on 8/21/24.
//

import SwiftUI

struct SetUserGoalsView: View {
    @AppStorage("setCalories") private var setCalories: Int = 2600
    @State var strCals: String = ""

    @AppStorage("setProtein") private var setProtein: Int = 25
    @AppStorage("setCarbs") private var setCarbs: Int = 50
    @AppStorage("setFats") private var setFats: Int = 25
    
    @State private var proteinPlaceholder: Int = 25
    @State private var carbPlaceholder: Int = 50
    @State private var fatsPlaceholder: Int = 25
    
    @State private var showPercentAlert = false
    @State private var percentTotal = 0
    
    let pickerRange = stride(from: 0, to: 100, by: 5)
    var body: some View {
        let percentSum = setProtein + setCarbs + setFats
        
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
                            
                            Picker("", selection: $setCarbs){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                    
                                }
                                
                            }

                        }
                        HStack{
                            Text("Protein:")
                            Picker("", selection: $setProtein){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                }
                            }
                        }
                        HStack{
                            Text("Fats:")
                            Picker("", selection: $setFats){
                                ForEach(0..<21, id: \.self){ percent in
                                    Text("\(percent * 5)%").tag(percent * 5)
                                    
                                }
                            }

                        }
                        Button{
                            if percentSum != 100{
                                showPercentAlert = true
                            }
  
                        } label: {
                            HStack{
                                Spacer()
                                CircleLogButton(user_color1: Color.green, user_color2: Color.green, icon: "checkmark", noPortal: true)
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
                }
            }
        }
        .font(Font.custom("Montserrat", size: 20))
    }
}

#Preview {
    SetUserGoalsView()
}
