# step-1: generate ssh-key for hsun-code github

```sh
# generate
ssh-keygen -t ed25519 -C "hsun-code@outlook.com"

# add it to hsun-code git
at ~/.ssh/id_ed25519.pub
```

# step-2: run bootstrap.sh

```sh
cd /tmp
git clone https://github.com/hsun-code/dotfiles.git
cd ./dotfiles/packages
bash bootstrap.sh

# optional
rm -rf /tmp/dotfiles
```

