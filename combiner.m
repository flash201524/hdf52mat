% 加载两个MAT文件
data1 = load('ResultsGenVr1.mat');
data2 = load('ResultsGenVr2.mat');

% 提取mts结构
mts1 = data1.mts;
mts2 = data2.mts2;

% 合并train数据
mts.train = [mts1.train, mts2.train];

% 合并trainlabels数据
mts.trainlabels = int32([mts1.trainlabels; mts2.trainlabels]);

% 合并test数据
mts.test = [mts1.test, mts2.test];

% 合并testlabels数据
mts.testlabels = int32([mts1.testlabels; mts2.testlabels]);

% 保存合并后的结构
save('ResultsGenVrF.mat', 'mts');
