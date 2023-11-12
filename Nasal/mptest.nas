# Place self model at increasing dustances to test visibility ranges

# Written 2023 by Mariusz Matuszek (MariuszXC)

# get coordinates of a local model
# calculate positions 2,4,6,8,10,12 km (nm?) ahead, at a sight rising slope, and with headng turned by ~180 degrees
# place new model instances in the scene at calculated locations
# (probably can use geo.put_model() for that)

# Interacts with properties:
#	<mptest>
#		<hdg-offset-deg type="int">   4</hdg-offset-deg>
#		<alt-offset-m   type="int"> 100</alt-offset-m>
#		<dst-offset-m   type="int">1000</dist-offset-m>
#		<counter        type="int">   1</counter>
#	</mptest>
#
#   sim/model/path  ( contains 'Aircraft/mptest/Models/mptest.xml' )
#   sim/presets/heading-deg


var debug = 0 ;


# implemented logic:
# - get invocation counter C
# - get distance delta D,
# - get altitude delta A,
# - get hdg offset O,
# - with each invocation calculate distance delta D' = D * C
# - get current ac position P, elevation E and heading H

# - calculate target positions P'l, P'c, P'r:
#   - P'l = (new coord at distance D', heading H - O, elevation E + C*A)
#   - P'c = (new coord at distance D', heading H    , elevation E + C*A)
#   - P'r = (new coord at distance D', heading H + O, elevation E + C*A)

# - place 3 models at coordinates P'l, P'c, P'r with heading set to (H+160, H+180, H+200) respectively
# - attitude slightly nose down




var place_models = func () {

    if (debug) {
        print("mptest.place_models() called\n") ;
    }

    var counter_ref             = props.globals.getNode("mptest/counter",           1) ;
    var alt_offset_ref          = props.globals.getNode("mptest/alt-offset-m",      1) ;
    var dst_offset_ref          = props.globals.getNode("mptest/dst-offset-m",      1) ;
    var hdg_offset_ref          = props.globals.getNode("mptest/hdg-offset-deg",    1) ;
    var hdg_ref                 = props.globals.getNode("sim/presets/heading-deg",  1) ;
    var model_ref               = props.globals.getNode("sim/model/path",           1) ;

    var invocation_counter      = counter_ref.getIntValue() ;
    var alt_offset              = alt_offset_ref.getIntValue() ;
    var dst_offset              = dst_offset_ref.getIntValue() ;
    var hdg_offset              = hdg_offset_ref.getIntValue() ;

    var my_heading              = hdg_ref.getIntValue() ;
    var my_position             = geo.aircraft_position() ;
    var my_model                = model_ref.getValue() ;

    var my_alt                  = my_position.alt() ;

    var l_model_position        = geo.Coord.new(my_position) ;
    var c_model_position        = geo.Coord.new(my_position) ;
    var r_model_position        = geo.Coord.new(my_position) ;

    l_model_position.apply_course_distance(my_heading - hdg_offset, invocation_counter * dst_offset) ;
    l_model_position.set_alt(my_alt + 1 * invocation_counter * alt_offset) ;

    c_model_position.apply_course_distance(my_heading, invocation_counter * dst_offset) ;
    c_model_position.set_alt(my_alt + (invocation_counter * invocation_counter) * alt_offset) ;

    r_model_position.apply_course_distance(my_heading + hdg_offset, invocation_counter * dst_offset) ;
    r_model_position.set_alt(my_alt + 3 *invocation_counter * alt_offset) ;

    if (debug) {
        print(my_model) ;
        my_position.dump() ;
        l_model_position.dump() ;
        c_model_position.dump() ;
        r_model_position.dump() ;
    }

    geo.put_model(my_model, l_model_position, my_heading+160, -2) ;
    geo.put_model(my_model, c_model_position, my_heading+180, -2) ;
    geo.put_model(my_model, r_model_position, my_heading+200, -2) ;

    counter_ref.setIntValue(invocation_counter + 1) ;       # lastly increment invocation counter
};

