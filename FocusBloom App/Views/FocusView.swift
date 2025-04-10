//
//  FocusView.swift
//  FocusBloom App
//
//  Created by Soumya Mishra on 10/04/25.
//

import SwiftUI

struct FocusView: View {
    @ObservedObject var viewModel: FocusViewModel
    let selectedMode: FocusMode

    var body: some View {
        VStack(spacing: 20) {
            /// Header
            HStack {
                Text("Focus Session")
                    .font(.system(size: 30, weight: .semibold, design: .serif))
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)

            /// Focus Mode Section
            /// Displays selected mode, timer, points, earned badges, and stop button
            VStack(spacing: 16) {
                Text("Mode: \(selectedMode.rawValue.capitalized)")
                    .font(.system(size: 20, weight: .semibold, design: .serif))

                Text(viewModel.timeFormatted())
                    .font(.system(size: 50, weight: .bold, design: .serif))

                Text("Points: \(viewModel.points)")
                    .font(.system(size: 18, weight: .medium, design: .serif))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.badges, id: \.emoji) {
                            Text($0.emoji)
                                .font(.largeTitle)
                                .padding(4)
                                .background(badgeBackground)
                        }
                    }
                }

                Button("Stop Focusing") {
                    viewModel.stopFocusMode()
                }
                .font(.system(size: 16, weight: .medium, design: .serif))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.bottom)
        .onAppear {
            if viewModel.mode == nil {
                viewModel.startFocusMode(mode: selectedMode)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var badgeBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: .black.opacity(0.4), radius: 6, x: 4, y: 4)
            .shadow(color: .white.opacity(0.05), radius: 4, x: -2, y: -2)
    }
}


#Preview {
    FocusView(viewModel: FocusViewModel(), selectedMode: .work)
}
