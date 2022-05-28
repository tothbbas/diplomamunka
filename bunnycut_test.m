addpaths
tic

[Vbun,Fbun] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\bunny.obj");

n1 = [-5.4; -1.14; 13.8];
n1 = n1/norm(n1);
p1 = [-5, 1.33, 2.627];
n = [0 0 1]';
K = 0.1;
p = [0,0,4];

display = false;
undersampling = false;

disp("Cutting Stanford Bunny")
[VcB,FcB,BcB] = CutMeshWithPlane(Vbun,Fbun,p1,n1,K);
VBU = cell2mat(VcB(1,1));
FBU = cell2mat(FcB(1,1));
toc; tic;

if display
   displayObj(VBU,FBU) ;
   pause();
end

disp("Embedding Stanford Bunny")
[VbU,FbU] = embedCuttedMesh(VBU,FBU,BcB,'u');
EbU = ons21(VbU,FbU);
toc; tic;

if display
   displayEmbedding(VbU,FbU) ;
   pause();
end

if undersampling
    [VuBun,FuBun] = UnderSample2DMesh(VbU,BcB,floor((length(VbU)-BcB)/2));
    Er = ons21(VuBun,FuBun);
    if display
        displayEmbedding(VuBun,FuBun);
        pause();
    end
    [Vmerg,Fmerg] = mergeTriangulations(VbU,FbU,Vr,Fr,false);
    if display
        displayEmbedding(Vmerg,Fmerg);
        pause();
    end
    approx2(Vmerg,VuBun,VbU,VBU,Fmerg,FuBun,Er,EbU);
else
    
    disp("Creating Random Mesh, and ONS from it");
    [Vr,Fr] = createRandomMesh(1600);
    Er = ons21(Vr,Fr);
    toc; tic;

    % merge
    disp("Merging Triangulations")
    [Vmerg,Fmerg] = mergeTriangulations(VbU,FbU,Vr,Fr,false);
    toc; tic;

    %approximation
    disp("Creating Approximation")
    approx2(Vmerg,Vr,VbU,VBU,Fmerg,Fr,Er,EbU);
    toc;
end
