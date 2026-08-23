config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/prosody/prosody.cfg.lua.new
config etc/prosody/migrator.cfg.lua.new

if ! [ -L etc/rc.d/rc.prosody ] ;
then
  rm -f etc/rc.d/rc.prosody
  ln -s /usr/bin/prosodyctl etc/rc.d/rc.prosody
fi
