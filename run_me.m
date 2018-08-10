% CSE 473/573 Programming Assignment 1, starter Matlab code
%% Credits: Arun Mallya and Svetlana Lazebnik

% path to the folder and subfolder
root_path = 'croppedyale/';
subject_name = 'yaleB01';

save_flag = 0; % whether to save output images

%% load images
full_path = sprintf('%s%s/', root_path, subject_name);
[ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, subject_name, 64);
image_size = size(ambient_image);

arr = zeros(192,168,64);
%arr1 = zeros(192,168,64);
%% preprocess the data: 

%% subtract ambient_image from each image in imarray
for j = 1 : 64
	arr(:,:,j)= minus(imarray(:,:,j),ambient_image(:,:)) ;
end

%% make sure no pixel is less than zero
for i = 1:64
    for j = 1:192
        for k = 1:168
            if (arr(j,k,i) < 0)
                arr(j,k,i) = 0;
            end
        end
    end
end

%% rescale values in imarray to be between 0 and 1
for i = 1:64
    for j = 1:192
        for k = 1:168
            arr(j,k,i)= arr(j,k,i)/255;
        end
    end
end
%% <<< fill in your preprocessing code here (if any) >>>

%% get albedo and surface normals (you need to fill in photometric_stereo)
[albedo_image, surface_normals] = photometric_stereo(arr, light_dirs);

%% reconstruct height map (you need to fill in get_surface for different integration methods)
height_map = get_surface(surface_normals, image_size);

%% display albedo and surface
display_output(albedo_image, height_map);

%% plot surface normal
plot_surface_normals(surface_normals);

%% save output (optional) -- note that negative values in the normal images will not save correctly!
if save_flag
    imwrite(albedo_image, sprintf('%s_albedo.jpg', subject_name), 'jpg');
    imwrite(surface_normals, sprintf('%s_normals_color.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,1), sprintf('%s_normals_x.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,2), sprintf('%s_normals_y.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,3), sprintf('%s_normals_z.jpg', subject_name), 'jpg');    
end

