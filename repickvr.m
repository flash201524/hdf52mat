% 加载ResultsGenVi.mat文件
load('ResultsGenVr.mat');

% 定义变量
num_train_1 = 4000;
num_test_1 = 1000;
num_train_2 = 4000;
num_test_2 = 1000;


% 初始化mts2结构
mts2 = struct();
mts2.train = cell(1, num_train_1 + num_train_2);
mts2.trainlabels = int32(zeros(num_train_1 + num_train_2, 1));
mts2.test = cell(1, num_test_1 + num_test_2);
mts2.testlabels = int32(zeros(num_test_1 + num_test_2, 1));

% 筛选标签1的数据（遍历并剔除空单元）
idx1 = find(mts.trainlabels == 1);
if ~isempty(idx1)
    % 生成逻辑数组标记非空单元
    non_empty_mask = ~cellfun(@isempty, mts.train(idx1));
    % 更新idx1，仅保留非空索引
    idx1 = idx1(non_empty_mask);
    % 检查非空数据量是否足够
    if length(idx1) >= num_train_1 + num_test_1
        mts2.train(1:num_train_1) = mts.train(idx1(1:num_train_1));
        mts2.test(1:num_test_1) = mts.train(idx1(num_train_1+1:num_train_1+num_test_1));
    else
        error('标签1的非空数据不足，无法分配足够的样本');
    end
else
    error('标签1的索引为空');
end

% 筛选标签2的数据（同理）
idx2 = find(mts.trainlabels == 2);
if ~isempty(idx2)
    non_empty_mask = ~cellfun(@isempty, mts.train(idx2));
    idx2 = idx2(non_empty_mask);
    if length(idx2) >= num_train_2 + num_test_2
        mts2.train(num_train_1+1:end) = mts.train(idx2(1:num_train_2));
        mts2.test(num_test_1+1:end) = mts.train(idx2(num_train_2+1:num_train_2+num_test_2));
    else
        error('标签2的非空数据不足');
    end
else
    error('标签2的索引为空');
end

% 赋值trainlabels和testlabels
mts2.trainlabels(1:num_train_1) = 1;
mts2.trainlabels(num_train_1+1:end) = 2;
mts2.testlabels(1:num_test_1) = 1;
mts2.testlabels(num_test_1+1:end) = 2;

% 保存新的mts2结构
save('ResultsGenVr2.mat', 'mts2');