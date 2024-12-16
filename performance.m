% FRR_FAR.m
clc;
clear;

% Charger les distances intra-classes, extra-classes et le seuil
load('intra_class_distances.mat');
load('extra_class_distances.mat');
load('threshold.mat');

% Initialisation des variables
num_intra_class = length(intra_class_distances);
num_extra_class = length(extra_class_distances);

% Calcul du taux de faux rejet (FRR)
false_rejects = sum(intra_class_distances > threshold);
FRR = false_rejects / num_intra_class;

% Calcul du taux de fausse acceptation (FAR)
false_accepts = sum(extra_class_distances <= threshold);
FAR = false_accepts / num_extra_class;

% Affichage des résultats
disp(['FRR (False Rejection Rate) : ', num2str(FRR)]);
disp(['FAR (False Acceptance Rate) : ', num2str(FAR)]);

% Sauvegarder les résultats
save('FRR_FAR.mat', 'FRR', 'FAR');
