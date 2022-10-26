//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/25.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    static let empty = Post(id: 0, userId: 0, title: "", body: "")
}

class Fornum {
    func update(userIds: Array<Int>) {
        let urlSession = URLSession.shared

        for userId in userIds {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(userId)")
            let dataTask = urlSession.dataTask(with: url!) {data,response,error in
                guard let data = data,
                      let post = try? JSONDecoder().decode(Post.self, from: data)
                else {
                    return
                }

                print("Decode post ID: \(post.id) @Thread: (\(Thread.current)")
            }

            dataTask.resume()
        }
    }
    
    func updateAsync(userIds: Array<Int>) async {
        if #available(iOS 13.0, *) {
            await withThrowingTaskGroup(of: Post.self) {group in
                for userId in userIds {
                    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(userId)")!
                    group.async {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        guard let post = try? JSONDecoder().decode(Post.self, from: data)
                        else {
                            return Post.empty
                        }
                        
                        print("Decode post ID: \(post.id) @Thread: (\(Thread.current)")
                        
                        return post
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func fetchUserIds() async -> [Int] {
        return Array(1 ... 100)
    }
}
