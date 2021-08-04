//
//  HomeViewController.swift
//  TV Shows
//
//  Created by infinum on 22/07/2021.
//

import Foundation
import UIKit
import Alamofire

struct TVShowItem: Decodable {
    let id: Int?
    let name: String
    let image: String?
}

struct ShowsResponse: Decodable {
    let shows: [TVShowItem]
}

class HomeViewController: UIViewController, UITableViewDataSource {
    struct AuthInfo: Codable {
        var accessToken: String
        var client: String
        var tokenType: String
        var expiry: String
        var uid: String

        enum CodingKeys: String, CodingKey {
            case accessToken = "access-token"
            case client = "client"
            case tokenType = "token-type"
            case expiry = "expiry"
            case uid = "uid"
        }

        init(headers: [String: String?]) throws {
            let data = try JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted)
            let decoder = JSONDecoder()
            self = try decoder.decode(Self.self, from: data)
        }

        var headers: [String: String] {
            do {
                let data = try JSONEncoder().encode(self)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                return jsonObject as? [String: String] ?? [:]
            } catch {
                return [:]
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    let nav = UINavigationController()
    var length: Int = 0
    var authInfo: AuthInfo? = nil
    private let items = [
        TVShowItem(id: 1, name: "Fringe", image: nil),
        TVShowItem(id: 2, name: "Dexter", image: nil),
        TVShowItem(id: 3, name: "The X-Files", image: nil),
        TVShowItem(id: 4, name: "The Office", image: nil),
        TVShowItem(id: 5, name: "Fringe", image: nil),
        TVShowItem(id: 6, name: "Dexter", image: nil),
        TVShowItem(id: 7, name: "The X-Files", image: nil),
        TVShowItem(id: 8, name: "The Office", image: nil)
    ]

    func configure(with i: TVShowItem){
        for i in items {
            tableView.cellForRow(at: IndexPath(index: i.id!))?.textLabel?.text = i.name
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TableCell",
            for: indexPath) as! TableCell
        cell.configure(with: TVShowItem(id: 1, name: "", image: nil))
/*
        AF
            .request(
                "https://tv-shows.infinum.academy/shows",
                method: .get,
                parameters: ["page": "1", "items": "100"],
                encoder: HTTPHeaders(authInfo!.headers) as! ParameterEncoder
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self, completionHandler: {response in
                switch response.result {
                case .success(let body):
                    print(body)
                    self.length = body.shows.count
                    for i in body.shows { cell.showLabel(with: i.title) }
                    tableView.reloadData()
                    case .failure(let err):
                        print(err)
                }
            })
*/
        return cell
    }
/*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        //print("Selected Item: \(item)")
    }
*/
    func tableView(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat { 80.0 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.length }

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView?.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
    }
}
