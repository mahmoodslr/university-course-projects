# Description
This project demonstrates connecting two different networks using **two routers** in **Cisco Packet Tracer**.  
Two PCs located in separate subnets communicate successfully through static routing.

---

## Network Overview
Topology:

---

## IP Configuration

**PC2**
- IP: `192.168.1.10`
- Mask: `255.255.255.0`
- Gateway: `192.168.1.1`

**Router0**
- Fa0/0: `192.168.1.1`
- Fa1/0: `10.1.1.1`

**Router1**
- Fa1/0: `10.1.1.2`
- Fa0/0: `172.150.1.1`

**PC3**
- IP: `172.150.1.20`
- Mask: `255.255.0.0`
- Gateway: `172.150.1.1`

---

## How It Works
- Each PC uses its router as the default gateway.
- Static routes are configured on both routers to reach the remote network.
- ICMP (`ping`) is used to verify connectivity.

---

## TTL Explanation
The observed **TTL value is 126**.

- Windows initial TTL = **128**
- Packet passes through **2 routers**
- Each router decreases TTL by 1

128 - 2 = 126


This confirms successful routing through two routers.

---

## Tools Used
- Cisco Packet Tracer

---

## Notes
- Educational project for basic routing concepts
- Uses static routing only




---

<div style="display: flex; justify-content: center;">

<img src="https://github.com/user-attachments/assets/344ef3a8-572f-4d9e-94a1-5ee13b1f2c95" width="300" height="450" style="border: 2px solid #ccc; border-radius: 10px; box-shadow: 3px 3px 10px rgba(0,0,0,0.1);" /> 

<img src="https://github.com/user-attachments/assets/59a43045-6345-404d-a746-f4a6ab4afd9d" width="200" height="200" style="border: 2px solid #ccc; border-radius: 10px; box-shadow: 3px 3px 10px rgba(0,0,0,0.1);" /> 

<img src="https://github.com/user-attachments/assets/89975e83-f143-4172-a494-f5b06f315f45" width="300" height="450" style="border: 2px solid #ccc; border-radius: 10px; box-shadow: 3px 3px 10px rgba(0,0,0,0.1);" /> 

</div>
