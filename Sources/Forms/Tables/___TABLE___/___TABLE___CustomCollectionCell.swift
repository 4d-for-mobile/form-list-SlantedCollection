//
//  CustomCollectionCell.swift
//  CollectionViewSlantedLayout
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewSlantedLayout

let yOffsetSpeed: CGFloat = 10
let xOffsetSpeed: CGFloat = 0

class ___TABLE___CustomCollectionCell: CollectionViewSlantedCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var background: UIView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var subtitle: UILabel?

    private var gradient = CAGradientLayer()
    var angle = CGFloat()

    // swiftlint:disable:next cyclomatic_complexity
    override func awakeFromNib() {
        super.awakeFromNib()

        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {

            case 1136:
                angle = -0.22
            case 1334, 1792, 1920, 2208:
                angle = -0.18
            case 2436:
                angle = -0.20
            case 2688:
                angle = -0.20
            default:
                angle = -0.18
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height {
            case 1366:
                angle = -0.18
            case 2224:
                angle = -0.08
            case 2388:
                angle = -0.09
            case 2732.0:
                angle = -0.07
            case 2048:
                angle = -0.10
            default:
                angle = -0.10
            }
        }

        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = background!.bounds
        background?.layer.addSublayer(gradient)

        title?.transform = CGAffineTransform(rotationAngle: angle)
        subtitle?.transform = CGAffineTransform(rotationAngle: angle)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

       gradient.frame = background!.bounds
    }

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var imageHeight: CGFloat {
        return (imageView?.image?.size.height) ?? 10
    }

    var imageWidth: CGFloat {
        return (imageView?.image?.size.width) ?? 10
    }

    func offset(_ offset: CGPoint) {
        imageView.frame = imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
