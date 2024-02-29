//
//  TabBarController.swift
//  SpotifyApp
//
//  Created by A Mairam on 10/1/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeTabBar()
        customizeTabBarFont()
        
    }

    func customizeTabBar() {
        // Создание вкладок
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        let secondViewController = SearchViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
            
        viewControllers = [firstNavigationController, secondNavigationController]
        
        tabBarController?.tabBar.backgroundColor = .black
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        



    }
    
    func customizeTabBarFont() {
        if let font = UIFont(name: ConstantsForUIComponents().fontRegular, size: 14) {
            let appearance = UITabBarAppearance()

            // Настройка цвета текста для состояний .normal и .selected
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.gray]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]

            // Настройка цвета иконок для состояний .normal и .selected
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
            
            //Настройка отступок текста от иконок
            let offset: UIOffset = UIOffset(horizontal: 0, vertical: 7)
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = offset
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = offset

            // Применение настроек к таб-бару
            tabBar.standardAppearance = appearance
        }
    }


}
