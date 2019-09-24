
com=strcat('air baseline');
base_air=getmatfile(com);
HU_air=-1000;

com=strcat('oil baseline');
base_oil=getmatfile(com);
HU_oil=-325;
%nC7=-327
%mix -274
diff=HU_oil-HU_air;

[nl1,nl2,ns]=size(base_air);
porosity=zeros([nl1,nl2,ns]);

for i=1:ns    
    porosity(:,:,i)=(base_oil(:,:,i)-base_air(:,:,i))/(diff);
end

save('porosity.mat','porosity')

figure
surfaceplot(porosity,4,'porosity');
