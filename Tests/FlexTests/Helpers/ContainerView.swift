import Flex
import UIKit

class ContainerView: UIView {
  init() {
    super.init(frame: .zero)
    self.flex.enable()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.flex.layoutSubviews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.flex.sizeThatFits(size)
  }
}

