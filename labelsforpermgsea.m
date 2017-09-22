%labelsforpermgsea.m
constpcua=sprintf('25 2 1\n# PRE_UNST CTRL_UNST\n');
constprua=sprintf('20 2 1\n# PRE_UNST REM_UNST\n');
constpc6a=sprintf('25 2 1\n# PRE_IL6 CTRL_IL6\n');
constpr6a=sprintf('20 2 1\n# PRE_IL6 REM_IL6\n');
constpcga=sprintf('23 2 1\n# PRE_IFNG CTRL_IFNG\n');
constprga=sprintf('18 2 1\n# PRE_IFNG REM_IFNG\n');

constpcub=sprintf('25 2 1\n# CTRL_UNST PRE_UNST\n');
constprub=sprintf('20 2 1\n# REM_UNST PRE_UNST\n');
constpc6b=sprintf('25 2 1\n# CTRL_IL6 PRE_IL6\n');
constpr6b=sprintf('20 2 1\n# REM_IL6 PRE_IL6\n');
constpcgb=sprintf('23 2 1\n# CTRL_IFNG PRE_IFNG\n');
constprgb=sprintf('18 2 1\n# REM_IFNG PRE_IFNG\n');
for i=1:12
    prectrlunstim{i}='PRE_UNST ';
    prectrlil6{i}='PRE_IL6 ';
    preremunstim{i}='PRE_UNST ';
    preremil6{i}='PRE_IL6 ';
end
for i=1:10
    prectrlifng{i}='PRE_IFNG ';
    preremifng{i}='PRE_IFNG ';
end
for i=13:25
    prectrlunstim{i}='CTRL_UNST ';
    prectrlil6{i}='CTRL_IL6 ';
end
for i=11:23
    prectrlifng{i}='CTRL_IFNG ';
end
for i=11:18
    preremifng{i}='REM_IFNG ';
end

for i=13:20
    preremunstim{i}='REM_UNST ';
    preremil6{i}='REM_IL6 ';
end

permpcu=cell(1,1000);
permpc6=cell(1,1000);
permpcg=cell(1,1000);
permpru=cell(1,1000);
permpr6=cell(1,1000);
permprg=cell(1,1000);
for i=1:1000
    pcu=randperm(length(prectrlunstim(1,:)));
    permpcu{i}=prectrlunstim(:,pcu);
    pc6=randperm(length(prectrlil6(1,:)));
    permpc6{i}=prectrlil6(:,pc6);
    pcg=randperm(length(prectrlifng(1,:)));
    permpcg{i}=prectrlifng(:,pcg);
    pru=randperm(length(preremunstim(1,:)));
    permpru{i}=preremunstim(:,pru);
    pr6=randperm(length(preremil6(1,:)));
    permpr6{i}=preremil6(:,pr6);
    prg=randperm(length(preremifng(1,:)));
    permprg{i}=preremifng(:,prg);
    
     labpcu=permpcu{i}{1};
     labpc6=permpc6{i}{1};
     labpcg=permpcg{i}{1};
     labpru=permpru{i}{1};
     labpr6=permpr6{i}{1};
     labprg=permprg{i}{1};
     if strcmp(permpcu{i}{1},'PRE_UNST ')
         constpcu=constpcua;
     else
         constpcu=constpcub;
     end
     if strcmp(permpru{i}{1},'PRE_UNST ')
         constpru=constprua;
     else
         constpru=constprub;
     end
     if strcmp(permpc6{i}{1},'PRE_IL6 ')
         constpc6=constpc6a;
     else
         constpc6=constpc6b;
     end
     if strcmp(permpr6{i}{1},'PRE_IL6 ')
         constpr6=constpr6a;
     else
         constpr6=constpr6b;
     end
     if strcmp(permpcg{i}{1},'PRE_IFNG ')
         constpcg=constpcga;
     else
         constpcg=constpcgb;
     end
      if strcmp(permprg{i}{1},'PRE_IFNG ')
         constprg=constprga;
     else
         constprg=constprgb;
     end
    for j=2:25
        labpcu=[labpcu,permpcu{i}{j}];
        labpc6=[labpc6,permpc6{i}{j}];
    end
    for j=2:18
        labprg=[labprg,permprg{i}{j}];
    end
    for j=2:20
        labpru=[labpru,permpru{i}{j}];
        labpr6=[labpr6,permpr6{i}{j}];
    end
    for j=2:23
        labpcg=[labpcg,permpcg{i}{j}];
    end
permpcu{i}=[constpcu,labpcu];
permpc6{i}=[constpc6,labpc6];
permpcg{i}=[constpcg,labpcg];
permpru{i}=[constpru,labpru];
permpr6{i}=[constpr6,labpr6];
permprg{i}=[constprg,labprg];
    stringprectrlunstim=sprintf('prectrlunstim%d.cls',i);
    dlmwrite(stringprectrlunstim,permpcu{i},'delimiter','');
    stringprectrlil6=sprintf('prectrlil6%d.cls',i);
    dlmwrite(stringprectrlil6,permpc6{i},'delimiter','');
    stringprectrlifng=sprintf('prectrlifng%d.cls',i);
    dlmwrite(stringprectrlifng,permpcg{i},'delimiter','');
    
    stringpreremunstim=sprintf('preremunstim%d.cls',i);
    dlmwrite(stringpreremunstim,permpru{i},'delimiter','');
    stringpreremil6=sprintf('preremil6%d.cls',i);
    dlmwrite(stringpreremil6,permpr6{i},'delimiter','');
    stringpreremifng=sprintf('preremifng%d.cls',i);
    dlmwrite(stringpreremifng,permprg{i},'delimiter','');
end

 %dlmwrite('mylabels.cls',labels,'delimiter','');