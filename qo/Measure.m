## -*- texinfo -*-
## @deftypefn{Function file} {} Measure(@var{state})
## Function @code{Measure} performs ortogonal measurment on state @var{state}. Function returns a probability distribution of results. 
## @example 
## @group
## Measure(State(Ket([1,0,1])))
##  @result{}
## 0  0
## 1  0
## 2  0
## 3  0
## 4  0
## 5  1
## 6  0
## 7  0
##
## @end group
## @end example
## @end deftypefn
## @seealso {Id, Not, H, Pase}
## 
## Author: Piotr Gawron, Jaroslaw Miszczak.
## Created: 12 December 2003.
## Last modyfication: 10 February 2004.

function ret = Measure(state, observables, str)
#TODO test if state is valid state and if observables are in form "XYZZYXI"

flag=-1; # 0 - return measured state vector (default); 1 - return structure

if(nargin==2)
	flag=0;
elseif(nargin==3)
	if(strcmp("vec",str))
		flag=0;
	elseif(strcmp("struct",str))
		flag=1;
	else
		usage("Measure(state, observables[, {\"vec\"|\"struct\"}])");
	endif
else
	usage("Measure(state, observables[, {\"vec\"|\"struct\"}])");
endif

chosestate=false; # true if we want to return state vector
if (flag==0) 
	chosestate=true;
else
	chosestate=false;
endif

lo = length(observables);

listobs = {};
for i=1:lo
	if (observables(i)=="X")
		listobs(i)=Observable(0.5*Sx);
	elseif (observables(i)=="Y")
		listobs(i)=Observable(0.5*Sy);
	elseif (observables(i)=="Z")
		listobs(i)=Observable(0.5*Sz);	
	elseif (observables(i)=="I")
		listobs(i)=Observable(Id);
	elseif
		error("Unexpected %s found, it should be {X,Y,Z,I}",observables(i));
	endif
endfor

random = rand();	# used during chosing of random output state
cumprob = 0; # cumulative probability

prob.out=0; 	# eigenvalue
prob.p=0;	# probability	

retstate = zeros(size(state)(2),1); # state we return
rettemp=1;

for j=0:2^lo-1 # for every possible projection
	projection=[1]; # projection operator obtained by spectral decomposition
	indexes = Dec2BinVec(2^lo - j - 1,lo)+1; # generation of all combinations of set {1,2}
	prob(j+1).out=zeros(1,lo);
	for i=1:lo
		projection = kron(projection,nth(listobs,i)(indexes(i)).proj);
		prob(j+1).out(i)=nth(listobs,i)(indexes(i)).l;
	endfor
	p = trace(state*projection); # compute probability 
	prob(j+1).p = p;
	cumprob+=p;
	if(chosestate && (cumprob>=random)) # so we are building state after measurment
		chosestate = false;
		listops={};
		for i=1:lo
			if (observables(i)=="X")
				listops(i)=Observable(0.5*Sx,"vec");
			elseif (observables(i)=="Y")
				listops(i)=Observable(0.5*Sy,"vec");
			elseif (observables(i)=="Z")
				listops(i)=Observable(0.5*Sz,"vec");	
			elseif (observables(i)=="I")
				listops(i)=Observable(Id,"vec");
			elseif
				error("Unexpected %s found, it should be {X,Y,Z,I}",observables(i));
			endif
		endfor
		for i=1:lo
			rettemp = kron(rettemp,nth(listops,i)(indexes(i)).vec);
		endfor
		retstate = rettemp;
	endif
endfor
if(flag==0)
	ret = retstate;
elseif(flag==1)
	ret = prob;
else
	error("Internal error - it should never happen!");
endif
endfunction