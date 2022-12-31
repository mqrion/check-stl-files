# check-stl-files
checking stl-files

# Example

  DATA_PATH           = "/very/nice/path/";\
  IMAGE_PATH          = "/path/for/images/";\
  DATASET_NAME        = "a nice name";\
  THRESHOLD_FOR_REFL  = 2;\
  INTERACTIONS        = 1;


reflectionCountingMatrix = filterFolderRefl(DATA_PATH,IMAGE_PATH,DATASET_NAME,THRESHOLD_FOR_REFL,INTERACTIONS);
