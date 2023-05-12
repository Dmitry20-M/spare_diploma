//
//  SceneDelegate.swift
//  Navigation
//
//  Created by iAlesha уличный on 12.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
       
       let tabBar = TabBar()
       
       func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           
           guard let windowScene = (scene as? UIWindowScene) else { return }
           
           let window = UIWindow(windowScene: windowScene)
           window.rootViewController = TabBar()
           window.makeKeyAndVisible()
           self.window = window
           
           
       }



}

