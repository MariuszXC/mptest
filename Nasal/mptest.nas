# TBD

# get coordinates of a local model
# calculate positions 2,4,6,8,10,12 km (nm?) ahead, at a sight rising slope, and with headng turned by ~180 degrees
# place new model instances in the scene at calculated locations
# (probably can use geo.put_model() for that)

# sim/model/path contains 'Aircraft/mptest/Models/mptest.xml'


var dump_acpos = func() {

    print("Current aircraft: ", getprop("/sim/aircraft"));  # just for testing

    var acpos = geo.aircraft_position();                    # for testing too
    coord = geo.Coord.new(acpos);
    coord.dump();

    # logic to implement:
    # - increment invocation counter C
    # - initial distance D = 2km (1mi??),
    # - with each invocation calculate distance D' = D * C
    # - get current ac position P, elevation E and heading H
    
    # - calculate target positions P'l, P'c, P'r:
    #   - P'l = (new coord at distance D', heading H - 2 (degrees), elevation E + C*100m)
    #   - P'c = (new coord at distance D', heading H              , elevation E + C*100m)
    #   - P'r = (new coord at distance D', heading H + 2 (degrees), elevation E + C*100m)

    # - place 3 models at coordinates P'l, P'c, P'r with heading set to (H+160, H+180, H+200) respectively
    #   - attitude slightly nose down??
    
};

