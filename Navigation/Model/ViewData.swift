//
//  ViewData.swift
//  Navigation
//
//  Created by Александр Лебедев on 16.06.2022.
//

import Foundation
import UIKit

struct Post{
    var title: String = ""
    var author: String = ""
    var description: String = ""
    var image: String = ""
    var likes: Int = 0
    var views: Int = 0
}

let posts = [
    Post(title: "Время жрачки",
         author: "Кот",
         description: "Жду когда хозяин отвернется, что-бы успеть сожрать у собаки",
         image: "post.1",
         likes: 100000,
         views: 567688),
    Post(title: "Живу по кайфу",
         author: "Кот",
         description: "Занял стул хозяина, даю напоминать, что важнее его работы, только я",
         image: "post.2",
         likes: 57657,
         views: 67887),
    Post(title: "Валяюсь",
         author: "Кот",
         description: "Красивый, да?)",
         image: "post.3",
         likes: -5,
         views: 66),
    Post(title: "Очень интересно",
         author: "Кот",
         description: "...",
         image: "post.4",
         likes: 999,
         views: 9977),
]
