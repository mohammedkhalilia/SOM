function frame = umatrixFrame(umat)   
    filename = 'output/tempumat.jpg';
    h = figure('visible','off');
    imagesc(umat);
    saveas(h,filename,'jpg');
    A = imread(filename);
    frame = im2frame(A);
end