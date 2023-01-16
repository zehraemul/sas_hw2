%ZEHRA BENGÜ EMÜL 20011002 2. ÖDEV MATLAB KODU

%DTMF SİSTEMİ FREKANS ARALIKLARI:
%satir frekanslari : 697hz,770hz,852hz,941hz;
%sutun frekanslari : 1209hz,1336hz,1477hz;

%oncelikle telefon numaramin DTMF sisteminde hangi frekanslara karslilik
%geldigini buluyorum: 
%telefon numaram=[05533693134], kullanacağim rakamlar={0,1,3,4,5,6,9}
%  0=(941hz,1336hz)
%  1=(697hz,1209hz)
%  3=(697hz,1477hz)
%  4=(770hz,1209hz)
%  5=(770hz,1336hz)
%  6=(770hz,1477hz)
%  9=(852hz,1477hz)

%DTMF'de satirlarin frekans degerlerini yukardan asagi değiskenlerde
%tutuyorum.
clc;
%SORU-1
fr1=697;
fr2=770;
fr3=852;
fr4=941;

%DTMF'de sutunlarin frekans degerlerini soldan saga degiskenlerde
%tutuyorum.

fc1=1209;
fc2=1336;
fc3=1477;

fs = 8000;
t = 0:1/fs:(200 * 10^(-3));
A = 0.2;

%kendi telefon numarama ait rakamlarin sinuzoidal toplamlarini
%hesapliyorum.
s0 = A*sin(2*pi*fr4*t) + A*sin(2*pi*fc2*t);
s5 = A*sin(2*pi*fr2*t) + A*sin(2*pi*fc2*t);
s3 = A*sin(2*pi*fr1*t) + A*sin(2*pi*fc3*t);
s6 = A*sin(2*pi*fr2*t) + A*sin(2*pi*fc3*t);
s9 = A*sin(2*pi*fr3*t) + A*sin(2*pi*fc3*t);
s1 = A*sin(2*pi*fr1*t) + A*sin(2*pi*fc1*t);
s4 = A*sin(2*pi*fr2*t) + A*sin(2*pi*fc1*t);
%ses dosyasina kaydetmek icin bos bir array olusturuyorum.
ses_array=[];
%ses dosyasini kaydederken aralarda bosluk birakmak icin y0 adinda bir
%degiskende bos sinyal urettim.
y0=sin(0*t);
ses_array=[ses_array,y0];
ses_array=[ses_array,s0];
ses_array=[ses_array,y0];
ses_array=[ses_array,s5];
ses_array=[ses_array,y0];
ses_array=[ses_array,s5];
ses_array=[ses_array,y0];
ses_array=[ses_array,s3];
ses_array=[ses_array,y0];
ses_array=[ses_array,s3];
ses_array=[ses_array,y0];
ses_array=[ses_array,s6];
ses_array=[ses_array,y0];
ses_array=[ses_array,s9];
ses_array=[ses_array,y0];
ses_array=[ses_array,s3];
ses_array=[ses_array,y0];
ses_array=[ses_array,s1];
ses_array=[ses_array,y0];
ses_array=[ses_array,s3];
ses_array=[ses_array,y0];
ses_array=[ses_array,s4];
%ses dosyasini yazdiriyorum.
audiowrite('mm.wav', ses_array, fs);

%T=100000/fs;
%x=1:T:100000*(length(y1)/fs);
%stem(x,y1);

%Y = fft(y1); 
%f = (-fs/2:fs/length(y1):fs/2-fs/length(y1))'; 
%stem(f, fftshift(Y)); 

%xlabel('Frequency (Hz)'); 
%ylabel('Amplitude');

%T=100000/fs;
%x=1:T:100000*(length(y1)/fs);
%stem(x,y1);

%SORU-2
%analiz icin olusturdugum ses dosyasini okuyorum.
[my_number, fs] = audioread('mm.wav');

n = 11;

d = floor(length(my_number)/n);

%f=fs*(0:(d/2))/d;


fprintf("benim numaram : ");
for i=1:n
    nmb = "null";
    ft = abs(fft(my_number(1+((i-1)*d):i*d),fs));
    x2=(ft(1:floor(length(ft)/2)+1));

    [a, b] = maxk(x2, 3);

    if((b(1) - b(2))<=5)
        a(1) = b(1);
        a(2) = b(3);
         if(b(3)>b(1))
            a(1) = b(3);
            a(2) = b(1);
         end
        
    else
         a(1) = b(1);
         a(2) = b(2);
         if(b(2)>b(1))
             a(1) = b(2);
             a(2) = b(1);
         end
    end
    if(abs(b(2) - b(1))<=5) 
         if(b(3)>b(1))
             a(1) = b(3);
             a(2) = b(1);
         end
    else
         if(b(2)>b(1))
             a(1) = b(2);
             a(2) = b(1);
         end
    end
    if((a(1)-fc1)<=5)
         if((a(2)-fr1)<=5)
             nmb = "1";
         elseif((a(2)-fr2)<=5)
             nmb = "4";
         elseif((a(2)-852)<=5)
             nmb = "7";
         end
    elseif((a(1)-fc2)<=5)
         if((a(2)-fr1)<=5)
             nmb = "2";
         elseif((a(2)-fr2)<=5)
             nmb = "5";
         elseif((a(2)-fr3)<=5)
             nmb = "8";
         elseif((a(2)-fr4)<=5)
             nmb = "0";
         end
    elseif((a(1)-fc3)<=5)
         if((a(2)-fr1)<=5)
             nmb = "3";
         elseif((a(2)-fr2)<=5)
             nmb = "6";
         elseif((a(2)-fr3)<=7)
             nmb = "9";
         end
   end
      if(nmb == "null")
      else
        fprintf("%s",nmb);
          figure
                nexttile
                plot(x2);
                title(nmb+" Tuşunun Grafiği");
                xlabel("frekans");
                ylabel("büyüklük");
            hold on
      end
     
end
    T = 100000/fs;
    x = 1:T:100000*(length(my_number)/fs);
    x = x/100000;
figure
    nexttile
    plot(x,my_number);
    title("benim numaramin grafigi:(plot)");
    xlabel('time');
    ylabel('amplitude');
hold on
figure
    nexttile
    stem(x,my_number);
    title("benim numaramin grafigi:(stem)");
    xlabel('time');
    ylabel('amplitude');
hold on
fprintf("\n");

[ex_number, fs] = audioread('Ornek.wav');
n = 11;
d = floor(length(ex_number)/n);
f=fs*(0:(d/2))/d;
fprintf("ornekteki numara :");
for i=1:n
    nmb = "null";
    ft = abs(fft(ex_number(1+((i-1)*d):i*d),fs));
    x2=(ft(1:floor(length(ft)/2)+1));

    [a, b] = maxk(x2, 3);

    if((b(1) - b(2))<=5)
        a(1) = b(1);
        a(2) = b(3);
         if(b(3)>b(1))
            a(1) = b(3);
            a(2) = b(1);
         end
        
    else
         a(1) = b(1);
         a(2) = b(2);
         if(b(2)>b(1))
             a(1) = b(2);
             a(2) = b(1);
         end
    end
    if(abs(b(2) - b(1))<=5) 
         if(b(3)>b(1))
             a(1) = b(3);
             a(2) = b(1);
         end
    else
         if(b(2)>b(1))
             a(1) = b(2);
             a(2) = b(1);
         end
    end
    if((a(1)-fc1)<=5)
         if((a(2)-fr1)<=5)
             nmb = "1";
         elseif((a(2)-fr2)<=5)
             nmb = "4";
         elseif((a(2)-852)<=5)
             nmb = "7";
         end
    elseif((a(1)-fc2)<=5)
         if((a(2)-fr1)<=5)
             nmb = "2";
         elseif((a(2)-fr2)<=5)
             nmb = "5";
         elseif((a(2)-fr3)<=5)
             nmb = "8";
         elseif((a(2)-fr4)<=5)
             nmb = "0";
         end
    elseif((a(1)-fc3)<=5)
         if((a(2)-fr1)<=5)
             nmb = "3";
         elseif((a(2)-fr2)<=5)
             nmb = "6";
         elseif((a(2)-fr3)<=7)
             nmb = "9";
         end
    end
      if(nmb == "null")
      else
        fprintf("%s",nmb);
        figure
                nexttile
                plot(x2);
                title(nmb+" Tuşunun Grafiği");
                xlabel("frekans");
                ylabel("büyüklük");
            hold on
      end
end

        T = 100000/fs;
        x = 1:T:100000*(length(ex_number) / fs);
        x = x / 100000;
        figure
            nexttile
          plot(x,ex_number);
          title("ornekteki sesin grafigi:(plot)");
          xlabel('time');
          ylabel('amplitude');
          hold on
           figure
            nexttile
          stem(x,ex_number);
          title("ornekteki sesin grafigi:(stem)");
          xlabel('time');
          ylabel('amplitude');
          hold on