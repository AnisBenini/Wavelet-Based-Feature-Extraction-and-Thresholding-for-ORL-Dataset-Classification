% Seuil.m
clc;
clear;

% Charger les matrices Mattrain et Mattest
load('Mattrain.mat');
load('Mattest.mat');

% Initialisation des distances
intra_class_distances = [];
extra_class_distances = [];

num_classes = 40; % Nombre total de classes
num_vectors_train = 5; % Nombre de vecteurs train par classe
num_vectors_test = 5; % Nombre de vecteurs test par classe

% Première boucle : tests intra-classe
for class_idx = 1:num_classes
    % Obtenir les vecteurs train et test de la classe courante
    train_vectors = Mattrain((class_idx-1)*num_vectors_train+1:class_idx*num_vectors_train, :);
    test_vectors = Mattest((class_idx-1)*num_vectors_test+1:class_idx*num_vectors_test, :);

    % Comparer chaque vecteur test aux vecteurs train de la même classe
    for test_idx = 1:num_vectors_test
        for train_idx = 1:num_vectors_train
            dist = norm(test_vectors(test_idx, :) - train_vectors(train_idx, :)); % Distance euclidienne
            intra_class_distances = [intra_class_distances; dist];
        end
    end
end

% Deuxième boucle : tests extra-classe
for class_idx = 1:num_classes
    % Obtenir le premier vecteur test de la classe courante
    test_vector = Mattest((class_idx-1)*num_vectors_test+1, :);

    % Comparer ce vecteur aux premiers vecteurs train des autres classes
    for other_class_idx = 1:num_classes
        if other_class_idx ~= class_idx
            train_vector = Mattrain((other_class_idx-1)*num_vectors_train+1, :);
            dist = norm(test_vector - train_vector); % Distance euclidienne
            extra_class_distances = [extra_class_distances; dist];
        end
    end
end

% Calculer le seuil
max_intra = max(intra_class_distances);
min_extra = min(extra_class_distances);
threshold = (max_intra + min_extra) / 2;

% Sauvegarder les résultats
save('intra_class_distances.mat', 'intra_class_distances');
save('extra_class_distances.mat', 'extra_class_distances');
save('threshold.mat', 'threshold');

disp(['Seuil calculé et sauvegardé : ', num2str(threshold)]);



