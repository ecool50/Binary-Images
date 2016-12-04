fid = fopen('FW0045_inputs.txt');
path = '/home/elijah/Desktop/CMPT-419-Project/HMRF-EM-image_v2.1/dataset_79/FW0045/';
tline = fgets(fid);
while ischar(tline)
    %temp = strcat('/home/elijah/Desktop/CMPT-419-Project/HMRF-EM-image_v2.1/dataset_79/FW0001/',tline);
    %disp(tline)
    %disp(temp)
    preprocess(path, tline);
    tline = fgets(fid);
end

fclose(fid);