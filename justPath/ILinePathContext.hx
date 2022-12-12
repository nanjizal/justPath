package justPath;

interface ILinePathContext{
    public function moveTo( x: Float, y: Float ): Void;
    public function lineTo( x: Float, y: Float ): Void;
    // to allow the lineTo from curves to be used differently.
    public function lineSegmentTo( x: Float, y: Float ): Void;
}
