//
//  HomeView.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var focusVM = FocusViewModel()
    
    let focusItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    /// Header
                    Text("FocusBloom")
                        .font(.system(size: 30, weight: .semibold, design: .serif))
                        .padding(.leading)
                    Text("Select Focus Mode")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .padding(.leading)
                    
                    /// Mode View
                    LazyVGrid(columns: focusItems, spacing: 16) {
                        ForEach(FocusMode.allCases, id: \.self) { mode in
                            NavigationLink(destination: FocusView(viewModel: focusVM, selectedMode: mode)) {
                                Text(mode.rawValue.capitalized)
                                    .font(.system(size: 16, weight: .semibold, design: .serif))
                                    .frame(maxWidth: .infinity, minHeight: 100)
                                    .background(modeBackground)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.square")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    private var modeBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.red.opacity(0.5))
            .shadow(color: Color.blue.opacity(0.1), radius: 6, x: -6, y: -6)
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: 2, y: 2)
    }
}


#Preview {
    HomeView().environmentObject(FocusViewModel())
}
