//
//  ViewController.swift
//  TV Shows
//
//  Created by infinum on 12/07/2021.
//

import UIKit
import SVProgressHUD
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var checkmarkButton: UIButton!
    var checkmark: Bool = false
    @IBOutlet weak var loginUsernameField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBAction func touchRegisterButton(_ sender: Any){
        guard let user = loginUsernameField.text else { return }
        guard let pass = loginPasswordField.text else { return }

        if !user.isEmpty && !pass.isEmpty {
            SVProgressHUD.show()
            let parameters: [String: String?] = [
                "email"           : loginUsernameField?.text,
                "password"        : loginPasswordField?.text,
                "confirm_password": loginPasswordField?.text
            ]

            requestAPI(params: parameters, methodType: .post)
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func touchLoginButton(_ sender: Any) {
        guard let user = loginUsernameField.text else { return }
        guard let pass = loginPasswordField.text else { return }

        if !user.isEmpty && !pass.isEmpty {
            SVProgressHUD.show()
            let parameters: [String: String?] = [
                "email"           : loginUsernameField?.text,
                "password"        : loginPasswordField?.text,
                "confirm_password": loginPasswordField?.text
            ]
            do{
                let headersAPI = requestAPI(params: parameters, methodType: .get)
                SVProgressHUD.dismiss()
                let sb = UIStoryboard(name: "Login", bundle: nil)
                //let secondVC = sb.instantiateViewController(withIdentifier: "HomeViewController")
                let secondVC : HomeViewController = (sb.instantiateViewController(withIdentifier: "HomeViewController")) as! HomeViewController
                secondVC.authInfo = try HomeViewController.AuthInfo(headers: headersAPI)
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
            catch { print(error) }
        }
    }

    func requestAPI(params: [String: String?], methodType: HTTPMethod) -> [String: String] {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": params["email"]!!,
            "password":  params["password"]!!
        ]
        var headers = ["": ""]

        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                switch dataResponse.result {
                case .success(let userResponse):
                    print(userResponse)
                    headers = dataResponse.response?.headers.dictionary ?? [:]
                case .failure(let error):
                    print("Failed to login", error)
                    self.hideSubviews(view: self.loginButton)
                    SVProgressHUD.showError(withStatus: "Failure")
                }
            }
        return headers
    }

    override func viewDidLoad() {
        let thickness: CGFloat = 0.5
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.loginUsernameField.frame.size.height - thickness, width: self.loginUsernameField.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.white.cgColor
        loginUsernameField.layer.addSublayer(bottomBorder)
        loginPasswordField.layer.addSublayer(bottomBorder)

        loginButton.layer.cornerRadius = 15
        super.viewDidLoad()
    }

    @IBAction func pressCheckmark(_ sender: Any) {
        checkmark = !checkmark
        checkmark
            ? checkmarkButton.setImage(UIImage(named: ""), for: [])
            : checkmarkButton.setImage(UIImage(named: ""), for: [])
    }
    var counter = 0

    func hideSubviews(view: UIButton){
        UIView.animate(
            withDuration: 0.3,
            delay: TimeInterval(counter),
            options: .init(rawValue: 0),
            animations: { view.alpha = 0.0 },
            completion: nil
        )
    }
}

private extension HomeViewController {

        func loginUserWith(email: String, password: String?) -> [String: String] {
            SVProgressHUD.show()

            let parameters: [String: String] = [
                "email": email,
                "password": password!
            ]
            var headers = ["": ""]

            AF
                .request(
                    "https://tv-shows.infinum.academy/users/sign_in",
                    method: .post,
                    parameters: parameters,
                    encoder: JSONParameterEncoder.default
                )
                .validate()
                .responseDecodable(of: UserResponse.self) { dataResponse in
                    switch dataResponse.result {
                    case .success(let userResponse):
                        headers = dataResponse.response?.headers.dictionary ?? [:]
                        //userResponse.user, headers: headers)
                    case .failure(let error):
                        print("Failed to login", error)
                        SVProgressHUD.showError(withStatus: "Failure")
                        }
                }
            return headers
        }
/*
        func handleSuccesfulLogin(for user: User, headers: [String: String]) {
            guard let authInfo = try? AuthInfo(headers: headers) else {
                SVProgressHUD.showError(withStatus: "Missing headers")
                return
            }
            SVProgressHUD.showSuccess(withStatus: "Success")
        }*/
    
}
