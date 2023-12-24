import UIKit

extension UIImageView {
    func setDefaultUserImage() {
        self.image = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }
}
