//
//  MailSender.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/12.
//

import skpsmtpmessage

class MailSender: NSObject, SKPSMTPMessageDelegate {
    static let shared = MailSender()
    
    let TODOARY_EMAIL: String = Bundle.main.infoDictionary?["TODOARY_EMAIL"] as? String ?? "TODOARY_EMAIL is nil"
    
    let TODOARY_PW: String = Bundle.main.infoDictionary?["TODOARY_PW"] as? String ?? "TODOARY_PW is nil"
    
    let TODOARY_CODE_EMAIL: String = Bundle.main.infoDictionary?["TODOARY_CODE_EMAIL"] as? String ?? "TODOARY_CODE_EMAIL is nil"
    
    let YERI_MAIL: String = Bundle.main.infoDictionary?["YERI_MAIL"] as? String ?? "YERI_MAIL is nil"
    
    var random_num = Int.random(in: 1000...9999)
    
    
    func randomGenerate() {
        var num = random_num
        UserDefaults.standard.set(num, forKey: "key")
        }

    func sendEmail() {
        let message = SKPSMTPMessage()
        message.relayHost = "smtp.gmail.com"
        message.login = TODOARY_EMAIL
        message.pass = TODOARY_PW
        message.requiresAuth = true
        message.wantsSecure = true
        message.relayPorts = [587]
        message.fromEmail = TODOARY_CODE_EMAIL
        message.toEmail = YERI_MAIL
        message.subject = "Todoary CODE"
        let messagePart = [kSKPSMTPPartContentTypeKey: "text/plain; charset=UTF-8", kSKPSMTPPartMessageKey: "인증번호 [\(random_num)]을 입력해 주세요."]
        message.parts = [messagePart]
        message.delegate = self
        message.send()
        
        randomGenerate()
    }

    func messageSent(_ message: SKPSMTPMessage!) {
        print("Successfully sent email!")
    }

    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
        print("Sending email failed!")
    }
}
