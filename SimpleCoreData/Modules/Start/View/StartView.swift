//
//  StartView.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import UIKit

class StartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }

    required init?(coder: NSCoder) {
        fatalError("Storyboards are not compatible with truth and beauty.")
    }
}
