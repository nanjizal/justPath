# justPath
justPath is quick parsing of a string from an svg path.

```haxe
function draw(){
// beginfill 
// lineStyle
// just trace out version.
var p = new SvgPath( new PathContextTrace() );
p.parse( svgPathOnlyString, 0, 0 );
// endFill
}
```

[0.0.2-alpha](https://github.com/nanjizal/justPath/releases/tag/0.0.2-alpha) pre-release
