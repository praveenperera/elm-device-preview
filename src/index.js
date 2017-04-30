require("./main.css");
var logoPath = require("./logo.svg");
var Elm = require("./App.elm");

var root = document.getElementById("root");

var app = Elm.App.embed(root, { path: logoPath });

app.ports.renderPreview.subscribe(function() {
  renderPreview();
});

app.ports.attachStyleSheet.subscribe(function() {
  setTimeout(attachStyleSheet, 200);
});

var renderPreview = function() {
  var hiddenRow = document.querySelector(".content-row");
  var iframe = document.getElementById("iphoneFrame");

  iframe.srcdoc = hiddenRow.innerHTML;
};

var attachStyleSheet = function() {
  var cssLink = document.createElement("link");

  cssLink.href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css";
  cssLink.rel = "stylesheet";
  cssLink.type = "text/css";

  frames["iphoneFrame"].document.head.appendChild(cssLink);
};
