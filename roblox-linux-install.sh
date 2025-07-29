#!/bin/bash

echo "--- Roblox on Linux Installer (via Grapejuice) ---"
echo "This script will guide you through installing Grapejuice, which allows you to run Roblox."
echo "-------------------------------------------------"

check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: '$1' command not found. Please install it first."
        echo "For most systems, you can install it with: sudo apt install $1 (Debian/Ubuntu) or sudo dnf install $1 (Fedora) or sudo pacman -S $1 (Arch)"
        exit 1
    fi
}

check_command "sudo"
check_command "curl"

echo "Detecting your Linux distribution..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID=$ID
    DISTRO_LIKE=${ID_LIKE}
    DISTRO_VERSION_ID=$VERSION_ID
else
    echo "Warning: Could not detect distribution using /etc/os-release. Falling back to generic instructions."
    DISTRO_ID="unknown"
fi

echo "Detected Distribution: ${DISTRO_ID} (ID_LIKE: ${DISTRO_LIKE})"

case "$DISTRO_ID" in
    ubuntu|debian)
        echo "--- Detected Ubuntu/Debian based system ---"
        echo "Grapejuice is available via a PPA (Personal Package Archive)."
        echo "Adding the Grapejuice PPA and installing..."

        sudo apt update
        sudo apt install -y software-properties-common apt-transport-https
        sudo add-apt-repository -y ppa:brinkervii/grapejuice
        
        # Add Wine repository (Grapejuice depends on Wine)
        echo "Adding WineHQ repository..."
        sudo mkdir -pm755 /etc/apt/keyrings
        sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.pub
        
        if [[ "$DISTRO_ID" == "ubuntu" ]]; then
            UBUNTU_CODENAME=$(lsb_release -sc)
            sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/${UBUNTU_CODENAME}/winehq-${UBUNTU_CODENAME}.sources
        elif [[ "$DISTRO_ID" == "debian" ]]; then
            DEBIAN_CODENAME=$(lsb_release -sc)
            sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/${DEBIAN_CODENAME}/winehq-${DEBIAN_CODENAME}.sources
        fi

        echo "Updating package lists and installing Grapejuice and Wine..."
        sudo apt update
        sudo apt install -y --install-recommends winehq-stable
        sudo apt install -y grapejuice

        echo "Grapejuice and Wine should now be installed."
        ;;

    fedora)
        echo "--- Detected Fedora system ---"
        echo "Grapejuice is available via COPR."
        echo "Enabling COPR repository and installing..."

        sudo dnf copr enable -y brindy/grapejuice
        sudo dnf install -y grapejuice

        echo "Grapejuice should now be installed."
        ;;

    arch|manjaro)
        echo "--- Detected Arch Linux / Manjaro system ---"
        echo "Grapejuice is available in the AUR (Arch User Repository)."
        echo "You will need an AUR helper like 'yay' or 'paru' to install it."
        echo "If you don't have one, install 'yay' first (example):"
        echo "  sudo pacman -S --needed git base-devel"
        echo "  git clone https://aur.archlinux.org/yay.git"
        echo "  cd yay"
        echo "  makepkg -si"
        echo "Then, you can install Grapejuice:"
        echo "  yay -S grapejuice"
        echo "  # or paru -S grapejuice"
        echo ""
        echo "Please run the above commands manually after the script finishes."
        ;;

    opensuse*)
        echo "--- Detected OpenSUSE system ---"
        echo "Grapejuice is available via the Open Build Service (OBS)."
        echo "Adding the OBS repository and installing..."

        sudo zypper addrepo https://download.opensuse.org/repositories/home:brinkervii:grapejuice/openSUSE_Tumbleweed/home:brinkervii:grapejuice.repo
        sudo zypper refresh
        sudo zypper install -y grapejuice

        echo "Grapejuice should now be installed."
        ;;
    
    solus)
        echo "--- Detected Solus system ---"
        echo "Grapejuice is available in the Solus repositories."
        echo "Installing Grapejuice..."

        sudo eopkg install -y grapejuice

        echo "Grapejuice should now be installed."
        ;;

    *)
        echo "--- Detected an unsupported or unknown distribution: ${DISTRO_ID} ---"
        echo "Unfortunately, this script cannot automate the installation for your system."
        echo "Please visit the official Grapejuice GitHub page for installation instructions:"
        echo "  https://github.com/brinkervii/grapejuice"
        echo "Look for the 'Installation' section and follow the instructions for your specific distribution."
        ;;
esac

echo "-------------------------------------------------"
echo "--- Installation Attempt Complete ---"
echo "To launch Grapejuice and install Roblox:"
echo "1. Open your applications menu and search for 'Grapejuice'."
echo "2. Launch Grapejuice."
echo "3. Follow the on-screen instructions to install Roblox."
echo "   (This usually involves clicking 'Install Roblox' or similar in the Grapejuice UI)."
echo ""
echo "If you encounter issues, please refer to the Grapejuice documentation or community forums."
echo "-------------------------------------------------"
