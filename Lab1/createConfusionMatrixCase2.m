function [cm1, cm2, cm3] = createConfusionMatrixCase2(true1, false1as2, false1as3, ...
                                                        true2, false2as1, false2as3, ...
                                                        true3, false3as1, false3as2)
    cm1 = [true1, false1as2, false1as3;
            false2as1, true2, false2as3;
            false3as1, false3as2, true3];
    cm2 = [true2, false2as1, false2as3; 
            false1as2, true1, false1as3;
            false3as2, false3as1, true3]; 
    cm3 = [true3, false3as1, false3as2;
            false1as3, true1, false1as2;
            false2as3, false2as1, true2];
end