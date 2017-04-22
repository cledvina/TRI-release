var nodes = $x('//table[contains(@summary,"table")]/tbody/tr/td[2]/a');
var links = [];
for (x in nodes) {
  var data = nodes[x].href;
  data += "\t" + nodes[x].text;
  links.push(data);
  console.log(data);
}
copy(links.join("\n"));
links.length + ' links copied to clipboard';
