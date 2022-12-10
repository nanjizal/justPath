package justPath;

class LinePathContextTrace implements ILinePathContext {
    public function new(){
    
    }
    public function moveTo( x: Float, y: Float ): Void{
        trace( 'moveTo( $x, $y );' );
    }
    public function lineTo( x: Float, y: Float ): Void{
        trace( 'lineTo( $x, $y );' );
    }
}
