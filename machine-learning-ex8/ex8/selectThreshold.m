function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions


    anomal = find(yval==1);%???index
    normal = find(yval==0);%???index
    asize = size(anomal,1);%?????
    nsize = size(normal,1);%?????
    p_ano = find(pval<epsilon);%????????   
    p_nor = find(pval>=epsilon);%????????
    tp = 0;
    tn = 0;
    for i=1:size(p_ano,1)
        if(yval(p_ano(i))==1)
            tp = tp+1;
        end;
    end;
     for i=1:size(p_nor,1)
        if(yval(p_nor(i))==0)
            tn = tn+1;
        end;
    end;
    fp = asize-tp;
    fn = nsize-tn;
    pre = tp/(tp+fp);
    rec = tp/(tp+fn);
    F1 = 2*(pre*rec)/(pre+rec);

    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
