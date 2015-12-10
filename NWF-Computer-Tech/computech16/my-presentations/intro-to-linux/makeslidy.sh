# --theme (default, flower, i18n, pixel, yatil)

TITLE='Introduction to Linux'
DEST=html

TIME='--attribute duration=50'

#THEME='--attribute theme=volnitsky'
THEME=

# run it
asciidoc --backend slidy $TIME $THEME $1
