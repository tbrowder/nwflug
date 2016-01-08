# --theme (default, flower, i18n, pixel, yatil)

TMPLDIR=/usr/local/src/asciidoctor-deck.js/templates/haml

# run it
asciidoctor -T $TMPLDIR agenda.adoc-deck
