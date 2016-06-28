% Example script for GJK function
%   Animates two objects on a collision course and terminates animation
%   when they hit each other. Loads vertex and face data from
%   SampleShapeData.m. See the comments of GJK.m for more information
%
%   Most of this script just sets up the animation and transformations of
%   the shapes. The only key line is:
%   collisionFlag = GJK(S1Obj,S2Obj,iterationsAllowed)
%
%   Matthew Sheen, 2016
clc;clear all;close all

%How many iterations to allow for collision detection.
iterationsAllowed = 6;

% Make a figure
fig = figure;
hold on

% Load sample vertex and face data for two convex polyhedra
SampleShapeData;

% Make shape 1
S1.Vertices = V1;
S1.Faces = F1;
S1.FaceVertexCData = jet(size(V1,1));
S1.FaceColor = 'interp';
S1Obj = patch(S1);

% Make shape 2
S2.Vertices = V2;
S2.Faces = F2;
S2.FaceVertexCData = jet(size(V2,1));
S2.FaceColor = 'interp';
S2Obj = patch(S2);

hold off
axis equal
axis([-5 5 -5 5 -5 5])
fig.Children.Visible = 'off'; % Turn off the axis for more pleasant viewing.
rotate3d on;

%Move them through space arbitrarily.
S1Coords = S1Obj.Vertices;
S2Coords = S2Obj.Vertices;

S1Rot = eye(3,3); % Accumulate angle changes

% Make a random rotation matix to rotate shape 1 by every step
S1Angs = 0.1*rand(3,1); % Euler angles
sang1 = sin(S1Angs);
cang1 = cos(S1Angs);
cx = cang1(1); cy = cang1(2); cz = cang1(3);
sx = sang1(1); sy = sang1(2);  sz = sang1(3);

S1RotDiff = ...
    [          cy*cz,          cy*sz,            -sy
    sy*sx*cz-sz*cx, sy*sx*sz+cz*cx,          cy*sx
    sy*cx*cz+sz*sx, sy*cx*sz-cz*sx,          cy*cx];

S2Rot = eye(3,3);

% Make a random rotation matix to rotate shape 2 by every step
S2Angs = 0.1*rand(3,1); % Euler angles
sang2 = sin(S2Angs);
cang2 = cos(S2Angs);
cx = cang2(1); cy = cang2(2); cz = cang2(3);
sx = sang2(1); sy = sang2(2); sz = sang2(3);

S2RotDiff = ...
    [          cy*cz,          cy*sz,            -sy
    sy*sx*cz-sz*cx, sy*sx*sz+cz*cx,          cy*sx
    sy*cx*cz+sz*sx, sy*cx*sz-cz*sx,          cy*cx];


% Animation loop. Terminates on collision.
for i = 3:-0.01:0.2;
    S1Rot = S1RotDiff*S1Rot;
    S2Rot = S2RotDiff*S2Rot;
    
    S1Obj.Vertices = (S1Rot*S1Coords')' + i;
    S2Obj.Vertices = (S2Rot*S2Coords')' + -i;
    
    % Do collision detection
    collisionFlag = GJK(S1Obj,S2Obj,iterationsAllowed);
    
    drawnow;
    
    if collisionFlag
        t = text(3,3,3,'Collision!','FontSize',30);
        break;
    end
end
