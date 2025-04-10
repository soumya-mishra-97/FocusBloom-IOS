//
//  ProfileView.swift
//  FocusBloom App
//
//  Created by Ashis Kumar Mishra on 10/04/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                /// Header
                Text("Profile")
                    .font(.system(size: 30, weight: .semibold, design: .serif))
                    .padding(.horizontal)

                HStack(spacing: 16) {
                    Image(systemName: viewModel.userImage)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(viewModel.userName)
                            .font(.system(size: 25, weight: .medium, design: .serif))
                        Text("Total Points: \(viewModel.totalPoints)")
                            .font(.system(size: 14, weight: .regular, design: .serif))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)

                /// Badges Section
                if !viewModel.totalBadges.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Badges Earned")
                            .font(.system(size: 18, weight: .medium, design: .serif))
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.totalBadges, id: \.id) { badge in
                                    Text(badge.emoji)
                                        .font(.largeTitle)
                                        .padding(8)
                                        .background(badgeBackground)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }

                Divider().background(Color.gray).padding(.horizontal)

                /// Recent Sessions Grid
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Sessions")
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .padding(.horizontal)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.sessions, id: \.startTime) { session in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("🕒 \(session.mode.rawValue.capitalized)").bold()
                                Group {
                                    Text("**Duration:** \(TimeFormatter.format(from: session.duration))")
                                    Text("**Points:** \(session.points)")
                                    Text("**Started:** \(session.startTime.formatted())")
                                }
                                .font(.system(size: 12, weight: .medium, design: .serif))
                            }
                            .padding()
                            .background(sessionCardBackground)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }

    private var badgeBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: .black.opacity(0.4), radius: 6, x: 4, y: 4)
            .shadow(color: .white.opacity(0.05), radius: 4, x: -2, y: -2)
    }

    private var sessionCardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.gray.opacity(0.2))
            .shadow(color: .black.opacity(0.4), radius: 6, x: 4, y: 4)
            .shadow(color: .white.opacity(0.05), radius: 4, x: -2, y: -2)
    }
}

#Preview {
    ProfileView()
}
