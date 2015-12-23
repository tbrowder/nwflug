# --theme (default, flower, i18n, pixel, yatil)

TITLE='Introduction to Linux'
DEST=html

THEME=default
#THEME=flower
#THEME=i18n
#THEME=pixel
THEME=yatil

# run it
#pod2s5 --name $TITLE --theme $THEME --dest $DEST $1
pod2s5 --theme $THEME --dest $DEST $1