
-> source /usr/lib/OpenFOAM-1.6-ext/etc/bashrc

#
# "gmshToFoam" that is included in OpenFoam1.6-ext needs version 2.1 of ".msh" (NOT 2.2)
# Therefore OpenFoam1.6-ext needs meshes that are created by "gmsh" version 2.4 (NOT 2.5, NOT 2.6)
#
# You can find here the old versions of "gmsh":
#
# http://www.geuz.org/gmsh/bin/Linux/gmsh-2.4.2-Linux.tgz
#
# You can untar "gmsh" in /opt
#

1) Create the mesh that will be proceeded by OpenFoam

-> /opt/gmsh-2.4.2-Linux/bin/gmsh -3 vonKarman-circularObstacle.geo
-> gmshToFoam vonKarman-circularObstacle.msh
-> sed -i '/defaultFaces/{N;N;s/patch/empty/;}' constant/polyMesh/boundary


2a) Processing with Openfoam (4 cores)

-> decomposePar
-> mpirun -np 4 pimpleFoam -parallel | tee log &


2b) Processing with Openfoam (1 core)

-> mpirun pimpleFoam | tee log &


3) Post Processing

-> reconstructPar
-> paraFoam &

