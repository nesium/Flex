import UIKit
import Flex
import XCTest

final class ListViewTests: XCTestCase {
  func testDoesNotChangeTableViewCellsFrame() throws {
    class Cell: UITableViewCell {
      let box: UIView

      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.box = UIView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.box)

        self.flex
          .enable()
          .padding(top: 10, left: 10, bottom: 10, right: 10)

        self.box.flex
          .enable()
          .height(50)
      }

      @available(*, unavailable)
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

      override func layoutSubviews() {
        super.layoutSubviews()
        self.flex.layoutSubviews()
      }
    }

    class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
      }

      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
      }

      func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
      ) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      }
    }

    let ds = DataSource()

    let tableView = UITableView()
    tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    tableView.dataSource = ds
    tableView.delegate = ds

    let container = ContainerView()
    container.flex
      .addChild(tableView)
      .grow(1)

    container.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
    container.layoutIfNeeded()

    XCTAssertEqual(tableView.frame, CGRect(x: 0, y: 0, width: 100, height: 200))
    XCTAssertEqual(tableView.rectForRow(at: [0, 0]), CGRect(x: 0, y: 0, width: 100, height: 40))
    XCTAssertEqual(tableView.rectForRow(at: [0, 1]), CGRect(x: 0, y: 40, width: 100, height: 40))
    XCTAssertEqual(tableView.rectForRow(at: [0, 2]), CGRect(x: 0, y: 80, width: 100, height: 40))

    var cell = try XCTUnwrap(tableView.cellForRow(at: [0, 0]) as? Cell)
    XCTAssertEqual(cell.box.frame, CGRect(x: 10, y: 10, width: 80, height: 50))

    container.setNeedsLayout()
    container.layoutIfNeeded()

    XCTAssertEqual(tableView.frame, CGRect(x: 0, y: 0, width: 100, height: 200))
    XCTAssertEqual(tableView.rectForRow(at: [0, 0]), CGRect(x: 0, y: 0, width: 100, height: 40))
    XCTAssertEqual(tableView.rectForRow(at: [0, 1]), CGRect(x: 0, y: 40, width: 100, height: 40))
    XCTAssertEqual(tableView.rectForRow(at: [0, 2]), CGRect(x: 0, y: 80, width: 100, height: 40))

    cell = try XCTUnwrap(tableView.cellForRow(at: [0, 0]) as? Cell)
    XCTAssertEqual(cell.box.frame, CGRect(x: 10, y: 10, width: 80, height: 50))
  }
}
