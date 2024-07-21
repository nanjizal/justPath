package justPath;
enum abstract PathCommand( Int ) from Int to Int {
    var NO_OP = 0;
    var MOVE_TO = 1;
    var LINE_TO = 2;
    var CURVE_TO = 3;
    var WIDE_MOVE_TO = 4;
    var WIDE_LINE_TO = 5;
    var CUBIC_CURVE_TO = 6;
}
enum abstract PathWinding( String ) from String to String {
    var EVEN_ODD = "evenOdd";
    var NON_ZERO = "nonZero";
}