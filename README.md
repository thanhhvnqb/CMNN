# 3D Human Pose Estimation Using Cascade of Multiple Neural Networks #

Code repository for paper "3D Human Pose Estimation Using Cascade of Multiple Neural Networks".
## Folders
### Zhou Code
The code repository for the convex approach of [Zhou et al.](https://fling.seas.upenn.edu/~xiaowz/dynamic/wordpress/shapeconvex/) [1]

### CMNN
The code repository for Cascade of Multiple Neural Networks (CMNN).

### CMNN/Data
Contains examples of training and evaluation data which come from Mocap Dataset [2]. You can download full data of all actions from: [Google drive](https://drive.google.com/file/d/1TTodlRDPhbVT7VPh47nSqsfriWB9Le25/view?usp=sharing)

### CMNN/models
Contains models to run CMNN

### CMNN/results
Contains examples results of CMNN. You can download results of all actions from: [Google drive](https://drive.google.com/file/d/1ykdT8eEQ3352VjSGmKTb4Vtj9k12X1Zf/view?usp=sharing)

## Requirements
Matlab with Neural Network Toolbox

## Experiments
### Training
1. Run file ``CMNN/learnBaseShapes.m`` to learn the Dictionary of 3D shape (shapeDictionary) for [1]
2. Run file ``CMNN/train_cascade2nn.m`` to train all neural networks of CMNN

### Evaluation
1. Run file ``CMNN/test_cascade2nn.m`` to test CMNN on evaluation dataset

### Plot 3D shape
1. Run file ``CMNN\plotshape.m`` to plot 2D and the output 3D shape in 3 different views.

## Citation
Please cite this paper in your publications if it helps your research:

    @ARTICLE{thanh2018tii3d, 
      author={V. Hoang and K. Jo}, 
      journal={IEEE Transactions on Industrial Informatics}, 
      title={3D Human Pose Estimation Using Cascade of Multiple Neural Networks}, 
      year={2018}, 
      volume={}, 
      number={}, 
      pages={1-1}, 
      doi={10.1109/TII.2018.2864824}, 
      ISSN={1551-3203}, 
      month={},
    }
    
    @inproceedings{thanh2017indin,
      author    = {Van{-}Thanh Hoang and Van{-}Dung Hoang and Kang{-}Hyun Jo},
      title     = {An improved method for 3D shape estimation using cascade of neural networks},
      booktitle = {Proceedings of the IEEE International Conference on Industrial Informatics},
      pages     = {285--289},
      year      = {2017},
    }


## References:
[1]: X. Zhou, M. Zhu, S. Leonardos, and K. Daniilidis, “Sparse representation for 3d shape estimation: A convex relaxation approach,” IEEE TPAMI, vol. 39, no. 8, pp. 1648–1661, 2017.

[2]: “Mocap: Carnegie mellon university human motion capture database,”
Available online at http://mocap.cs.cmu.edu/, 2017.

