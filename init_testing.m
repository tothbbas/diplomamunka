% read objects
[Vbun,Fbun] = readObj("C:\Barnabas\ELTEIK\MScqdiplomamunka\bunny.obj");
[Vuc,Fuc] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\unicube.obj");
[Vs,Fs] = readObj("C:\Barnabas\ELTEIK\MSc\diplomamunka\sphere.obj");

% create Tutte embeddings
[VoutS,FoutS] = TutteEmbedding2(Vs,Fs,'u');
[VoutB,FoutB] = TutteEmbedding2(Vbun,Fbun,'u');
[VoutUC,FoutUC] = TutteEmbedding2(Vuc,Fuc,'u');

% make ons
Ebun = ons21(VoutB,FoutB);
Euc = ons21(VoutUC,FoutUC);
Es = ons21(VoutS,FoutS);

% random mesh
[Vr,Fr] = createRandomMesh(50);
Er = ons21(Vr,Fr);

% merge
[Vmerg,Fmerg] = mergeTriangulations(VoutS,FoutS,Vr,Fr);

