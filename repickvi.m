% 加载ResultsGenVi.mat文件
load('ResultsGenVi.mat');

% 定义变量
num_train_1 = 700;
num_test_1 = 175;
num_train_2 = 700;
num_test_2 = 175;

% 初始化mts2结构
mts2 = struct();
mts2.train = cell(1, num_train_1 + num_train_2);
mts2.trainlabels = int32(zeros(num_train_1 + num_train_2, 1));
mts2.test = cell(1, num_test_1 + num_test_2);
mts2.testlabels = int32(zeros(num_test_1 + num_test_2, 1));

% 筛选trainlabels为1的数据
idx1 = find(mts.trainlabels == 1);
if length(idx1) >= num_train_1 + num_test_1
    % 正确从mts.train中取数据
    mts2.train(1:num_train_1) = mts.train(idx1(1:num_train_1));
    mts2.test(1:num_test_1) = mts.train(idx1(num_train_1+1:num_train_1+num_test_1));
else
    error('标签1数据不足，无法分配足够的样本给train和test');
end

% 筛选trainlabels为2的数据
idx2 = find(mts.trainlabels == 2);
if length(idx2) >= num_train_2 + num_test_2
    % 正确从mts.train中取数据
    mts2.train(num_train_1+1:num_train_1+num_train_2) = mts.train(idx2(1:num_train_2));
    mts2.test(num_test_1+1:num_test_1+num_test_2) = mts.train(idx2(num_train_2+1:num_train_2+num_test_2));
else
    error('标签2数据不足，无法分配足够的样本给train和test');
end

% 赋值trainlabels和testlabels
mts2.trainlabels(1:num_train_1) = 1;
mts2.trainlabels(num_train_1+1:end) = 2;
mts2.testlabels(1:num_test_1) = 1;
mts2.testlabels(num_test_1+1:end) = 2;

% 保存新的mts2结构
save('ResultsGenVi2.mat', 'mts2');