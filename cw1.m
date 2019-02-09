%% Irrevelant Points outside window

office = load('data/office1.mat');
office = office.pcl_train;

%% Uncomment to load the test file
% office = load('office2.mat');
% office = office.pcl_test;
%%
close all;
for i = 20:length(office) % Reading the 40 point-clouds

i
rgb = office{i}.Color; % Extracting the colour data
point = office{i}.Location; % Extracting the xyz data
pc = pointCloud(point, 'Color', rgb); % Creating a point-cloud variable

%% Thresholding
ori_loc = pc.Location;
ori_color= pc.Color;
z_loc = ori_loc(:,3);
% indx_xyz_no = find(z_loc>3.5 );
indx_xyz_no = find(z_loc>3.5 | isnan(z_loc));
%indx_xyz_yes = find(z_loc<=3.5);

xyz_pc_1 = ori_loc;
color_pc_1 = ori_color;
%xyz_pc(indx_xyz_no,:) = [];
color_pc_1(indx_xyz_no,:) = 0;
%color_pc(indx_xyz_yes,:) = 255;

% Creating a new point-cloud
new_pc_1 = pointCloud(xyz_pc_1, 'Color', color_pc_1);

%t1_mask = imag2d(new_pc_1.Color);
%t1_mask_bin = t1_mask(:,:,1);
%t1_mask_bin(t1_mask_bin~=0)=255;
bin = color_pc_1~=0;
t1_mask_bin = reshape(bin(:,1), [640, 480]);
new_pc = new_pc_1;
% NEW_PC_1 , t1_mask_bin 

%% Task 2
if i==27
    close all;
    obs_mask = ones(640,480);
    obs_mask(83:322,1:480,:)=0;

    t2_mask_bin = bsxfun(@times, t1_mask_bin, cast(obs_mask, 'like', t1_mask_bin));
    indx_xyz_no = find(t2_mask_bin==0);
    color_pc_2 = ori_color;
    xyz_pc_2 = ori_loc;
    color_pc_2(indx_xyz_no,:) = 0;
    %xyz_pc_2(indx_xyz_no,:) = [];
    new_pc_2 = pointCloud(xyz_pc_2, 'Color', color_pc_2);
    new_pc=new_pc_2;
end

%% Task 3

%bwareaopen(new_pc.Location, 50);


figure(1);
before_rgb = imag2d(pc.Color);
figure(2);
pcshow(pc);
figure(3);
pcshow(new_pc);
figure(4);
imag2d(new_pc.Color);
pause
end