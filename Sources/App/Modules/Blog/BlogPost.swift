//
//  File.swift
//  
//
//  Created by chowdan on 19/7/2020.
//

import Foundation
struct BlogPost: Encodable {
    let title: String
    let slug: String
    let image: String
    let excerpt: String
    let date: String
    let category: String?
    let content: String
}
