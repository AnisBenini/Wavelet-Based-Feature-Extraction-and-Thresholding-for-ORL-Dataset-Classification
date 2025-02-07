# Wavelet-Based-Feature-Extraction-and-Thresholding-for-ORL-Dataset-Classification


This project contains MATLAB scripts to process the ORL (Olivetti Research Laboratory) database for image analysis and performance evaluation. The main steps involve data extraction, thresholding, and performance assessment.

## Prerequisites

To use this project, you will need:

- MATLAB .
- An ORL Database .


---

## Files in the Repository

### 1. `extraction.m`
This script extracts wavelet-based features using the **Coiflet wavelet** from the images in the ORL database.

#### Workflow:
- **Input**: Raw images from the ORL database.
- **Wavelet Feature Extraction**:
  - Each image is processed to extract feature vectors using the Coiflet wavelet.
- **Data Splitting**:
  - The first 5 feature vectors of each subject are saved into a folder named `Train`.
  - The last 5 feature vectors are saved into a folder named `Test`.
- **Output**:
  - Two matrices, `Mattrain` and `Mattest`, which aggregate all feature vectors from `Train` and `Test` folders respectively.

#### Example:
```matlab
extraction
```

### 2. `seuil.m`
This script calculates the threshold for classification by comparing intra-class and extra-class distances using the Euclidean distance.

#### Workflow:
- **Intra-Class Distance Calculation**:
  - Each test vector is compared to the 5 training vectors of its own class.
  - The Euclidean distances are computed and stored.
- **Extra-Class Distance Calculation**:
  - The first test vector of each class is compared to the first training vectors of all other classes.
  - The Euclidean distances are computed and stored.
- **Threshold Calculation**:
  - The threshold is computed using the formula:
    
    ```
    Seuil = (max(intra-class distances) + min(extra-class distances)) / 2;
    ```
- **Output**:
  - Saved intra-class distances, extra-class distances, and the computed threshold value.

#### Example:
```matlab
seuil
```

### 3. `performance.m`
This script evaluates the performance of the classification system using the **False Rejection Rate (FRR)** and **False Acceptance Rate (FAR)**.

#### Workflow:
- **Reusing Intra-Class and Extra-Class Tests**:
  - The same loops used in `seuil.m` are used to test classification performance.
- **Performance Metrics**:
  - **FRR (False Rejection Rate)**: The rate of incorrectly rejecting valid matches.
  - **FAR (False Acceptance Rate)**: The rate of incorrectly accepting invalid matches.
- **Output**:
  - Computed FRR and FAR values.

#### Example:
```matlab
performance
```

-------------------------------------------------------------------
### 4. `identification.m`
This script performs the identification phase by comparing feature vectors from the test set with those from the training set using the **Euclidean distance**.

#### Workflow:
- **Input**:
  - Feature vectors stored in `Train` and `Test` folders.
- **Identification Process**:
  - Each test vector is compared to all training vectors.
  - The Euclidean distance between the test vector and each training vector is computed.
  - The subject with the smallest distance is considered the predicted identity.
- **Performance Evaluation**:
  - The number of correctly identified subjects is counted.
  - The **Identification Rate (TID)** is calculated using the formula:
    
    ```
    TID = (Number of Correct Identifications / Total Number of Tests) * 100
    ```
- **Output**:
  - Displays the identification rate (TID) in the MATLAB command window.

#### Example:
```matlab
identification
```

-------------------------------------------------------------------
## Workflow Summary

1. **Prepare the ORL Database**: 
   - Download and extract the ORL database into your MATLAB working directory.
   - Ensure the images are organized into folders corresponding to individuals.

2. **Run `extraction.m`**:
   - Execute the script to process the images, extract Coiflet wavelet features, and save data into `Train` and `Test` folders.
   - Matrices `Mattrain` and `Mattest` will be created.

3. **Run `seuil.m`**:
   - Compute intra-class and extra-class distances, and calculate the threshold.
   - The distances and threshold will be saved for further use.

4. **Run `performance.m`**:
   - Calculate the FRR and FAR using the saved distances and threshold.
   - Output the performance metrics.

---

## Output Structure

After running the scripts, you will get the following folder structure:

```
|-- ORL Database
|   |-- Subject1
|   |   |-- 1.pgm
|   |   |-- 2.pgm
|   ...
|-- Train
|   |-- s1_img6.mat
|   |-- s1_img7.mat
|   ...
|-- Test
|   |-- s1_img6.mat
|   |-- s1_img7.mat
|   ...
|-- Distances
|   |-- intra_class_distances.mat
|   |-- extra_class_distances.mat

|-- Performance Metrics
    |-- performance_results.mat
```

## Notes

- Ensure the scripts are run in the specified order to avoid errors.
- If you encounter any issues, verify that the ORL database is correctly structured.
- For any customizations, edit the scripts as needed.

---

## Contact

For questions or issues, please reach out to [Anis BENINI ](mailto:AnisBENINI@proton.me).

---

Enjoy working with your ORL database!
