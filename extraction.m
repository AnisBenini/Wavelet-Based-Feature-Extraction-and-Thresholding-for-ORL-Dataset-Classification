% Initialisation
orl_path = 'C:\Users\DELL\Desktop\Study\Bio Sec\ORL Database'; % Remplacez par le chemin vers votre dossier ORL
train_path = 'Train';
test_path = 'Test';

% Créer les dossiers Train et Test
if ~exist(train_path, 'dir')
    mkdir(train_path);
end
if ~exist(test_path, 'dir')
    mkdir(test_path);
end

% Paramètres de la transformée en ondelettes
wavelet = 'coif1'; % Utilisation de la Coiflet 1
level = 3; % Niveau de décomposition

% Initialisation des matrices
Mattrain = [];
Mattest = [];

% Parcours des sujets
for subject = 1:40 % Il y a 40 sujets dans la base de données ORL
    subject_folder = fullfile(orl_path, sprintf('s%d', subject));
    images = dir(fullfile(subject_folder, '*.pgm')); % Modifier l'extension si nécessaire

    % Vecteurs pour le sujet courant
    train_vectors = [];
    test_vectors = [];

    for i = 1:10 % Chaque sujet a 10 images
        % Charger l'image
        img_path = fullfile(subject_folder, images(i).name);
        img = imread(img_path);

        % Conversion en niveau de gris si nécessaire
        if size(img, 3) == 3
            img = rgb2gray(img);
        end

        % Appliquer la transformée en ondelettes
        [c, ~] = wavedec2(img, level, wavelet);

        % Vecteur caractéristique
        feature_vector = c(:)'; % Linéariser les coefficients

        % Répartition Train/Test
        if i <= 5
            train_vectors = [train_vectors; feature_vector];
            % Sauvegarde dans Train
            save(fullfile(train_path, sprintf('s%d_img%d.mat', subject, i)), 'feature_vector');
        else
            test_vectors = [test_vectors; feature_vector];
            % Sauvegarde dans Test
            save(fullfile(test_path, sprintf('s%d_img%d.mat', subject, i)), 'feature_vector');
        end
    end

    % Ajouter aux matrices globales
    Mattrain = [Mattrain; train_vectors];
    Mattest = [Mattest; test_vectors];
end

% Sauvegarder les matrices
save('Mattrain.mat', 'Mattrain');
save('Mattest.mat', 'Mattest');

disp('Extraction terminée.');
