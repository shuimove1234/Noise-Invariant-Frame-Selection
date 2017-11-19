function [ori_fea, val_index] = choose_noise_invariant_frame(wavin_X, fs, p, framesize, inc, epsilon)
%--OUTPUT--
%--fea: Dimension of Frames*features
%--val_index: the frame index of the noise invariant frame
%--INPUT--
%--wavin_X: speech sample
%--fs:sampling frequency
%--p: the number of Mel filterbank
%--framsize: the framesize of the speech sample
%--inc: the overlap window length 
%--epsilon: the threshold used in NIFS

%set the signal-noise-ration (SNR)
SNR = 20;   
%set the noise path
NoisePath_1 =  '..\test noise file\babble.WAV';
NoisePath_2 =  '..\test noise file\white.WAV';
NoisePath_3 =  '..\test noise file\pink.WAV';

%add the noise to the speech sample
wavin_X_A = add_noisefile(wavin_X, NoisePath_1, SNR, fs);
wavin_X_B = add_noisefile(wavin_X, NoisePath_2, SNR, fs);
wavin_X_C = add_noisefile(wavin_X, NoisePath_3, SNR, fs);

%extact MFCC from original speech sample and noisy speech samples
ori_fea     = mfcc_extract(wavin_X,   fs, p, framesize,inc);
noisy_fea_A = mfcc_extract(wavin_X_A, fs, p, framesize,inc);
noisy_fea_B = mfcc_extract(wavin_X_B, fs, p, framesize,inc);
noisy_fea_C = mfcc_extract(wavin_X_C, fs, p, framesize,inc);

[num_frame,~] = size(ori_fea);
score_point = zeros(num_frame, 1);
total = zeros(num_frame,3);
 
for idx = 1:num_frame
    errorA = calcEuclideanDistance(noisy_fea_A(idx,:),ori_fea(idx,:));
    total(idx,1) = errorA;
    errorB = calcEuclideanDistance(noisy_fea_B(idx,:),ori_fea(idx,:));
    total(idx,2) = errorB;
    errorC = calcEuclideanDistance(noisy_fea_C(idx,:),ori_fea(idx,:));
    total(idx,3) = errorC;
end

sigmaA = threshold(total(:,1),epsilon/100);
sigmaB = threshold(total(:,2),epsilon/100);
sigmaC = threshold(total(:,3),epsilon/100);

%calculate the scores of each frame
for idx = 1:num_frame
   if total(idx,1) <= sigmaA
      score_point(idx) = score_point(idx)+1;
   end
   if total(idx,2) <= sigmaB
      score_point(idx) = score_point(idx)+1;
   end
    if total(idx,3) <= sigmaC
      score_point(idx) = score_point(idx)+1;
   end
end

val_index = score_point > 1;
ori_fea          = ori_fea(val_index, :);
