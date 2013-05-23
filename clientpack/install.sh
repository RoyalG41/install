
SKYNETDIR="/root/virtualskynet"
CLIENT="dialcloud"

mv $SKYNETDIR/webapps/virtualskynet.war $SKYNETDIR/webapps/$CLIENT.war

sleep 10

rm -rf $SKYNETDIR/webapps/$CLIENT/zimages/background.jpg
rm -rf $SKYNETDIR/webapps/$CLIENT/zimages/logo.png
rm -rf $SKYNETDIR/webapps/$CLIENT/zimages/logo2.png

cp background.jpg $SKYNETDIR/webapps/$CLIENT/zimages
cp logo.png $SKYNETDIR/webapps/$CLIENT/zimages
cp logo2.png $SKYNETDIR/webapps/$CLIENT/zimages

