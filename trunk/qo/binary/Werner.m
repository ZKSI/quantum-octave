## -*- texinfo -*-
## @deftypefn {Function file} {} Werner(@var{param},@var{dim})
## Function @code{Werner} returns density matrix for Werner state 
## in @code{dxd} Hilbert space with parameter @var{param}. 
## If second argument is ommited it returns Werner state for two qubits.
## 
## @example 
## @group
## Werner(.5)
##  @result{} 
##	0.37500 0.00000 0.00000 0.25000
##	0.00000 0.12500 0.00000 0.00000
##	0.00000 0.00000 0.12500 0.00000
##	0.25000 0.00000 0.00000 0.37500
## @end group
## @end example
##
## @end deftypefn
##
## @seealso {GHZ, W, Phip, PhiM, PsiP, PsiM, Id, Not}
##
## Author: Piotr Gawron, Jarosrlaw Miszczak
## Created: 26 March 2004

function ret = Werner(param, dim)
if ( nargin < 1 || nargin > 2 )
	usage ("Werner (param, [ dim ])")
endif

if ( nargin == 2 )
	warning ("Function not fully implemented!");
	warning ("Second argument will be ignored!");
endif

if ( !isscalar (param) ) 
	error ("First argument should be scalar!");
endif

#if ( param <= 1/3 || param > 1 )
#	warning ("First paramater should be > 1/3 and <=1, found param %d = ",  param);
#endif

# returned state for two qubits
ret = 0.25 * (1 - param) * [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] + param * [.5,0,0,.5;0,0,0,0;0,0,0,0;.5,0,0,.5];

endfunction