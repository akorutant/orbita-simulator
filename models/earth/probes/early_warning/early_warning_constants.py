GM = 6.6742e-11 * 5.9726e24
R_z = 6371032.0

def normalize_angle(angle):
    """ -60 = 300 (if 0< => +360)"""
    normalized_angle = angle
    while normalized_angle < 0:
        normalized_angle += 360
    while normalized_angle >= 360:
        normalized_angle -= 360
    return normalized_angle


def normalize_angle_difference(angle_difference):
    """ -190 = 170 (if -180< => +360)"""
    normalized_angle_difference = angle_difference
    while normalized_angle_difference < -180:
        normalized_angle_difference += 360
    while normalized_angle_difference >= 180:
        normalized_angle_difference -= 360
    return normalized_angle_difference
