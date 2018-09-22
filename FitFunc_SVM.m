function [cv_accuracy]=FitFunc_SVM(trainSet,classes) 
svmParams=templateSVM('Standardize',1,'KernelFunction','linear','BoxConstraint', 0.08);
classificationModel= fitcecoc(trainSet, classes,'Learners', svmParams, 'Coding', 'onevsall');
cv_model=crossval(classificationModel);
cv_accuracy=1-kfoldLoss(cv_model, 'LossFun', 'ClassifError');
end