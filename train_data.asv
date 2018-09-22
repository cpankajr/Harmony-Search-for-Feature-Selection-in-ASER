clc
clear all
close all

classes = cell(0);
data.mfcc = cell(0);
data.label = cell(0);
data.name = cell(0);
traindata = cell(0);
trainset= double.empty;

emotions = {'Anger','Boredom','Disgust','Fear','Happiness','Sadness','Neutral'};


files = dir('C:\Users\PANKAJ\Documents\MATLAB\Emotion Recognition SVM\Emodb berlin\wav\*.wav');
for file = files'
    [speech, fs] = audioread(strcat('C:\Users\PANKAJ\Documents\MATLAB\Emotion Recognition SVM\Emodb berlin\wav\',file.name));
    mfcc=melcepst(speech,fs,'0dD');
    mfcc=(mfcc-min(mfcc(:,13)))/(max(mfcc(:,13))-min(mfcc(:,13)));
    Mean=mean(mfcc);
    stddiv=std(mfcc);
    Var=var(mfcc);
    k=kurtosis(mfcc);
    feature=[Mean,Var,k,stddiv];
    trainset=[trainset; feature,];
    data.name = [data.name;file.name];
    data.mfcc = [data.mfcc; feature];
    flipFileName=fliplr(file.name);
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
    data.label=[data.label; cellstr(emotion)];
    classes = [classes; cellstr(emotion)];
end
traindata=[data.name,data.mfcc,data.label];

svmParams=templateSVM('Standardize',1,'KernelFunction','linear','BoxConstraint', 0.08);
classificationModel = fitcecoc(trainset, classes,'Learners', svmParams, 'Coding', 'onevsall');
save('linear_emodb.mat','traindata','classificationModel','trainset','classes', 'emotions')



