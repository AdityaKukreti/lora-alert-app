import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Screens/Arduino%20Chat%20Page/bluetooth_chat_page.dart';

class BluetoothDeviceListPage extends StatefulWidget {
  const BluetoothDeviceListPage({super.key});

  @override
  _BluetoothDeviceListPageState createState() =>
      _BluetoothDeviceListPageState();
}

class _BluetoothDeviceListPageState extends State<BluetoothDeviceListPage> {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      _devices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyFont(
            text: "Select your device",
            size: 25,
            weight: FontWeight.w500,
            color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _devices.isNotEmpty
            ? ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  BluetoothDevice device = _devices[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BluetoothChatPage(device: device);
                      }));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bluetooth,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyFont(
                                  text: device.name as String,
                                  size: 18,
                                  weight: FontWeight.w500,
                                  color: Colors.black),
                              MyFont(
                                  text: device.address as String,
                                  size: 16,
                                  weight: FontWeight.w400,
                                  color: Colors.black)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text("No bonded devices found"),
              ),
      ),
    );
  }
}
