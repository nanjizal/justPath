package justPath;

import justPath.PathCommand;
import justPath.IPathContext;
import haxe.ds.Vector;
class GraphicsPath{
    var commands: Vector<PathCommand>;
    var data:     Vector<Float>;
    var winding:  PathWinding;
    public function new( commands: Vector<PathCommand>, data:Vector<Float>, winding: PathWinding = EVEN_ODD ){
        this.commands = commands;
        this.data     = data;
        this.winding  = winding;
    }
    public function cubicCurveTo(controlX1:Float, controlY1:Float, controlX2:Float, controlY2:Float, anchorX:Float, anchorY:Float): Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, CUBIC_CURVE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+6);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len, controlX1   );
        vd.set( len+1, controlY1 );
        vd.set( len+2, controlX2 );
        vd.set( len+3, controlY2 );
        vd.set( len+4, anchorX   );
        vd.set( len+6, anchorY   );
        data = vd;
    }
    public function curveTo( controlX:Float, controlY:Float, anchorX:Float, anchorY:Float):Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, CURVE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+4);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len,   controlX );
        vd.set( len+1, controlY );
        vd.set( len+2, anchorX  );
        vd.set( len+3, anchorY  );
        data = vd;
    }
    public function lineTo( x:Float, y: Float ):Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, LINE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+2);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len,   x );
        vd.set( len+1, y );
        data = vd;
    }
    public function moveTo( x:Float, y: Float ):Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, MOVE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+2);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len,   x );
        vd.set( len+1, y );
        data = vd;
    }
    public function wideLineTo( x: Float, y: Float ): Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, WIDE_LINE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+4);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len,   x );
        vd.set( len+1, y );
        vd.set( len+2, x );
        vd.set( len+3, y );
        data = vd;
    }
    public function wideMoveTo( x: Float, y: Float ): Void {
        var len = commands.length;
        var vc = new Vector<PathCommand>(len+1);
        Vector.blit( commands, 0, vc, 0, len );
        vc.set( len, WIDE_MOVE_TO );
        commands = vc;
        len = data.length;
        var vd = new Vector<Float>(len+4);
        Vector.blit( data, 0, vd, 0, len );
        vd.set( len,   x );
        vd.set( len+1, y );
        vd.set( len+2, x );
        vd.set( len+3, y );
        data = vd;
    }
    public function parse( pathContext: IPathContext ){
        var len = commands.length;
        var pos = 0;
        for( i in 0...len ){
            var command: PathCommand = commands.get( i );
            switch( command ){
                case MOVE_TO:
                    pathContext.moveTo( data.get( pos )
                                      , data.get( pos + 1 ) );
                    pos += 2;
                case LINE_TO:
                    pathContext.lineTo( data.get( pos )
                                      , data.get( pos + 1 ) );
                    pos += 2;
                case CURVE_TO:
                    pathContext.quadTo( data.get( pos ),     data.get( pos + 1 )
                                      , data.get( pos + 2 ), data.get( pos + 3 ) );
                    pos += 4;
                case CUBIC_CURVE_TO:
                    pathContext.curveTo( data.get( pos ),     data.get( pos + 1 )
                                       , data.get( pos + 2 ), data.get( pos + 3 ) 
                                       , data.get( pos + 3 ), data.get( pos + 4 ) );
                    pos += 6;
                case WIDE_MOVE_TO: 
                    pathContext.moveTo( data.get( pos )
                                      , data.get( pos + 1 ) );
                    pos += 4;
                case WIDE_LINE_TO: 
                    pathContext.lineTo( data.get( pos )
                                      , data.get( pos + 1 ) );
                    pos += 4;
                case NO_OP:
                    //
            }
        }
    }
}