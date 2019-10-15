% plto all reads alphabetically
% possible to add transparent image layer
% Xiaoyan, 2017


decoded_file = 'SpotCoordinates.csv';
image = 'anchor_image.tif';
scale = 1;

%%
% load and remove NNNN
[name, pos] = getinsitudata(decoded_file, 1);
[name, pos] = removereads(name, 'NNNN', pos);
pos = pos - 1.5;

figure;
plotall(name, pos, image, scale);

iss_change_gene_symbols
% set(gca, 'ydir', 'normal');

add_scalebar(.33, 20, [2000 3520]);
% add_scalebar(0.33*4, 500, [7500, 75]);
