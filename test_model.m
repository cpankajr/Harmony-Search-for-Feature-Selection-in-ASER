clc
close all
load('linear_emodb.mat'); %loading model 
%no need of next line if you are testing model without Harmony search (Feature selection)
load('hs_156_linear_c_0.08.mat');% this mat file contains data of selected feature after harmony search
classes = cell(0);
data.classify = cell(0);
data.label = cell(0);
data.name = cell(0);
testdata = cell(0);
testdata= double.empty;

emotions = {'Anger','Boredom','Disgust','Fear','Happiness','Sadness','Neutral'};


files = dir('C:\Users\PANKAJ\Documents\MATLAB\Emotion Recognition SVM\Emodb berlin\test\*.wav');
for file = files'
    [speech, fs] = audioread(strcat('C:\Users\PANKAJ\Documents\MATLAB\Emotion Recognition SVM\Emodb berlin\test\',file.name));
    mfcc=melcepst(speech,fs,'0dD');
    Mean=mean(mfcc);
    stddiv=std(mfcc);
    Var=var(mfcc);
    k=kurtosis(mfcc);

    feature=[Mean,Var,k,stddiv];
    flipFileName=fliplr(file.name);
    data.name = [data.name;file.name];
    emotion = flipFileName(6);   %2nd last character of file exluding extension name wav
    switch emotion
        case 'W'
            emotion='Anger';
        case 'L'
            emotion='Boredom';
        case 'E'
            emotion='Disgust';
        case 'A'
            emotion='Fear';
        case 'F'
            emotion='Happiness';
        case 'T'
            emotion='Sadness';
        case 'N'
            emotion='Neutral';
        otherwise
    end
    % make next two lines comment in order to classify without Harmony search
    featureNo=find(ans.Position==1);  
    feature=feature(:,featureNo);% select feature according to harmony search
    data.label=[data.label; cellstr(emotion)];
    [labels, score] = predict(classificationModel, feature);
    data.classify = [data.classify; cellstr(labels{1})];
    testdata=[data.name,data.label,data.classify];
    
    fprintf('Sound File %s Classifying as %s with truth value %s\n ',file.name, labels{1},emotion);
    
end
save('testLinear.mat','testdata')