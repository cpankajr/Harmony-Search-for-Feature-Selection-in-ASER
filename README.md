# Harmony Search for Feature Selection in ASER


Selecting significant features out of large dimensions of the original speech features is an integral part of accurate speech emotion recognition. In this project, we proposed an automatic speech emotion classification system based on a harmony search algorithm as a feature selection strategy.
First, an audio signal is divided into small frames of 20 ms and MFCC features are extracted from each frame to generate an original feature set.
We employed Harmony search to derive local feature subsets for each pair of emotions. Selected subsets and original sets evaluated based on 10 fold cross-validation accuracy.
Finally, each local feature subset is fed to corresponding one-against-all SVM classifier, and it is used to classify each emotional recording.
Experiments are conducted on the EMODB and IITKGP-SEHSC databases, demonstrating that size of each subset reduced to 50% of the size of original feature set, however, the accuracy remained almost same as original ones.

[Project Report](https://github.com/cpankajr/Harmony-Search-for-Feature-Selection-in-ASER/blob/master/Documents/Project%20report.pdf)

[Detailed Presentation](https://github.com/cpankajr/Harmony-Search-for-Feature-Selection-in-ASER/blob/master/Documents/Presentation.pptx)

**Note: All above codes are for EmoDB database , same codes can be used for other databses with some changes in code. 'fitceoc' function (used for multiclass classification) is only available after MATLAB 2016a.**

EmoDB 535 utterances (339 for training +196 for testing)
#

**SilenceRemoval.m** -> For removing silnce in uttrances because they do not contain any information
                    By using end point detection method

#
Following files used for extracting MFCC features from speech samples (taken from voicebox toolbox)


**enframe.m**	-> for framing of samples

**frq2mel.m**	-> coverts freq scale to mel freq scale

**mel2frq.m**	-> converts mel freq scale to freq scale

**rdct.m** -> for calcuclating DCT of data (it decorrelates the data)

**rfft.m** -> for calculating FFT of data

**melcepst.m**	-> main function which combines all functions to get MFCCs 

for further understanding of mfcc you can refer

[Spectrogram, Cepstrum and Mel-Frequency Analysis by Kishore Prahallad](https://github.com/cpankajr/Harmony-Search-for-Feature-Selection-in-ASER/blob/master/Documents/MFCC_%20explaination%20by%20Kishore%20Prahallad.pdf)

[Mel Frequency Cepstral Coefficient (MFCC) tutorial](http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/)
#
**train_data.m** -> extracts 39 mfcc features nd computes thier mean, std. deviation, variance and kurtosis to get 156 feature vector for each sample. It trains SVM model (one vs all) nd saves all these feature nd trained model in **_'linear_emodb.mat'_**	file
So rather than extracting features again you can directly use this file.

**test_model.m** -> this used for testing a model.

#
**HS.m** -> it is a function for Harmony search algorithm for Feature selection

**FitFunc_SVM.m** -> It is fitness function or objective function for harmony search to evaluate selected subsets and original sets


for getting optimum feature set you have to write following in MATLAB command window after loading **_'linear_emodb.mat'_**

```HS(trainset,classes,0.4,100, 0.9,100,156)```

Output of this will be structure variable **_'ans'_** which will contain information about optimum feature set

It takes lot of computation power so I have already provided output file in **_'hs_156_linear_c_0.08.mat'_** 

for further understanding of Harmony search algorithm you can refer

[Presentation (slide no. 36 - 67)](https://github.com/cpankajr/Harmony-Search-for-Feature-Selection-in-ASER/blob/master/Documents/Presentation.pptx)

[Feature Selection with Harmony Search
and its Applications
by Ren Diao](https://pdfs.semanticscholar.org/73a4/958ca38e4ed5970c22168e021fb9e4793d9e.pdf)



