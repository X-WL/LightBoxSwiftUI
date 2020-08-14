//
//  MainViewController.swift
//  LightBox
//
//  Created by Dmitry Kostyuchenko on 14.08.2020.
//  Copyright © 2020 Dmitry Kostyuchenko. All rights reserved.
//

import UIKit
import OSCKit

class MainViewController: UIViewController, OSCClientDelegate & OSCPacketDestination {
    let clientOSC = OSCClient()
    let serverOSC = OSCServer()
    
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
        print("Received bundle - time tag: \(bundle.timeTag.hex()) elements: \(bundle.elements.count)"
        )
    }
    
    @IBOutlet var sendBtn: UIButton!
    
    var deviceData = DeviceData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = deviceData.device.title
        // Do any additional setup after loading the view.
        oscInit(device: deviceData.device)
    }
    
    func oscInit(device: Device){
        clientOSC.host = "\(device.ip[0]).\(device.ip[1]).\(device.ip[2]).\(device.ip[3])"
        clientOSC.port = device.outPort
        clientOSC.delegate = self
        serverOSC.port = device.inPort
        serverOSC.delegate = self
        do {
            try serverOSC.startListening()
        } catch {
            print("Error init OSC server")
        }
    }
    

    @IBAction func sendAction(_ sender: Any) {
        let message = OSCMessage(with: "/osc/kit", arguments: [1,
        3.142,
        "hello world!",
        Data(count: 2),
        OSCArgument.oscTrue,
        OSCArgument.oscFalse,
        OSCArgument.oscNil,
        OSCArgument.oscImpulse])
        clientOSC.send(packet: message)
        print("send")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
