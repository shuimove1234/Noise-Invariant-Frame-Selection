function y=firstprune(path,fs,p,framesize,inc,perc)
%读入待处理的语音文件
[wavin_X,fs_X,nbits_X]=wavread(path);   %采用相对路径，读入语音文件的数据

%进行幅值归一化
wavin_X = wavin_X/max(wavin_X);

%归一化采样频率
wavin_X = normalize_Fs(wavin_X, fs_X, fs);

%选取稳定特征点
y = chose_steady_point(wavin_X, fs, p, framesize, inc,perc);
