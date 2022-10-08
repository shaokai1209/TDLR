function B=Construct_B(Y)
%%
[x1,y1]=size(Y);
B_origin=Y;
for i=1:x1
    for j=1:y1
      if Y(i,j)==0
        B_origin(i,j)=-1; 
      end
    end
end
B=B_origin;