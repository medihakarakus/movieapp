//
//  Date.swift
//  MovieApp
//
//  Created by Mediha Karakuş on 11.08.23.
//

import UIKit

extension String {
    func toYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let convertedDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.string(from: convertedDate)
        return date
    }
}

extension Float {
    func toMovieScore() -> String {
        String(format: "%0.1f", self)
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textColor = .white
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
