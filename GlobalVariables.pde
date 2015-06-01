// "Static" Agent Variables
public PImage AGENT_IMAGE;
public int agent_count = 0;
public float PATH_RADIUS = 30;
public float TERMINAL_RADIUS = 5;

// "Static" Environment Variables
public int PLACE_PROB = 100;

// Steering Behaviour Variables

// WANDER
public float CIRCLE_DIST = 1;
public float CIRCLE_RAD = 5;
public float ANGLE_CHANGE = 0.2;

// AVOIDANCE
public float AVOIDANCE_AHEAD = 40;
public float AVOIDANCE_FORCE = 5;
public float OBSTACLE_RAD = 20;

public Vector obstacle = new Vector(24*10+12, 24*4+12);
