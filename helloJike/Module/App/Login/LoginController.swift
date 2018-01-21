//
//  LoginController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/13.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginController: STViewController {
    
    let container = UIStackView()
    
    let titleLabel = UILabel()
    let metaLabel = UILabel()
    
    let usernameTextFiled = UITextField()
    let passwordTextFiled = UITextField()
    
    let smsCodeButton = UIButton(type: .custom)
    let loginButton = UIButton(type: .custom)
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.axis = .vertical
        container.distribution = .fill
        
        titleLabel.font = UIFont.systemFont(ofSize: 36)
        titleLabel.textColor = UIColor.mainBlue
        titleLabel.text = "Hello Jiker"
        
        metaLabel.font = UIFont.systemFont(ofSize: 14)
        metaLabel.textColor = UIColor.black66
        metaLabel.text = "登录后可以发表动态"
        
        usernameTextFiled.textColor = UIColor.black33
        usernameTextFiled.keyboardType = .phonePad
        usernameTextFiled.textContentType = .telephoneNumber
        usernameTextFiled.returnKeyType = .next
        usernameTextFiled.placeholder = "手机号码"
        usernameTextFiled.delegate = self
        
        passwordTextFiled.textColor = UIColor.black33
        passwordTextFiled.keyboardType = .numberPad
        passwordTextFiled.returnKeyType = .done
        passwordTextFiled.placeholder = "验证码"
        passwordTextFiled.rightView = smsCodeButton
        passwordTextFiled.rightViewMode = .always
        passwordTextFiled.delegate = self
        
        
        smsCodeButton.setTitle("获取验证码", for: .normal)
        smsCodeButton.setTitleColor(.white, for: .normal)
        smsCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        smsCodeButton.setBackgroundImage(UIImage.from(color: .mainBlue), for: .normal)
        smsCodeButton.layer.cornerRadius = 4
        smsCodeButton.clipsToBounds = true
        smsCodeButton.addTarget(self, action: #selector(smsCodeButtonClick(_:)), for: .touchUpInside)
        
        
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginButton.setBackgroundImage(UIImage.from(color: .mainBlue), for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClick(_:)), for: .touchUpInside)
        
        view.addSubview(container)
        container.addArrangedSubview(titleLabel)
        
        container.addArrangedSubview(metaLabel)
        container.addArrangedSubview(usernameTextFiled)
        container.addArrangedSubview(passwordTextFiled)
        container.addArrangedSubview(loginButton)
        
        container.setCustomSpacing(5, after: titleLabel)
        container.setCustomSpacing(70, after: metaLabel)
        container.setCustomSpacing(60, after: usernameTextFiled)
        container.setCustomSpacing(60, after: passwordTextFiled)

        container.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalTo(view).offset(40)
            make.trailing.equalTo(view).offset(-40)
        }
        
        smsCodeButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(26)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        registerForKeyboardNotifications()
    }
    
    
}

extension LoginController : UITextFieldDelegate {
    
}

// MARK: - Action
extension LoginController {
    
    @objc func smsCodeButtonClick(_ btn:UIButton) {
        if let phoneNumber = usernameTextFiled.text {
            smsCode(phoneNumber)
        }
        
        
        passwordTextFiled.becomeFirstResponder()
    }
    
    @objc func loginButtonClick(_ btn:UIButton) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        if let phoneNumber = usernameTextFiled.text,
            let smsCode = passwordTextFiled.text{
            login(phoneNumber, smsCode: smsCode)
        }
        
    }
}


extension LoginController {
    
    func smsCode(_ phoneNumber:String) {
        if phoneNumber.count == 11 {
            AccountService.shared.smsCode(action: "LOGIN", mobilePhoneNumber: phoneNumber, { (success, reason) in
                
            })
        } else {
            
        }
    }
    
    func login(_ phoneNumber:String, smsCode:String) {
        
        AccountService.shared.mixLoginWithPhone(smsCode: smsCode, mobilePhoneNumber: phoneNumber) { (user, reason) in
            if user != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: - KeyboardNotifications
extension LoginController {
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        let info = notification.userInfo
        let interval = info![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = info![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        container.snp.updateConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        
        
        UIView.animate(withDuration: interval, delay: 0, options: UIViewAnimationOptions(rawValue:curve), animations: {
            self.container.setCustomSpacing(60, after: self.metaLabel)
            self.container.setCustomSpacing(50, after: self.usernameTextFiled)
            self.container.setCustomSpacing(50, after: self.passwordTextFiled)
            self.view.layoutIfNeeded()
        }, completion: nil);
        
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        let info = notification.userInfo
        let interval = info![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = info![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        container.snp.updateConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
        }
        
        
        UIView.animate(withDuration: interval, delay: 0, options: UIViewAnimationOptions(rawValue:curve), animations: {
            self.container.setCustomSpacing(70, after: self.metaLabel)
            self.container.setCustomSpacing(60, after: self.usernameTextFiled)
            self.container.setCustomSpacing(60, after: self.passwordTextFiled)
            self.view.layoutIfNeeded()
        }, completion: nil);
    }
}
