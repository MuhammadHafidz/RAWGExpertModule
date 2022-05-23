//
//  ProfileView.swift
//  Profile
//
//  Created by Enygma System on 23/05/22.
//

import SwiftUI
import Common

public struct ProfileView: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            ZStack {
                Color.white
                VStack {
                    Color.white
                    Image("my-photo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .shadow(color: .white, radius: 10)
                        .padding()
                    
                    Text(ProfileConstant.name)
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text(ProfileConstant.email)
                        .font(.footnote)
                    Text("follow_me".localized(identifier: "id.haff.Common"))
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    VStack(alignment: .leading) {
                        Button {
                            UIApplication.shared.open(URL(string: ProfileConstant.urlIg)!)
                        } label: {
                            HStack {
                                Image("instagram").foregroundColor(.black)
                                Text("@"+ProfileConstant.usernameIg)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                        Button {
                            UIApplication.shared.open(URL(string: ProfileConstant.urlGithub)!)
                        } label: {
                            HStack {
                                Image("github").foregroundColor(.black)
                                Text(ProfileConstant.usernameGithub)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                        Button {
                            UIApplication.shared.open(URL(string: ProfileConstant.urlLinkd)!)
                        } label: {
                            HStack {
                                Image("linkedin").foregroundColor(.black)
                                Text(ProfileConstant.usernameLinkd)
                            }
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.vertical, 8)
                    }
                    .navigationBarTitle("profile_title".localized(identifier: "id.haff.Common"), displayMode: .inline)
                }
            }
        }
    }
}
