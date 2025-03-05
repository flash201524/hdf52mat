% 设置用户路径
userpath('E:\coding\hdf52mat\AVRI');  % 使用单引号，确保路径正确

% 假设 generator1ii.hdf5 文件在当前目录下，或使用完整路径
filename = 'generator1ii.hdf5';

train = {};
test = {};
% 循环读取文件内容
for i = 1:1200
    % 将数字i转换为字符串，然后拼接路径
    path1 = strcat('/', num2str(i), '/gen_B01/ii');
    path2 = strcat('/', num2str(i), '/gen_B01/ii');
    path3 = strcat('/', num2str(i), '/gen_B01/ii');
    
    % 读取数据
    data_1 = h5read('generator1ii.hdf5', path1);
    data_2 = h5read('generator2ii.hdf5', path2);
    data_3 = h5read('generator3ii.hdf5', path3);
    
    % 将数据放在一个cell数组里
    combined_data = [data_1, data_2, data_3].';
    
    % 将数据追加到train数组
    train{end+1} = combined_data;  % 每个train元素是一个cell数组，包含data_1, data_2, data_3
end

for i = 1201:1800
    % 将数字i转换为字符串，然后拼接路径
    path1 = strcat('/', num2str(i), '/gen_B01/ii');
    path2 = strcat('/', num2str(i), '/gen_B01/ii');
    path3 = strcat('/', num2str(i), '/gen_B01/ii');
    
    % 读取数据
    data_1 = h5read('generator1ii.hdf5', path1);
    data_2 = h5read('generator2ii.hdf5', path2);
    data_3 = h5read('generator3ii.hdf5', path3);
    
    % 将数据放在一个cell数组里
    combined_data = [data_1, data_2, data_3].';
    
    % 将数据追加到train数组
    test{end+1} = combined_data;  % 每个train元素是一个cell数组，包含data_1, data_2, data_3
end

labels = h5read('generator1ii.hdf5', '/labels/final');


mts.train = train;
mts.trainlabels = int32(labels(1:1200));
mts.test = test;
mts.testlabels = int32(labels(1201:1800));

mts.trainlabels(mts.trainlabels ~= 0) = 2;
mts.trainlabels(mts.trainlabels == 0) = 1;

mts.testlabels(mts.testlabels ~= 0) = 2;
mts.testlabels(mts.testlabels == 0) = 1;

