

module icon_hand(center_height, outline_height){
    translate(17/2 * yv)
    rotate(-90){
        color("white")
        svg_extrude(center_height, "../svg/icon_hand center.svg", center_plane = true);
        color("grey")
        svg_extrude(outline_height, "../svg/icon_hand solid.svg", center_plane = true);
    }
}

module icon_arrow(pointing = false, center_height, outline_height){
    translate(( pointing ? 7.25 : 0 ) * yv)
    rotate( pointing ? atan2(-16,-8) : 0 )
    {
        color("grey")
        svg_extrude(center_height, "../svg/icon_arrow center.svg", center_plane = true);
        color("white")
        svg_extrude(outline_height, "../svg/icon_arrow solid.svg", center_plane = true);
    }
}

module svg_extrude(height, file_path, center_plane = false){
    union(){
        translate( ( center_plane ? -height/2 : 0 ) * zv)
        linear_extrude( height )
        import( file_path,  dpi = 300 );
    }
}



