# Golang Version Manager

Here is a small script to manage several golang versions in Ubuntu.

<p align="center">
  <a href="https://www.youtube.com/watch?v=rLnO2Reikns"><img src="https://img.youtube.com/vi/rLnO2Reikns/0.jpg" alt="GVM install video"></a>
</p>

## How to install

```sh
wget 'https://raw.githubusercontent.com/fulldump/gvm/master/gvm.sh'; chmod +x gvm.sh; ./gvm.sh install
```

## How to use

```sh
gvm set 1.7.5
```

That will download and configure your environment for golang `1.7.5`.

If you want to see all installed versions:

```sh
gvm list
```

