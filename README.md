# check-stl-files
this repository contains a MATLAB script that allows you to remove stl files from a folder that do not provide a good environment for ray tracing. stl, or standard triangle language, is a file format commonly used for 3d printing and computer-aided design. 

# prerequisites
   
   MATLAB R2022b :rose:

# example

  DATA_PATH           = "/very/nice/path/";\
  IMAGE_PATH          = "/path/for/images/";\
  DATASET_NAME        = "a nice name";\
  THRESHOLD_FOR_REFL  = 2;\
  INTERACTIONS        = 1;


reflectionCountingMatrix = filterFolderRefl(DATA_PATH,IMAGE_PATH,DATASET_NAME,THRESHOLD_FOR_REFL,INTERACTIONS);
