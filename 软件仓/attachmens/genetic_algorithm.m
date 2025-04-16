% 遗传算法求解 f(x) = x^2 最大值 (x∈[0,31])
clear; clc;

% 参数设置
pop_size = 4;       % 种群大小
chrom_length = 5;   % 染色体长度（5位二进制）
max_gen = 10;       % 最大迭代次数
pc = 0.7;           % 交叉概率
pm = 0.01;          % 变异概率

% 初始化种群（随机生成4个5位二进制个体）
pop = randi([0 1], pop_size, chrom_length); 

for gen = 1:max_gen
    % 解码并计算适应度
    x = binary2decimal(pop);          % 二进制转十进制
    fitness = x.^2;                   % 适应度函数
    
    %% --- 选择步骤（轮盘赌）--- %%
    new_pop = zeros(size(pop));       % 初始化新种群
    for i = 1:pop_size
        % 轮盘赌选择：根据适应度概率随机选一个父代个体
        idx = roullette_wheel(fitness);  % 返回被选中的个体索引
        new_pop(i, :) = pop(idx, :);     % 将选中的个体加入新种群
    end
    % 例如：适应度高的个体4（784）可能被多次选中
    
    %% --- 交叉步骤（单点交叉）--- %%
    for i = 1:2:pop_size-1             % 两两配对（1-2, 3-4）
        if rand < pc                   % 以70%概率执行交叉
            cross_point = randi([1 chrom_length-1]);  % 随机选交叉点（如第3位）
            % 交换交叉点后的基因片段
            temp = new_pop(i, cross_point+1:end);
            new_pop(i, cross_point+1:end) = new_pop(i+1, cross_point+1:end);
            new_pop(i+1, cross_point+1:end) = temp;
        end
    end
    % 例如：父代 11100 和 10110 交叉后生成子代 11110 和 10100
    
    %% --- 变异步骤（位翻转）--- %%
    for i = 1:pop_size
        for j = 1:chrom_length
            if rand < pm               % 以1%概率执行变异
                new_pop(i, j) = ~new_pop(i, j);  % 二进制位翻转（0变1，1变0）
            end
        end
    end
    % 例如：10100 的第2位变异 → 11100
    
    % 更新种群
    pop = new_pop;
    
    % 输出当前最优解
    [best_fit, best_idx] = max(fitness);
    fprintf('Generation %d: x = %d, f(x) = %d\n', gen, x(best_idx), best_fit);
end

%% 辅助函数：二进制转十进制
function x = binary2decimal(pop)
    [~, n] = size(pop);
    x = sum(pop .* (2.^(n-1:-1:0)), 2);  % 按位加权求和
end

%% 辅助函数：轮盘赌选择
function idx = roullette_wheel(fitness)
    prob = fitness / sum(fitness);       % 计算每个个体的选择概率
    cum_prob = cumsum(prob);             % 计算累积概率（如 [0.1, 0.4, 0.9, 1.0]）
    idx = find(rand <= cum_prob, 1);     % 用rand随机数决定选中哪个个体
end