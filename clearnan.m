filename = 'generator1vi.hdf5';
dataset_path = '/labels/final';
new_filename = 'generator0.hdf5';

% 读取 HDF5 数据
if exist(filename, 'file')
    data = h5read(filename, dataset_path);
    
    % 删除 NaN 并保持原形状
    data = data(~isnan(data));
    if size(data, 1) < size(data, 2)  % 如果是行向量，转换为列向量
        data = data';
    end
    
    % 创建新 HDF5 文件并写入处理后的数据
    if exist(new_filename, 'file')
        delete(new_filename); % 确保新文件不存在
    end
    h5create(new_filename, dataset_path, size(data), 'Datatype', class(data));
    h5write(new_filename, dataset_path, data);
    
    fprintf('已处理并保存 %s\n', new_filename);
else
    error('文件 %s 不存在！', filename);
end
