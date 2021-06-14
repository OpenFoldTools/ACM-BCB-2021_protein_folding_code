# ACM-BCB-2021_protein_folding_code

A set of scripts using open source softwares that can convert an amino acid sequence into a folded 3D structure using simplistic simulated annealing molecular dynamics simulations and user-defined distance and torsion restraints. Mainly just a python wrapper script that calls AmberTools20 sander to run MD simulations.

### Pre-Reqs:
1. [Python3](https://www.python.org) <br/>
Required non-standard packages: MDAnalysis (version 1.0.0)

2. [AmberTools20](http://ambermd.org/GetAmber.php) <br/>

For a simple-to-install, non-parallelized version of AmberTools, you can use conda ([Miniconda](https://docs.conda.io/en/latest/miniconda.html)):
```bash
# Download miniconda if you don't already have installed.
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# Install miniconda; initialize the miniconda install within your shell during installation
bash Miniconda3-latest-Linux-x86_64.sh
# Add conda-forge to the channel list (it may already be present, but worth checking). 
conda config --add channels conda-forge
# Update to conda-forge versions of packages
conda update --yes --all
# Create a new conda environment named OpenFold-amber
conda create -n OpenFold-amber python==3.8
# Activate the OpenFold-amber environment
conda activate OpenFold-amber
# Install AmberTools20 within the environment
conda install -c conda-forge ambertools=20
# Install MDAnalysis 
conda install MDAnalysis
```

3. Clone or download this git repository to a single location. 

### To Run:
1. Prepare a FASTA/txt file with the amino acid sequence in single letter formatting. 
2. Prepare the 8 column distance restraints file (format below) and 5 column torsion restraints file (format below).
3. Copy the fold_protein.json from the git repository and edit with your parameters (explaination below).
4. Run fold_protein.py:

```bash
export OpenFoldHome=~/Apps/OpenFold-amber	# edit this line with the global location for this cloned git repository
python3 $OpenFoldHome/fold_protein.py fold_protein.json
```

### Input to the Program: fold_protein.json 
1. name: string; an identifier string used in naming of output directory and files, so you can really use any string you want. 
2. fasta_file_path: string; directory path that points to the FASTA file with the to-be folded sequence in single letter format (i.e., "NLYIQWLKDGGPSSGRPPPS").
3. distance_restraints_file_path: string; directory path that points to the distance restraints file in 8 column format.
4. torsion_restraints_file_path: string; directory path that points to the torsion restraints file in 5 column format.
6. simulated_annealing_input_file_path: string; directory path that points to the input file to perform basic the simulated annealing MD sims. with the user defined restraints. General users shouldn't need to change this parameter's value. 
7. tordef_file_path: string; directory path that points to the tordef.lib file needed for AmberTools' makeANG_RST script to work. Users shouldn't need to change this paramter's value. 
8. forcefield: string; file name associated with the leaprc file to be used in AmberTools' tleap to generate the linear 3D structure and respective parameters. Only tested with "leaprc.protein.ff14SB".
9. distance_force_constant: python float; the harmonic force constant applied to pairwise atom-atom distance restraints. Units: kcal/(mol·Angstrom)
10. torsion_force_constant: python float; the harmonic force constant applied to dihedral atom groups. Units: kcal/(mol·rad)
11. temperature: python float; the maximum temperatures for simulated annealing cycles. Units: K

