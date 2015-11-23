%{ 
Copyright (C) 2015 Le Fur Pierre-Henri
 
 This program is free software; you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

 -*- texinfo -*- 
 @deftypefn {Function File} {@var{retval} =} e-greedy (@var{input1}, @var{input2})

 @seealso{}
 @end deftypefn

 Author: Le Fur Pierre-Henri <lpierre-henri@hpph>
 Created: 2015-11-23
 %}

function [action] = e_greedy (state, iter, iter_max, Q)


epsilon= 1-(iter/iter_max);
r=rand();
act = go(state,:)

if(0<=r)&&(r<=epsilon)
action = randi(act); %On choisit en fonction de l'état actuel parmi les états suivants possibles.
elseif(epsilon<r)&&(r<=1)
action = max(Q(state,action));
end

endfunction
