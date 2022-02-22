function [cmA, cmB] = createConfusionMatrixCase1(trueA, falseAasB, trueB, falseBasA)
    cmA = [trueA, falseAasB; falseBasA, trueB];
    cmB = [trueB, falseBasA; falseAasB, trueA];
end