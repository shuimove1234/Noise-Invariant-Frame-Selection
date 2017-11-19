function y=threshold(x,percent)
%determine the threshold in NIFS
[rank_x,ind]=sort(x);
l1=size(x,1);
l2=size(x,2);
l=max(l1,l2);
ind=ceil(percent*l);
y=rank_x(ind);
