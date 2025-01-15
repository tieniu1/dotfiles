#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 定义要链接的文件列表
FILES=(
  ".zshrc"
  ".tmux.conf"
  ".tmux.conf.local"
)

# 定义模板文件及其目标文件
TEMPLATES=(
  ".zshrc.local.template:.zshrc.local"
)

# 定义要链接的目录列表
DIRECTORIES=(
  ".config"
)

# 创建单个符号链接的函数
create_symlink() {
  local src="$1"
  local dest="$2"

  # 如果目标已存在且是普通文件/目录，创建备份
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo -e "${RED}Backing up existing $dest to ${dest}.backup${NC}"
    mv "$dest" "${dest}.backup"
  fi

  # 如果符号链接已存在，先删除
  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  # 创建符号链接
  ln -s "$src" "$dest"
  echo -e "${GREEN}Created symlink: $dest -> $src${NC}"
}

# 处理模板文件的函数
process_template() {
  local template="$1"
  local target="$2"
  local dotfiles_target="$DOTFILES/$target"

  # 如果目标文件在 dotfiles 中不存在，从模板创建
  if [ ! -f "$dotfiles_target" ]; then
    cp "$DOTFILES/$template" "$dotfiles_target"
    echo -e "${GREEN}Created from template: $dotfiles_target${NC}"
    echo -e "${RED}Please edit $dotfiles_target to add your private information${NC}"
  else
    echo -e "${GREEN}Private config $dotfiles_target already exists, skipping...${NC}"
  fi

  # 创建符号链接到主目录
  create_symlink "$dotfiles_target" "$HOME/$target"
}

# 处理目录的函数
setup_directory() {
  local dir_src="$1"
  local dir_dest="$2"

  # 确保目标父目录存在
  mkdir -p "$(dirname "$dir_dest")"

  # 如果目标目录不存在，创建它
  if [ ! -d "$dir_dest" ]; then
    mkdir -p "$dir_dest"
  fi

  # 遍历源目录下的所有项目
  for item in "$dir_src"/*; do
    if [ -e "$item" ]; then
      local item_name=$(basename "$item")
      local dest_path="$dir_dest/$item_name"

      # 跳过 .DS_Store 文件
      if [ "$item_name" = ".DS_Store" ]; then
        continue
      fi

      # 如果目标已存在且不是链接，创建备份
      if [ -e "$dest_path" ] && [ ! -L "$dest_path" ]; then
        echo -e "${RED}Backing up existing $dest_path to ${dest_path}.backup${NC}"
        mv "$dest_path" "${dest_path}.backup"
      fi

      # 如果是链接，删除它
      if [ -L "$dest_path" ]; then
        rm "$dest_path"
      fi

      # 创建新的符号链接
      ln -s "$item" "$dest_path"
      echo -e "${GREEN}Created symlink: $dest_path -> $item${NC}"
    fi
  done
}

# 主函数
main() {
  echo "Setting up dotfiles..."

  # 处理普通文件
  echo -e "\n${GREEN}Creating symlinks for files...${NC}"
  for file in "${FILES[@]}"; do
    create_symlink "$DOTFILES/$file" "$HOME/$file"
  done

  # 处理模板文件
  echo -e "\n${GREEN}Processing template files...${NC}"
  for template_pair in "${TEMPLATES[@]}"; do
    IFS=':' read -r template target <<<"$template_pair"
    process_template "$template" "$target"
  done

  # 处理目录
  echo -e "\n${GREEN}Creating symlinks for directories...${NC}"
  for dir in "${DIRECTORIES[@]}"; do
    echo -e "\nProcessing directory: $dir"
    setup_directory "$DOTFILES/$dir" "$HOME/$dir"
  done

  echo -e "\n${GREEN}Done! Your dotfiles have been installed!${NC}"
}

# 运行主函数
main
