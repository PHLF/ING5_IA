## Copyright (C) 2015 Vince
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} go (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Vince <Vince@localhost.localdomain>
## Created: 2015-11-23

function [newstate reward] = go (state, action)
#Position possible quand on marche 2 3 4 5 8 9 13 14 
rew = [ 0,-1,0,-1;  # position 1 non-voulue, les actions 0 lui permettent de revenir dans une position normale
        -1,0,-1,0;  # position 2 on donne -1 quand le mouvement est impossible ou si il retourne en arrière.
        0,-1,-1,-1;  # //
        -1,-1,1,-1; # Position 4 intermédiaire,on donne une récompense à l'action qui le fait avancer 
        
        -1,0,-1,0;  # CF position 2
        0,-1,0,-1;  # CF position 1
        0,-1,0,-1;  # CF position 1
        -1,0,-1,-1;  # CF position 2
        
        -1,-1,0,-1;
        -1,-1,0,-1;
        -1,-1,-1,-1;  # Position 11, ne marche pas si g petit sinon 0,-1,0,-1;
        -1,0,-1,0;
        
        1,-1,-1,-1; # CF position 4
        -1,-1,-1,0; 
        -1,-1,-1,-1;  # CF position 11 sinon   -1,0,-1,0;
        -1,0,-1,0]; # CF position 1

trans = [ 2,4,5,13;
          1,3,6,14;
          4,2,7,15;
          3,1,8,16;#4
          
          6,8,1,9;
          5,7,2,10;
          8,6,3,11;
          7,5,4,12;#8
          
          10,12,13,5;          
          9,11,14,6;          
          12,10,15,7;
          11,9,16,8;#12
          
          14,16,9,1;
          13,15,10,2;                 
          16,14,11,3;     
          15,13,12,4];
          
newstate  = trans(state,action);
reward    = rew(state,action);

endfunction
