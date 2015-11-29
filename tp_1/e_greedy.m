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

function [epsilon, action] = e_greedy (state, iter, iter_max, Q)

tau=(iter_max^2)/10;
epsilon= exp(-(iter^2/tau));
r=rand(1);


if(0<=r)&&(r<=epsilon)
  %Exploration: on choisit aleatoirement une action entre 1 et 4 avec une
  %probabilite epsilon
  action = randi(size(Q, 2));
elseif(epsilon<r)&&(r<=1)
  %Exploitation: on choisit l'action parmi toutes celles possible dont on 
  %estime qu'elle rapportera la meilleure récompense.
  [dummy, action] = max(Q(state,:));
end

end

