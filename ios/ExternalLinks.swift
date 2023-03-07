import Foundation
import UIKit

func openLinkInBrowser(link: String) {
    guard let url = URL(string: link),
        UIApplication.shared.canOpenURL(url) else {
        return
    }
    UIApplication.shared.open(url)
}
