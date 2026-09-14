echo -e "\e[32m[Fonts]\e[0m Installing all the fonts..."

FONTS=(
  google-roboto-fonts
  symbols-only-nerd-fonts
)
install_zypper "${FONTS[@]}"

FONTS_DIR=$HOME/.local/share/fonts
if [ ! -d "$FONTS_DIR" ]; then
  mkdir -p $FONTS_DIR
fi

NERD_FONTS_VERSION=v3.3.0
NERD_FONTS=(
  0xProto
  DroidSansMono
  FiraMono
  3270
  CascadiaCode
  FantasqueSansMono
  FiraCode
  Hack
  IosevkaTerm
  JetBrainsMono
  Noto
  RobotoMono
)

cd /tmp

for FONT in "${NERD_FONTS[@]}"; do
  # Check if any files related to the font are already in the FONTS_DIR
  if find "$FONTS_DIR" -type f -name "*$FONT*" | grep -q .; then
    echo "Font $FONT is already installed. Skipping..."
  else
    echo "Installing font $FONT..."
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/${FONT}.zip"
    unzip -o "${FONT}.zip" -d "$FONTS_DIR"
    rm "${FONT}.zip"
  fi
done

if [ ! -d "/tmp/aporetic" ]; then
    git clone https://github.com/protesilaos/aporetic /tmp/aporetic
    cp -r /tmp/aporetic/aporetic-s* "$FONTS_DIR"

    git clone https://github.com/Echinoidea/Aporetic-Nerd-Font /tmp/aporetic-nerd
    cp /tmp/aporetic-nerd/*.ttf "$FONTS_DIR"
fi

fc-cache $FONTS_DIR

cd $SCRIPT_DIR
