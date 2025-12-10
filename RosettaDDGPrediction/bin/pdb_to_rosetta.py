#!/usr/bin/env python3

import argparse
import sys
import pandas as pd
from biopandas.pdb import PandasPdb

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('pdb_path')
    parser.add_argument('chain')
    parser.add_argument('residues_list')
    parser.add_argument('mutations_list')
    return parser.parse_args()

def aa3to1(aa3):
    aa = {'GLY': 'G',
          'ALA': 'A',
          'VAL': 'V',
          'LEU': 'L',
          'ILE': 'I',
          'THR': 'T',
          'SER': 'S',
          'MET': 'M',
          'CYS': 'C',
          'PRO': 'P',
          'PHE': 'F',
          'TYR': 'Y',
          'TRP': 'W',
          'HIS': 'H',
          'LYS': 'K',
          'ARG': 'R',
          'ASP': 'D',
          'GLU': 'E',
          'ASN': 'N',
          'GLN': 'Q'}
    return aa[aa3]

def pdb_to_residues(pdb_path, chain, outfile, df=False):
    # Initialize a new PandasPdb object
    # and fetch the PDB file from rcsb.org
    ppdb = PandasPdb().read_pdb(pdb_path)
    atom_df = ppdb.df["ATOM"].loc[ppdb.df["ATOM"]['chain_id'] == chain, ['chain_id', 'residue_name', 'residue_number']].copy()
    atom_df.insert(loc=1, column='residue_code', value=atom_df['residue_name'].apply(aa3to1))
    atom_df.drop('residue_name', axis=1).drop_duplicates().to_csv(outfile, index=False, header=False, sep='.')
    if df == True:
        return atom_df
    else:
        return

def mutate(residue_code):
    # amino acids resulting from transitions
    mutate_to = {'G': ['D', 'E', 'S', 'R'],
                 'A': ['T', 'V'],
                 'V': ['A', 'I', 'M'],
                 'L': ['S', 'P', 'F'],
                 'I': ['M', 'T', 'V'],
                 'T': ['A', 'I', 'M'],
                 'S': ['N', 'G', 'F', 'L', 'P'],
                 'M': ['I', 'T', 'V'],
                 'C': ['Y', 'R'],
                 'P': ['L', 'S'],
                 'F': ['L', 'S'],
                 'Y': ['C', 'H'],
                 'W': ['R'],
                 'H': ['R', 'Y'],
                 'K': ['R', 'E'],
                 'R': ['H', 'N', 'C', 'W', 'K', 'G'],
                 'D': ['G', 'N'],
                 'E': ['G', 'K'],
                 'N': ['S', 'D'], 
                 'Q': ['R']}
    return mutate_to[residue_code]

def non_saturation_mutagenesis(residue_list, txtout):
    with open(txtout, 'w') as outfile:
        with open(residue_list, 'r') as infile:
            residues = infile.readlines()
            for res in residues:
                aa = res.split('.')[1]
                for mutated in mutate(aa):
                    outfile.write(res.strip() + '.' + mutated + '\n')
    return

def main():
    args = get_args()
    residues = pdb_to_residues(args.pdb_path, args.chain, args.residues_list)
    non_saturation_mutagenesis(args.residues_list, args.mutations_list)
    print(args.mutations_list, "ready.")
    return

if __name__ == '__main__':
    sys.exit(main())
