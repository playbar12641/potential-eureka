function sliceplot(inp,prop)
S=inp;
S(S<0)=0;
[x,y,z]=size(S);
scale=6;%scale for image
scalex=scale*5.2/4.5;scaley=scalex;
scalez=scalex*11/1.5;
[X,Y,Z] = meshgrid(0:x-1,0:y-1,0:z-1);

xlength=1.5*2.54;
ylength=xlength;
zlength=27.2;

X=X*xlength/(x-1);
Y=Y*ylength/(y-1);
Z=Z*zlength/(z-1);

xslice=ceil(x/2)*xlength/(x-1);
yslice=ceil(y/2)*ylength/(y-1);
zslice=[];

colorstr=[prop ' (cm^3/cm^3)'];


h=slice(X,Y,Z,S,xslice,yslice,zslice);
set(h,'facecolor','interp','edgecolor','none','linewidth',0.1,'meshstyle','row','EdgeLighting','gouraud','AlignVertexCenters','on');
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
xlim([min(min(min(X))) max(max(max(X)))]);
ylim([min(min(min(Y))) max(max(max(Y)))]);
zlim([min(min(min(Z))) max(max(max(Z)))]);
colorbar3 = colorbar;
set(get(colorbar3,'Title'),'string',colorstr);

cm=max(max(max(Z)));
if cm<0.6 
caxis('auto')
else
%caxis([0.7 1]);
caxis('auto')
end

%view(3)
camup([0 1 0])
%view(25,90)
colormap('jet'); %parula
set(gcf, 'Position', [100, 100, 100*scalex, 100*scaley])
grid off







