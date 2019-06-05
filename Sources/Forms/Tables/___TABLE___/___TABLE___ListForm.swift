//
//  ___TABLE___ListForm.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___

import UIKit
import QMobileUI
import CollectionViewSlantedLayout

/// Generated list form for ___TABLE___ table.
@IBDesignable

class ___TABLE___ListForm: ListFormCollection {

    // Do not edit name or override tableName
    public override var tableName: String {
        return "___TABLE___"
    }

    let layout = CollectionViewSlantedLayout()
    let actionButton = UIButton()

    // MARK: Events
    override func onLoad() {
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true

        // Action Button definition
        actionButton.frame = CGRect(x: screenWidth - 70, y: 45, width: 50, height: 50)
        let image = UIImage(named: "moreButton")
        actionButton.setImage(image, for: UIControl.State.normal)
        actionButton.actionSheet = self.actionSheet
        actionButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.addSubview(actionButton)

        // SearchBar text style
        let blueColor = UIColor(red: 90/255, green: 179/255, blue: 174/255, alpha: 1.0)

        // Floating SearchBar definition
        searchBar = UISearchBar(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 100, height: 40))
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        searchBar.transform = CGAffineTransform(scaleX: 0, y: 0)
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.2
        let barButtonAppearanceInSearchBar: UIBarButtonItem?
        barButtonAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearanceInSearchBar?.tintColor = blueColor

        // SearchBar text style
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = blueColor
        textFieldInsideUISearchBar?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)

        // SearchBar placeholder style
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.textColor = blueColor
        textFieldInsideUISearchBarLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        self.refreshControl?.tintColor = blueColor
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search by address"
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        self.view.addSubview(searchBar)
    }

    override func onWillAppear(_ animated: Bool) {
        // Called when the view is about to made visible. Default does nothing
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height

    }

    override func onDidAppear(_ animated: Bool) {
        // Called when the view has been fully transitioned onto the screen. Default does nothing
        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            self.searchBar.transform = .identity
        }, completion: nil)
        // Action Button animation
        UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            self.actionButton.transform = .identity
        }, completion: nil)
    }

    override func onWillDisappear(_ animated: Bool) {
        // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
    }

    override func onDidDisappear(_ animated: Bool) {
        // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
    }

    open override func onSearchFetching() {
        collectionView?.collectionViewLayout = layout
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
    }

    open override func onSearchCancel() {
        collectionView?.collectionViewLayout = layout
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
    }
}

// MARK: Layout
extension ___TABLE___ListForm: CollectionViewDelegateSlantedLayout {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [___TABLE___CustomCollectionCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}

// Screen width.
private var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
