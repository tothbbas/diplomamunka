tic

init = false;

if init
    % read objects
    [Vbun,Fbun] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\bunny.obj");
    [Vuc,Fuc] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\unicube.obj");
    [Vs,Fs] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\sphere.obj");
    disp("Objects read")

    % create Tutte embeddings
    [VoutS,FoutS,VoldS] = TutteEmbedding2(Vs,Fs,'u');
    [VoutB,FoutB,VoldB] = TutteEmbedding2(Vbun,Fbun,'u');
    [VoutUC,FoutUC,VoldUC] = TutteEmbedding2(Vuc,Fuc,'u');
    disp("Embeddings created")

    % make ons
    Ebun = ons21(VoutB,FoutB);
    Euc = ons21(VoutUC,FoutUC);
    Es = ons21(VoutS,FoutS);
    disp("ON systems created")
end

k = 50;
MaxK = 200;

% disp("Sphere")
% sphere
% for i=k:10:MaxK
%
%     disp("Creating approximation, number of vertices:")   
%     disp(i)
%
%     % random mesh
%     [Vr,Fr] = createRandomMesh(i);
%     Er = ons21(Vr,Fr);
%     
%     % merge
%     [Vmerg,Fmerg] = mergeTriangulations(VoutS,FoutS,Vr,Fr,false);
%     
%     %approximation
%     approx2(Vmerg,Vr,VoutS,VoldS,Fmerg,Fr,Er,Es)
% end

k = 500;
MaxK = 1600;

% bunny
disp("Bunny")
for i=k:100:MaxK
    % random mesh

    disp("Creating approximation, number of vertices:")   
    disp(i)
    
    [Vr,Fr] = createRandomMesh(i);
    Er = ons21(Vr,Fr);
    
    % merge
    [Vmerg,Fmerg] = mergeTriangulations(VoutB,FoutB,Vr,Fr,false);
    
    %approximation
    approx2(Vmerg,Vr,VoutB,VoldB,Fmerg,Fr,Er,Ebun)
    pause()
end
