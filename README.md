# check-stl-files
checking stl-files

# prerequisites
   
   MATLAB R2022b :rose:

# example

  DATA_PATH           = "/very/nice/path/";\
  IMAGE_PATH          = "/path/for/images/";\
  DATASET_NAME        = "a nice name";\
  THRESHOLD_FOR_REFL  = 2;\
  INTERACTIONS        = 1;


reflectionCountingMatrix = filterFolderRefl(DATA_PATH,IMAGE_PATH,DATASET_NAME,THRESHOLD_FOR_REFL,INTERACTIONS);
