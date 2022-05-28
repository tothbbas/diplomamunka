tic

addpaths

init = true;
bunny = false;

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

if bunny  
    k = 200;
    MaxK = 1200;

    % bunny
    disp("Bunny")
    for i=k:200:MaxK
        % random mesh

        disp("Creating approximation, number of vertices:")   
        disp(i)

        [Vr,Fr] = createRandomMesh(i);
        Er = ons21(Vr,Fr);
        toc; tic;

        % merge
        disp("Merging Triangulations")
        [Vmerg,Fmerg] = mergeTriangulations(VoutB,FoutB,Vr,Fr,false);
        toc; tic;

        %approximation
        disp("Creating Approximation")
        approx2(Vmerg,Vr,VoutB,VoldB,Fmerg,Fr,Er,Ebun)
        toc; tic;
        pause()
        disp("----------------------------------------------------------------")
    end   
else
    k = 50;
    MaxK = 200;

    disp("Sphere")
    for i=k:30:MaxK
         disp("Creating approximation, number of vertices:")   
         disp(i)

         % random mesh
         disp("Generate Random Points");
         [Vr,Fr] = createRandomMesh(i);
         Er = ons21(Vr,Fr);
         toc; tic;

         % merge
         disp("Merging Triangulations");
         [Vmerg,Fmerg] = mergeTriangulations(VoutS,FoutS,Vr,Fr,false);
         toc; tic;
         
         %approximation
         disp("Creating Approximation")
         approx2(Vmerg,Vr,VoutS,VoldS,Fmerg,Fr,Er,Es)
         toc; tic;
         pause();
         disp("----------------------------------------------------------------")
    end    
end

