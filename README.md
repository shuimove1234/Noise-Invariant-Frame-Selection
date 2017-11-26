# Noise-Invariant-Frame-Selection
A simple method to address the background noise problem for text-independent speaker verification.
Paper: Noise Invariant Frame Selection: A simple method to address the background noise problem for text-independent speaker verification
This library can be used with the combination of MSR Identity Toolbox (avaivabel at: https://www.microsoft.com/en-us/download/details.aspx?id=52279&from=http%3A%2F%2Fresearch.microsoft.com%2Fen-us%2Fdownloads%2F2476c44a-1f63-4fe0-b805-8c2de395bb2c%2F) contains the following m files. 
NIFS.m: this function is to select the frames which are less insensitive to the additive noise. 
choose_noise_invariant_frame: this function is to be called in the NIFS function.
threshold.m: this function is to be called in the choose_noise_invariant_frame.
speaker_idx: this excel introduces the information about speakers used in the paper.
