//
//  ExtensionUIButton.swift
//  Navigation Table
//
//  Created by Александр Лебедев on 06.07.2022.
//

import UIKit

class UIButtonAlpha: UIButton {
    override open var isHighlighted: Bool {
        get { super.isHighlighted }
        set { alpha = newValue ? 0.8 : 1.0 }
    }
    override open var isSelected: Bool {
        get { super.isSelected }
        set { alpha = newValue ? 0.8 : 1.0 }
    }
    override open var isEnabled: Bool {
        get { super.isEnabled }
        set { alpha = newValue ? 1.0 : 0.8 }
    }

}
