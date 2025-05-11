% 设置用户路径
userpath('E:\coding\hdf52mat\SMIB');  % 使用单引号，确保路径正确

% 假设 generator1vi.hdf5 文件在当前目录下，或使用完整路径
filename = 'generator1vi.hdf5';

train = {};
test = {};
% 循环读取文件内容
for i = 1:9960
    % 将数字i转换为字符串，然后拼接路径
    path1 = strcat('/', num2str(i), '/gen01_1/vi');
    path2 = strcat('/', num2str(i), '/gen01_1/vi');
    
    
    % 读取数据
    data_1 = h5read('generator1vi.hdf5', path1);
    data_1 = data_1(1:1);
    data_2 = h5read('generator2vi.hdf5', path2);
    data_2 = data_2(1:1);
    
    
    % 将数据放在一个cell数组里
    combined_data = [data_1, data_2].';
    
    % 将数据追加到train数组
    train{end+1} = combined_data;  % 每个train元素是一个cell数组，包含data_1, data_2, data_3
end

for i = 1:1
    % 将数字i转换为字符串，然后拼接路径
    path1 = strcat('/', num2str(i), '/gen01_1/vi');
    path2 = strcat('/', num2str(i), '/gen01_1/vi');
    
    
    % 读取数据
    data_1 = h5read('generator1vi.hdf5', path1);
    data_1 = data_1(1:1);
    data_2 = h5read('generator2vi.hdf5', path2);
    data_2 = data_2(1:1);
    
    
    
    % 将数据放在一个cell数组里
    combined_data = [data_1, data_2].';
    
    % 将数据追加到train数组
    test{end+1} = combined_data;  % 每个train元素是一个cell数组，包含data_1, data_2, data_3
end

labels = h5read('generator1vi.hdf5', '/labels/init');
labels = rmmissing(labels);


mts.train = train;
mts.trainlabels = int32(labels(1:9960));
mts.test = test;
mts.testlabels = int32(labels(1:1));

mts.trainlabels(mts.trainlabels == 0) = 1;
mts.trainlabels(mts.trainlabels ~= 1) = 2;


mts.testlabels(mts.testlabels == 0) = 1;
mts.testlabels(mts.testlabels ~= 1) = 2;


