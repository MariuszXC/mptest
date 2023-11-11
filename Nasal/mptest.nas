# TBD

# get coordinates of a local model
# calculate positions 2,4,6,8,10,12 nm ahead, at a sight rising slope, and with headng turned by 180 degrees
# place new model instances in the scene at calculated locations
# (probably can use geo.put_model() for that)

# sim/model/path contains 'Aircraft/mptest/Models/mptest.xml'


var dump_acpos = func() {

    print("Current aircraft: ", getprop("/sim/aircraft"));

    var acpos = geo.aircraft_position();

    coord = geo.Coord.new(acpos);
    coord.dump();
};

