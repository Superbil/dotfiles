## dotfiles ##

this is my dotfiles

I use stow to manager it.

## Use way ##

* install script

``` shell
install_dotfile.sh <package_name_1> ... <package_name_n>
```

* manual install

`stow -t ~ <package_name>`

alwasy set target is HOME

`package_name` is an folder

## Delete package

`$ stow -t -D <package_name>`

`package_name` is an folder

## How to use stow ##

You can read this [page](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
