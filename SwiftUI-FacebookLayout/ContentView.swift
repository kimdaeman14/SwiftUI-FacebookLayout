//
//  ContentView.swift
//  FacebookGroupsSwiftUI
//
//  Created by Brian Voong on 6/4/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import SwiftUI
//
struct Post:Hashable {
    let id: Int
    let username, text, profileImageName, imageName: String
    
    static let samplePosts: [Post] = [
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger"),
        .init(id: 1, username: "Bill Clinton", text: "I swear I didn't touch that girl, she came on to me!", profileImageName: "burger", imageName: "post_puppy"),
        .init(id: 2, username: "Barack Obama", text: "I used to be the president that people claimed wasn't born in the United States, but that isn't true", profileImageName: "burger", imageName: "burger")
    ]
}

struct Group:Hashable {
    let id: Int
    let name, imageName: String
    
    static let sampleGroups: [Group] = [
        .init(id: 1, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 2, name: "Other People's Puppies", imageName: "puppy"),
        .init(id: 3, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
        .init(id: 4, name: "Co-Ed Hikes of Colorado", imageName: "hike"),
        .init(id: 5, name: "Other People's Puppies", imageName: "puppy"),
        .init(id: 6, name: "Secrets to Seasonal Gardening", imageName: "gardening"),
        .init(id: 7, name: "Co-Ed Hikes of Colorado", imageName: "burger"),
        .init(id: 8, name: "Other People's Puppies", imageName: "burger")
    ]
}

struct ContentView : View {
    
    let posts = Post.samplePosts
    
    var body: some View {
        NavigationView {
            List {
                VStack (alignment: .leading) {
                    Text(verbatim: "Trending").font(.headline).padding(.leading, 16).padding(.bottom, 4)
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(Group.sampleGroups, id:\.id) { group in
                                
                                NavigationLink(destination: GroupDetailView(group: group)) {
                                    GroupView(group: group).padding(.trailing, 8)
                                }
                                
                            }
                        }.padding(.leading, 16).padding(.trailing, 8)
                    }.frame(height: 180)
                    
                }.padding(.top, 8).padding(.leading, -20).padding(.trailing, -20)
                
                ForEach(posts, id: \.id) { post in
                    PostView(post: post).padding(.bottom)
                }
                
            }.navigationBarTitle(Text("Groups"), displayMode: .automatic)
        }
        
    }
}

struct GroupDetailView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName)
            Text(group.name)
        }.navigationBarTitle(Text(group.name))
    }
}

struct GroupView: View {
    let group: Group
    var body: some View {
        VStack {
            Image(group.imageName).renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(5).clipped()
            Text(verbatim: group.name).foregroundColor(.primary).lineLimit(2).frame(width: 100, height: 50, alignment: .leading).font(.headline)
        }
    }
}

struct PostView: View {
    let post: Post
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Image("burger").resizable().frame(width: 50, height: 50).clipShape(Circle()).clipped()
                VStack (alignment: .leading) {
                    Text(post.username).font(.headline)
                    Text("Posted 8 hrs ago").font(.body)
                }.padding(.leading, 8)
            }.padding(.leading, 16)
            Text(post.text).padding(.leading, 16).padding(.trailing, 36).lineLimit(nil)
            
            Image(post.imageName, bundle: nil)
                .scaledToFill()
                .frame(height: 300)
                .clipped()
        }.padding(.leading, -20).padding(.trailing, -20).padding(.top, 12).padding(.bottom, -26)
    }
}

struct User: Identifiable {
    let id: Int
    let name, message, imageName: String
}

struct DynamicsListView: View {
    
    let users: [User] = [
        .init(id: 0, name: "Tim Cook", message: "My stands cost $999", imageName: "tim_cook"),
        .init(id: 1, name: "Craig Federighi", message: "I have the sexiest hair in the land of Apple spokesmen", imageName: "craig_f"),
        .init(id: 2, name: "Jony Ive", message: "Somebody save me, I have no idea where I am anymore. Do I even work at Apple anymore? I bet you sure miss my sexy ass accent during the keynotes, amiright?", imageName: "jon_ivey")
    ]
    
    var body: some View {
        NavigationView {
            List (users) {
                UserView(user: $0)
            }.navigationBarTitle(Text("Dynamic List"))
        }
    }
}

struct UserView: View {
    let user: User
    var body: some View {
        HStack {
            Image(user.imageName)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .frame(width: 70, height: 70)
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name).font(.headline)
                Text(user.message).font(.subheadline).lineLimit(nil)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#endif
