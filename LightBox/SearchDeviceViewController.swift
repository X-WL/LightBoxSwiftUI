//
//  SearchDeviceViewController.swift
//  LightBox
//
//  Created by Dmitry Kostyuchenko on 13.08.2020.
//  Copyright © 2020 Dmitry Kostyuchenko. All rights reserved.
//

import UIKit
import OSCKit

class SearchDeviceViewController: UITableViewController, OSCClientDelegate & OSCPacketDestination {
    let clientOSC = OSCClient()
//    var devices = [Device]()
    var devices = [
        Device(model: "Dev", title: "Resolume", ip: [192,168,0,189], inPort: 8000, outPort: 7000),
        Device(model: "Dev2", title: "Test", ip: [192,168,0,184], inPort: 8000, outPort: 7000),]
    
    func clientDidConnect(client: OSCClient) {
        print("Client did connect")
    }

    func clientDidDisconnect(client: OSCClient) {
        print("Client did disconnect")
    }
    
    func take(message: OSCMessage) {
        print("Received message - \(message.addressPattern)")
    }

    func take(bundle: OSCBundle) {
        print(" "
        )
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tableView.rowHeight=100
        oscInit()
    }

    func oscInit(){
        clientOSC.host = "192.168.0.194"
        clientOSC.port = 24601
//        clientOSC.useTCP = true
        clientOSC.delegate = self
    }
    
    @objc func scanDeviceList() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return devices.count
        }
    //
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Device", for: indexPath)
            let d = devices[indexPath.row]
                cell.textLabel?.text = String("\(d.title)\n\t ip: \(d.ip[0]):\(d.ip[1]):\(d.ip[2]):\(d.ip[3])\n\t port: \(d.inPort) / \(d.outPort)"
            )
            cell.textLabel?.numberOfLines = 3
//            cell.detailTextLabel?.text =
//            cell.imageView?.image = UIImage(named: pictures[indexPath.row])
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Main View") as? MainViewController {
                vc.deviceData.device = devices[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        }
}

