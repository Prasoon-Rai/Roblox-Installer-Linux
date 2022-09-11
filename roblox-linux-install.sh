# Check the echos for info

echo "Automated Wine installer is starting ..."

echo "===============================Wine For Gnu/Linux================================
                                        
        This is just an automated Wine installer. You have to install Roblox separatly.
        
        When this is done, install roblox like normal, or so im told.
        I (Anonymous3-a) use arch, and no online tutorial has worked, so tell me if it
        works on your computer.

        Thank you!

      ==========================Anonymous3-a helped a bit===============================
    "

# Stor
read -p "Enter distro (Debian, Ubuntu, or Arch):" currentdistro

mkdir -p /tmp/wineinstaller
cd /tmp/wineinstaller

if [ currentdistro -eq "Debian" || currentdistro -eq "Ubuntu"];then
  sudo apt install python3 -y
  sudo apt install git -y
fi
if [ currentdistro -eq "Arch"];then
  sudo pacman -S python3
  sudo pacman -S git
fi

if [ currentdistro -eq "Debian" || currentdistro -eq "Ubuntu"];then
  echo "Shining up..."
  git clone https://github.com/Anonymous3-a/RandomSoftware/raw/main/aptup
  chmod +x aptup
  ./aptup
  echo "Done."
fi
if [ currentdistro -eq "Arch" ];then
  echo "Shining up..."
  sudo pacman -Syu
  echo "Done."
fi

if [ currentdistro -eq "Debian" || currentdistro -eq "Ubuntu"];then
  sudo dpkg --add-architecture i386
  sudo wget -nc -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
  sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
  read -p "Stable, Devel, or Staging: " winetoinstall
  if [ winetoinstall -eq "Stable" ];then
    sudo apt install --install-recommends winehq-stable
  fi
  if [ winetoinstall -eq "Devel" ];then
    sudo apt install --install-recommends winehq-devel
  fi
  if [ winetoinstall -eq "Staging" ];then
    sudo apt install --install-recommends winehq-staging
  fi
  sudo apt install --install-recommends winehq
  sudo apt install -y git python3-pip
fi
wget --no-check-certificate "https://onedrive.live.com/download?cid=0D1B2C3D089F7FA0&resid=D1B2C3D089F7FA0%21106&authkey=AAsdS8XcgeXp-_c" -O wine-tkg-staging-fsync-git-6.15.r0.g4b6879f3.tar.xz

tar -xf wine-tkg-staging-fsync-git-6.15.r0.g4b6879f3.tar.xz

git clone https://gitlab.com/brinkervii/grapejuice.git

cd grapejuice

python3 ./install.py

echo "
Optimizing ...
"
sed '3d' ~/.config/brinkervii/grapejuice/user_settings.json
sed '3 i /home/$(whoami)/wine-tkg-staging-fsync-git-6.15.r0.g4b6879f3/bin/wine' ~/.config/brinkervii/grapejuice/user_settings.json
echo "Installation Complete!"
