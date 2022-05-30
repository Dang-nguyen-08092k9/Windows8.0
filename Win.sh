sudo apt-get update -y
sudo apt-get install -y qemu-system-x86-64
wget -O RTL8139F.iso 'https://drive.google.com/uc?export=download&id=1wDL8vo9mmYKw1HKXZzaYHoKmzSt_wXai'
wget -O win8.0.qcow2 'https://download1326.mediafire.com/8ey9hj62vejg/73df07xabmz648p/win8.0.qcow2'

curl --silent --show-error http://127.0.0.1:5901/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 4G \
  -cpu EPYC \
  -boot order=d \
  -drive file=win8.0.qcow2 \
  -drive file=RTL8139F.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :2 \
  -cpu SandyBridge \
  -smp sockets=1,cores=4,threads=2 \
  -vga std \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
