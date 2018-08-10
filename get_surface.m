function  height_map = get_surface(surface_normals, image_size)
% surface_normals: h x w x 3 array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object of dimensions [h, w]



    
%% <<< fill in your code below >>> 
%Storing all the pixels in surface_normals(192*168*3) into three new arrays(x, y, z) of size 192*168. 
%while performing element wise division we have to have numerator and denominator of the same size.
%That is why I stored surfacenormals in a different array(2D).
for i = 1:192
    for j = 1:168
        x(i,j) = surface_normals(i,j,1);
        y(i,j) = surface_normals(i,j,2);
        z(i,j) = surface_normals(i,j,3);
    end
end
%dividing surface_normals(1) with surface_normals(3) to get p(Surface gradient)
%dividing surface_normals(2) with surface_normals(3) to get q(Surface gradient)
p = x./z;
q = y./z;
%creating an height_map array of size 192*168 and assigning each pixel to zero
height_map = zeros(192,168);
%First column in height map is found by using "height value = previous height value + corresponding q value"
for i = 1:192
    if i ~= 1
        height_map(i,1) = height_map(i-1,1) + q(i,1);
    end
end
%All the rows in height map is found by using "height value = previous height value + corresponding p value"
%The first column of each row is excluded as it is calculated in the previous section using q. 
for i = 1:192
    for j = 2:168
        height_map(i,j) = height_map(i,j-1) + p(i,j);
    end
end
%Return height_map.
end

