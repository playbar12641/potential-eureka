% com=strcat('oil baseline');
% base_oil=getmatfile(com);

%foldername='C:\Users\Admin\Desktop\2019CT\processedFiles\072019';
foldername='C:\Users\LX-Flex\Box Sync\CT result\2019CT\072019\processedFiles\072019';
filename1='/LX_oilBL_072119_01.mat';
ft=fullfile(foldername, filename1);
temp=load(ft);
fn=fieldnames(temp);
base_oil=temp.(fn{1});

HU_oil=-325; %baseline fluids
HU_N2=-953; %invading fluids

%foldername='C:\Users\Admin\Desktop\2019CT\processedFiles\072019';
foldername='C:\Users\LX-Flex\Box Sync\CT result\2019CT\072019\processedFiles\072019';
%filename2='/LX_MixFb_050718_12.mat';
filename2='/LX_gasInv_072119_06.mat';
%filename2='/LX_oilFb_071319_11';
til='S_o during gas invasion @ 32.3 min';
ft=fullfile(foldername, filename2);
temp=load(ft);
fn=fieldnames(temp);
expm=temp.(fn{1});

% com=strcat('measured experiment data');
% expm=getmatfile(com);

load porosity_072019.mat

[nl1,nl2,ns]=size(expm);
Sg=NaN([nl1,nl2,ns]);
Sg_overall=NaN([1,ns]); % the col number is the slice number
Sg_proj=NaN([nl1,ns]);
direc='col';

for i=1:ns  
    Sg(:,:,i)=(expm(:,:,i)-base_oil(:,:,i))/(HU_N2-HU_oil)./porosity(:,:,i);
    Sg_proj(:,i)=ave_calc(Sg(:,:,i),direc);
    Sg_overall(i)=mean(Sg_proj(:,i));
end

Sg_overall=transpose(Sg_overall); %easier to copy data
So_overall=1-Sg_overall;

Sg(Sg<0)=0;

n=15;
% figure
% surfaceplot(1-Sg,n,'S_o')
% figure
% surfaceplot(porosity,n,'porosity')
figure
surfaceplot(1-Sg_proj,n,til)
% figure
% sliceplot(1-Sg,'S_o');