
function [stimuli] = conj_fllc
subName=input('enter subject number');

% Varables 
numtrials = 82;
randomizer = randperm(82, numtrials);
name_randomizer = Shuffle(randi([1 15], numtrials, 1));
condition= Shuffle(randi([1 4], numtrials,1 ));
[ndata, text, alldata] = xlsread('stimuli.xlsx');
names = {'Linda', 'Albert', 'John', 'Rebecca', 'Seth', 'Jenny', 'Sean', 'Mary', 'Daniel', 'Scott', 'Sara', 'Tom', 'Marc', 'Anne', 'Susan'};

%Opening screeen 
Screen('Preferences', 'StrialipSyncTests',1);
[win screenRect]=Screen('OpenWindow',0,[300 300 300],[0 0 640 480]);
DrawFormattedText(win,'Welcome \n\n you will now see a series of short descriptions\n they describe an hypotetical (and always differnt) person\nshortly after, you will be astrialed to matriale a judgements:\nsay to wich of two categories the described person most probably  belongs belongs to.\nPress button G for the upper one, and button H for lower one\n\npress any key to continue','center','center');
Screen( win,'flip');
KbWait;
KbReleaseWait;
pause(.5);

%setting buttons 
button1=true;
while button1
  txt=('press the G button'); 
    DrawFormattedText(win,txt,'center','center');
    Screen(win,'flip');
    [secs, KeyCode] = KbWait;
    thisResp=KbName(KeyCode);
    KbReleaseWait;
    expression = 'g';
    replace ='0';
    myResp = str2num(regexprep(thisResp,expression,replace));
     if myResp==0
        button1=false;
     end
end
pause(.3)

button2=true;
while button2
txt=('press the H button'); 
DrawFormattedText(win,txt,'center','center');
Screen(win,'flip');
[secs, KeyCode] = KbWait;
thisResp=KbName(KeyCode);
KbReleaseWait;
expression = 'h';
replace ='0';
tryResp = str2num(regexprep(thisResp,expression,replace));
   if tryResp==0
    button2=false;
   end
end

text = 'The tastk will now start'; 
DrawFormattedText(win,text,'center','center');
Screen(win,'flip');
pause(.5);

for trial = 1:numtrials
    
    selected = randomizer(trial);
    name_selection = name_randomizer(trial); 
    stimuli(trial).names = names{name_selection};
    stimuli(trial).selected = selected;
    stimuli(trial).desc = alldata{selected,1};
    stimuli(trial).answer_a = alldata{selected,2};
    stimuli(trial).answer_ab = alldata{selected,3};
    
    
    text =[stimuli(trial).names, ' is ', stimuli(trial).desc ];
    DrawFormattedText(win,text,'center','center');
    Screen(win,'flip');
    pause(2);
    
    
button=true;    
while button
   if condition(trial) == 1|| condition(trial) == 2
        text = [stimuli(trial).answer_a,'\n\n\n\n\n',stimuli(trial).answer_ab];
        DrawFormattedText(win,text,'center','center');
        Screen(win,'flip');
        stimuli(trial).fllc = 'h';
    else
        text = [stimuli(trial).answer_ab,'\n\n\n\n\n',stimuli(trial).answer_a];
        DrawFormattedText(win,text,'center','center');
        Screen(win,'flip');
         stimuli(trial).fllc = 'g';
   end
[secs, KeyCode] = KbWait;
stimuli(trial).sbjresp = KbName(KeyCode);
stimuli(trial).time = secs;


push = KbReleaseWait;
   if push 
    button=false;
   end
end

    if stimuli(trial).fllc == stimuli(trial).sbjresp
       stimuli(trial).fllc = 1;
    else
       stimuli(trial).fllc = 0;
    end 
pause(.8)
end 

txt = ('Thankyou, the experiment is over!'); 
DrawFormattedText(win,txt,'center','center');
Screen(win,'flip');
pause(5.);
sca;

subName = num2str(subName);
save(['subj' subName] , 'stimuli');
end


% [ndata, text, alldata] = xlsread('cgf.xlsx');

% for k = 2:4
%     subj = ['subj', num2str(k),'.xlsx'];
%     [ndata, text, alldata] = xlsread(subj);
%     data = alldata';
% %    subj_file = writetable(data), ['subj', num2string(k),'.xlsx']);
%     save(['subj', (num2str(k))] , 'data');
% %         for i = 1:length(alldata)
% %         exp_data(k).sub = alldata{k,1};
% %         exp_data(k).answer_a = alldata{k,2};
% %         exp_data(k).answer_ab = alldata{k,3};  
% %         exp_data(k).desc = alldata{k,1};
% %         exp_data(k).answer_a = alldata{k,2};
% %         exp_data(k).answer_ab = alldata{k,3};
% %         end       
% end 
%   
% 
% 
% 
%  subj = ['subj2.xlsx'];
%  [ndata, text, alldata] = xlsread(subj);
%   data2 = alldata';
%     
%     
%     subj = ['subj3.xlsx'];
%     [ndata, text, alldata] = xlsread(subj);
%     data3 = alldata';
%     
%     
%      subj = ['subj4.xlsx'];
%     [ndata, text, alldata] = xlsread(subj);
%     data4 = alldata';
%     
%     
% final_data2(1,:) = data2(2,:);
%     for k = 1:length(data2(1,:))
%      if cell2mat(data2(6,(k+1))) == 1
%           final_data2(2,k) = data2(5,k);
%       else
%             final_data2(2,k) = data2(4,k);
%     end 
%     end
%     
%     final_data3(1,:) = data3(2,:);
%     for k = 1:length(data3(1,:))
%      if cell2mat(data3(6,(k+1))) == 1
%           final_data3(2,k) = data3(5,k);
%       else
%             final_data3(2,k) = data3(4,k);
%     end 
%     end
%     
%     final_data4(1,:) = data4(2,:);
%     for k = 1:length(data4(1,:))
%      if cell2mat(data4(6,(k+1))) == 1
%           final_data4(2,k) = data4(5,k);
%       else
%             final_data4(2,k) = data4(4,k);
%     end 
%     end
    
