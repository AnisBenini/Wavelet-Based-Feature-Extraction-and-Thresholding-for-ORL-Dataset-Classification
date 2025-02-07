% Chemins vers les fichiers Train et Test
train_path = "C:/Users/DELL/Desktop/TP/train/%d_%d.fp";
test_path =  "C:/Users/DELL/Desktop/TP/test/%d_%d.fp";

% Initialisation des variables
num_subjects = 40; % Nombre total de sujets
num_train_per_subject = 5; % Nombre d'images d'entraînement par sujet
num_test_per_subject = 5; % Nombre d'images de test par sujet
total_tests = num_subjects * num_test_per_subject;

correct_identifications = 0; % Compteur pour les identifications correctes

% Phase de test
for test_subject = 1:num_subjects
    for test_img_num = 6:10  % Images de test pour chaque sujet
        % Charger le vecteur de test
        test_file = sprintf(test_path, test_subject, test_img_num);
        test_vector = load(test_file);

        % Initialisation pour la recherche du meilleur match
        min_distance = inf;
        predicted_subject = -1;

        % Comparaison avec tous les vecteurs d'entraînement
        for train_subject = 1:num_subjects
            for train_img_num = 1:5  % Images d'entraînement
                % Charger le vecteur d'entraînement
                train_file = sprintf(train_path, train_subject, train_img_num);
                train_vector = load(train_file);

                % Calcul de la distance euclidienne
                distance = norm(test_vector - train_vector);

                % Vérifier si c'est la distance minimale
                if distance < min_distance
                    min_distance = distance;
                    predicted_subject = train_subject;
                end
            end
        end

        % Vérifier si l'identification est correcte
        if predicted_subject == test_subject
            correct_identifications = correct_identifications + 1;
        end
    end
end

% Calcul du TID (Taux d'Identification)
tid = (correct_identifications / total_tests) * 100;

% Affichage des résultats

fprintf("\n");
fprintf("=======================================\n");
fprintf("     Résultats d'Identification\n");
fprintf("=======================================\n");
fprintf(" Taux d'Identification (TID) : %.2f%%\n", tid);
fprintf("=======================================\n\n");

