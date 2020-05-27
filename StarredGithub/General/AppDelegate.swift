//
//  AppDelegate.swift
//  StarredGithub
//
//  Created by Gabriel Azevedo on 25/05/20.
//  Copyright © 2020 Gabriel Azevedo. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = RepositoriesViewControllerBuilder.build(
            with: .init(
                viewModel: RepositoriesViewModel(
                    service: RepositoriesService(
                        provider: MoyaProvider<RepositoryTargetType>(plugins: [NetworkLoggerPlugin()])
                    )
                )
            )
        )
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

