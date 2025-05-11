% 加载两个.mat文件
data1 = load('ResultsGenVi.mat');
data2 = load('ResultsGenVi2.mat');

mts1 = data1.mts;
mts2 = data2.mts;

% 获取两个文件中 train/test 的最小长度，防止越界
numTrain = min(length(mts1.train), length(mts2.train));
numTest = min(length(mts1.test), length(mts2.test));

% 初始化新的结构
Combined.train = cell(1, numTrain);
Combined.test = cell(1, numTest);
Combined.trainlabels = mts1.trainlabels;
Combined.testlabels = mts1.testlabels;

% 合并 train（按行合并）
for i = 1:numTrain
    Combined.train{i} = [mts1.train{i}; mts2.train{i}];
end

% 合并 test（按行合并）
for i = 1:numTest
    Combined.test{i} = [mts1.test{i}; mts2.test{i}];
end

mts = Combined;
% 保存结果
save('ResultsGenViCombined.mat', '-struct', 'mts');
