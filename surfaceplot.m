function surfaceplot(inp,i,prop)
c=numel(size(inp));
scale=6;
if c==3
Z=inp(:,:,i);
tstr=sprintf('slice#%i',i);
Z(Z<0)=nan;
scalex=scale*5.2/4.5;scaley=scale;
xlength=1.5*2.54;ylength=1.5*2.54;
else
Z=inp;
tstr=sprintf(' ');
Z(Z<0)=0;
scalex=scale/6*12;scaley=scale/6*1.5;
xlength=27.2;ylength=1.5*2.54;
end
%cmaxlim=max(max(Z));
tstr=[prop ' ' tstr];
sp=strfind(prop,' '); 
if numel(sp)==0
    s=length(prop);
else
    s=sp(1);
end
colorstr=[prop(1:s) ' (cm^3/cm^3)'];

[nl1,nl2]=size(Z);
[X,Y]=meshgrid(0:nl2-1,0:nl1-1);
X=X*xlength/(nl2-1);
Y=Y*ylength/(nl1-1);
% Sg=Z;So=1-Sg;
% So(So<1)=0;
%h=surf(X,Y,Z);

h=surf(X,Y,Z,'facecolor','interp','edgecolor','interp','linewidth',0.1,'meshstyle','row','EdgeLighting','gouraud','AlignVertexCenters','on');
xlabel({'core distance in x-direction (cm)'});
ylabel({'core distance in'; 'y-direction (cm)'});
xlim([min(min(X)) max(max(X))]);
ylim([min(min(Y)) max(max(Y))]);
colorbar3 = colorbar;
%colorbar3 = colorbar('YLim',[0 1]);
set(get(colorbar3,'Title'),'string',colorstr);

cm=max(max(Z));
if cm<0.55 
caxis('auto')
else
caxis([0.7 1]);
end

view(2)
colormap('jet'); %parula
title(tstr);
set(gcf, 'Position', [100, 100, 100*scalex, 100*scaley])
% grid off;
% box on;