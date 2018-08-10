function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals


%% <<< fill in your code below >>>
%creating an g array of size 192*168*3 and assigning each pixel to zero
g = zeros(192,168,3);
%dividing each pixel in imarray with light directions.
for i = 1:192
    for j = 1:168
        g(i,j,:) = mldivide(light_dirs,reshape(imarray(i,j,:), size(imarray,3),1));
    end
end
%Calculating the absolute value of g to obtain the albedo image. 
%Creating a new array x such that its size is 3*1. 
for i = 1:192
    for j = 1:168
        h = 0;
        x(h+1,1) = g(i,j,1);
        x(h+2,1) = g(i,j,2);
        x(h+3,1) = g(i,j,3);
        albedo_image(i,j) = norm(x);
    end
end 
%Storing all the pixels in g(192*168*3) into three new arrays(f, o, p) of size 192*168. 
%This step is required as the norm function in matlab wont take 3
%dimentional array as input.
for i = 1:192
    for j = 1:168
        f(i,j) = g(i,j,1);
        o(i,j) = g(i,j,2);
        p(i,j) = g(i,j,3);
    end
end
%finding the surface normals by dividing each of the three arrays formed
%from g with albedo_image.
%The size of surface_normals is 192*168*3
for i = 1:192
    for j = 1:168
        surface_normals(i,j,1) = mldivide(albedo_image(i,j),f(i,j));
        surface_normals(i,j,2) =  mldivide(albedo_image(i,j),o(i,j));
        surface_normals(i,j,3) =  mldivide(albedo_image(i,j),p(i,j));
    end
end

%Returning albedo_image and surface_normals

end

