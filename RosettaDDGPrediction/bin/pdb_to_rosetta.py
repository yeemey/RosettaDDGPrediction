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
    mutate_to = {'G': ['D', 'E', 'S', 'R'], # D: 2g-a, E: 2g-a, S: 1g-a, R: 1g-a
                 'A': ['T', 'V'], # T: 1g-a, V: 2c-t
                 'V': ['A', 'I', 'M'], # A: 2t-c, I: 1g-a, M: 1g-a
                 'L': ['S', 'P', 'F'], # S: 2t-c, P: 2t-c, F: 1c-t
                 'I': ['M', 'T', 'V'], # M: 3a-g, T: 2t-c, V: 1a-g
                 'T': ['A', 'I', 'M'], # A: 1a-g, I: 2c-t, M: 2c-t
                 'S': ['N', 'G', 'F', 'L', 'P'], # N: 2g-a, G: 1a-g, F: 2c-t, L: 2c-t, P: 1t-c
                 'M': ['I', 'T', 'V'], # I: 3g-a, T: 2t-c, V: 1a-g
                 'C': ['Y', 'R'], # Y: 2g-a, R: 1t-c
                 'P': ['L', 'S'], # L: 2c-t, S: 1c-t
                 'F': ['L', 'S'], # L: 1t-c, S: 2t-c 
                 'Y': ['C', 'H'], # C: 2a-g, H: 1t-c
                 'W': ['R'], # R: 1t-c
                 'H': ['R', 'Y'], # R: 2a-g, Y: 1c-t
                 'K': ['R', 'E'], # R: 2a-g, E: 1a-g
                 'R': ['H', 'C', 'W', 'K', 'G'], # H: 2g-a, C: 1c-t, W: 1c-t, K: 2g-a, G: 1a-g
                 'D': ['G', 'N'], # G: 2a-g, N: 1g-a
                 'E': ['G', 'K'], # G: 2a-g, K: 1g-a
                 'N': ['S', 'D'], # S: 2a-g, D: 1a-g
                 'Q': ['R']} # R: 2a-g
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
