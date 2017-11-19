function Fea = NIFS(path, fs, p, framesize, inc, epsilon)
%this function is to noise invariant frame selection (NIFS) 
%Paper: NOISE INVARIANT FRAME SELECTION: A SIMPLE METHOD TO ADDRESS THE
%       BACKGROUND NOISE PROBLEM FOR TEXT-INDEPENDENT SPEAKER VERIFICATION
%--OUTPUT--
%--Fea: Dimension of feature * Frames
%--INPUT--
%--path: the path of the speech sample
%--fs: sampling frequency
%--p: the number of Mel filterbank
%--framsize: the framesize of the speech sample
%--inc: the overlap window length 
%--epsilon: the threshold used in NIFS

%load the speech sample
[wavin_X, fs_X] = audioread(path);  

wavin_X = wavin_X/max(wavin_X);

%normalize the sampling frequency, the frequency is noramilized as 8kHz in
%the paper
wavin_X = normalize_Fs(wavin_X, fs_X, fs);

%speech activity detection
VS      = vadsohn(wavin_X, fs_X);
wavin_X = wavin_X((VS==1));

%choose the noise invariant frames
fea = choose_noise_invariant_frame(wavin_X, fs, p, framesize, inc, epsilon);
fea = fea';
% cmvn, performs cepstral mean and variance normalization over a sliding window
Fea = wcmvn(fea, 301, true);
