import? 'ext.just'

set dotenv-load

sync:
  rm -Rf ./content
  [ -n $SOURCE_DIR ] && ./update.sh $SOURCE_DIR ./content
  [ -n $MEDIA_DIR ] && cp -R $MEDIA_DIR ./content/Media
