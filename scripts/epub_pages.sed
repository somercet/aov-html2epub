/<!--[^>]+PPAGE[^>]+-->/ {
s/<!--[ 	]+PPAGE[ 	]+//
s/[ 	]+-->//
s;[-\.0-9]+;<span epub:type="pagebreak" class="pages" id="page&"></span>;
}
