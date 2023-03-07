import Foundation
import GoogleSignIn
import SwiftUI
class SocialAuth {
  func signIn(provider: String) {
    switch provider {
    case "google":
      googleAuth()
    case "apple":
      appleAuth()
    case "facebook":
      facebookAuth()
    default:
      print("Unknown provider: \(provider)")
    }
  }
  private func googleAuth() {
    guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
      print("There is no root view controller!")
      return
    }
    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
      guard let signInResult = signInResult else {
        print("Error! \(String(describing: error))")
        return
      }
      let accessToken = signInResult.user.idToken!.tokenString;
      let email = signInResult.user.profile!.email;
      self.sendToJavaScript(accessToken: accessToken, email: email, provider: "google");
    }
  }
  private func appleAuth() {
    // TODO: Implement Apple sign-in
    self.sendToJavaScript(accessToken: "appleAccessToken", email: "apple@example.com", provider: "apple");
  }
  private func facebookAuth() {
    // TODO: Implement Facebook sign-in
    self.sendToJavaScript(accessToken: "facebookAccessToken", email: "facebook@example.com", provider: "facebook");
  }
  private func sendToJavaScript(accessToken: String, email: String, provider: String) {
    let data = ["accessToken": accessToken, "email": email, "provider": provider]
    guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
      print("Error: could not create JSON data")
      return
    }
    let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
    let jsCode = "this.dispatchEvent(new CustomEvent('external-social-auth', { detail: \(jsonString) }))"
    AuthDemo.webView.evaluateJavaScript(jsCode)
  }
}
