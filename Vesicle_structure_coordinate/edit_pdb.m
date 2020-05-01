% first vesicle_coord
% then vmd to convert xyz to pdb
% then this script


pdb=pdbread('vesicle_rad10_apl1.8.pdb');
len=(length({pdb.Model.Atom.X}))/3;
A=[1:len;1:len;1:len];
A=reshape(A,[len*3 1]);
A = num2cell(A);
[pdb.Model.Atom.resSeq] = A{:};
pdbwrite('vesicle_resid_renumbered_rad10_apl1.8.pdb',pdb);
