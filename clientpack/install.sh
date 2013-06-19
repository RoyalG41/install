
SKYNETDIR="/root/virtualskynet"
CLIENT="myclient"


mv $SKYNETDIR/webapps/virtualskynet.war $SKYNETDIR/webapps/$CLIENT.war

sleep 10


rm -rf $SKYNETDIR/webapps/$CLIENT/images/background.jpg
rm -rf $SKYNETDIR/webapps/$CLIENT/images/logo.png


cp background.jpg $SKYNETDIR/webapps/$CLIENT/images
cp logo.png $SKYNETDIR/webapps/$CLIENT/images


