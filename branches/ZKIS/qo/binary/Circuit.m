## -*- texinfo -*-
## @deftypefn {Function File} {} Circuit (@var{gate}, @dots{})
## Author: Piotr Gawron, Jaroslaw Miszczak
## Created: 05 April 2004

function ret = Circuit(varargin)

if (nargin==0)
	usage("Circuit(gate[, gate])");
endif

ret = eye(size(varargin{1}));
	
	for i=1:nargin
		ret = ret * varargin{nargin+1 - i};
	endfor
endfunction