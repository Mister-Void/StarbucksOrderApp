//
//  SceneDelegate.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//        print("SceneDelegate - sceneDidBecomeActive 켜지기 전 2 (App Switcher 모드 였다가 돌아올 때)")
        callBackgroundImage(false)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
//        print("SceneDelegate - sceneWillResignActive - 쓸어 올렸을 때, App Switcher 모드")
        callBackgroundImage(true)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
//        print("SceneDelegate - sceneWillEnterForeground - 켜지기 전 1 (완전 백그라운드로 갔다 다시 돌아올 때) 백그라운드로 갔다가 바로 오면 여기 안탐. 백그라운드 1초 있다가 켜야 여기 탐")
        callBackgroundImage(false)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
//        print("SceneDelegate - sceneDidEnterBackground - 백그라운드로 갔을 때, 홈 눌렀을 때")
        callBackgroundImage(true)
    }

    func callBackgroundImage(_ switcher: Bool) {
        
        let TAG_BG_IMG = -101

        let backgroundView = window?.rootViewController?.view.window?.viewWithTag(TAG_BG_IMG)

        // switcher 모드라면
        if switcher {

            if backgroundView == nil {

                //여기서 보여주고 싶은 뷰 자유롭게 생성
                let bgView = UIView()
                bgView.frame = UIScreen.main.bounds
                bgView.tag = TAG_BG_IMG
                bgView.backgroundColor = .black

                let imageName = "scene.jpg"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                
                imageView.frame = UIScreen.main.bounds
                bgView.addSubview(imageView)
                
                window?.rootViewController?.view.window?.addSubview(bgView)
            }
        } else {

            if let backgroundView = backgroundView {
                backgroundView.removeFromSuperview()
            }
        }
    }

}

