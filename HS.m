
function [BestSol,BestCost]=HS(featureData,classes,PAR,HMS, HMCR,MaxIt,nVar)
VarSize=[1 nVar];   % Decision Variables Matrix Size

FitnessFcn = @(x,y) FitFunc_SVM(x,y);
% Create Initial Harmonies
% Empty Harmony Structure
empty_harmony.Position=[];
empty_harmony.Cost=[];

% Initialize Harmony Memory
HM=repmat(empty_harmony,HMS,1);
for i=1:HMS
    HM(i).Position = randi([0 1], VarSize);
    featureNo=find(HM(i).Position==1);
    HM(i).featureSet = featureData(:,featureNo);
    HM(i).Cost=FitnessFcn(HM(i).featureSet,classes);
    
end
disp('1');
% Sort Harmony Memory
[~, SortOrder]=sort([HM.Cost]);
HM=HM(SortOrder);
disp('2');
% Update Best Solution Ever Found
BestSol=HM(1);
nNew=1;
for it=1:MaxIt
    
    % Initialize Array for New Harmonies
    NEW=repmat(empty_harmony,nVar,1);
    
    % Create New Harmonies
    for k=1:nNew
        
        % Create 6New Harmony Position
        NEW(k).Position=randi([0 1], VarSize);
        for j=1:nVar
            if rand<=HMCR
                % Use Harmony Memory( Feature subset)
                r=randi([1 HMS]);
                NEW(k).Position(j)=HM(r).Position(j);
                
            end
            
            % Pitch Adjustment (flip bit )
            if rand<=PAR
                %                 DELTA=BW*randn();
                NEW(k).Position(j)=1-NEW(k).Position(j);
            end
            
        end

        % Evaluation
        featureNo=find(NEW(k).Position==1);
        NEW(k).featureSet = featureData(:,featureNo);
        NEW(k).Cost=FitnessFcn(NEW(k).featureSet,classes);
        
        
    end
    
    % Merge Harmony Memory and New Harmonies
    HM=[HM
        NEW]; %#ok
    
    % Sort Harmony Memory
    [~, SortOrder]=sort([HM.Cost],'descend');
    HM=HM(SortOrder);
    
    % Truncate Extra Harmonies
    HM=HM(1:HMS);
    
    % Update Best Solution Ever Found
    BestSol=HM(1);
    BS(it,:)=BestSol.Position;
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    
end
end



function [cv_accuracy]=FitFunc_SVM(trainSet,classes)
svmParams=templateSVM('Standardize',1,'KernelFunction','linear','BoxConstraint', 0.08);
classificationModel= fitcecoc(trainSet, classes,'Learners', svmParams, 'Coding', 'onevsall');
cv_model=crossval(classificationModel);
cv_accuracy=1-kfoldLoss(cv_model, 'LossFun', 'ClassifError');
end


