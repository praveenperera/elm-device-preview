require("./main.css");
var logoPath = require("./logo.svg");
var Elm = require("./App.elm");

var root = document.getElementById("root");

var app = Elm.App.embed(root, { path: logoPath });

app.ports.renderPreview.subscribe(function() {
  setTimeout(renderPreview, 40);
});

var renderPreview = function() {
  var hiddenRow = document.querySelector(".content-row");
  var iframe = document.getElementById("iphoneFrame");
  iframe.srcdoc = hiddenRow.innerHTML;
};
