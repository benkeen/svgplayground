import "dart:html";

Element filterElement;

void main() {

  // locate our filter element. This is where we're going to be dynamically creating our 
  // SVG filters
  filterElement = query("#dynamicFilter");

  // assign our event handlers
  query("#feColorMatrixType").on.change.add(changeFilterType);
  query("#feColorMatrixType_saturate input").on.change.add(changeSaturation);
  query("#feColorMatrixType_hueRotate input").on.change.add(changeHueRotate);
  query("#feColorMatrixTable").on.change.add(changeMatrixTable);
}


void changeFilterType(Event e) {
  Element filterField = e.currentTarget;
  String selectedFilter = filterField.value;

  // hide all feColorMatrix setting section; the following code will show the right one
  query(".feColorMatrixTypeSettings").classes.add("hidden");

  if (!selectedFilter.isEmpty) {
    //query("#exampleImage").classes.add(filterField.value);
    var sb = new StringBuffer();
    sb.add("#feColorMatrixType_");
    sb.add(selectedFilter);
    query(sb.toString()).classes.remove("hidden");

    if (selectedFilter == "luminanceToAlpha") {
      changeLuminanceToAlpha(); 
    }
  }
}


void changeSaturation(Event e) {
  Element saturationSlider = e.currentTarget;
  var val = saturationSlider.value;
  filterElement.innerHTML = '<feColorMatrix type="saturate" values="$val" />';
}

void changeHueRotate(Event e) {
  Element saturationSlider = e.currentTarget;
  var val = saturationSlider.value;
  filterElement.innerHTML = '<feColorMatrix type="hueRotate" values="$val" />';
}

void changeLuminanceToAlpha() {
  filterElement.innerHTML = '<feColorMatrix type="luminanceToAlpha" x="0%" y="0%" />';
}

void changeMatrixTable(Event e) {
  var els = queryAll("#feColorMatrixTable input");
  var matrix = [];
  for (var i=0; i<els.length; i++) {
    matrix.add(els[i].value);
  }
  var matrixStr = Strings.join(matrix, " ");
  window.console.log('<feColorMatrix type="matrix" values="$matrixStr" />');
  filterElement.innerHTML = '<feColorMatrix type="matrix" values="$matrixStr" />';
}