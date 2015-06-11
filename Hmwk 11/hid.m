arrayMoving=[
   -14936
-14973
-14787
-14540
-14832
-14748
-14812
-14918
-14891
-14954
-14918
-14954
-14750
-14653
-14737
-14476
-14929
-15057
-14986
-14552
-14468
-14948
-14473
-14468
-14694
-14703
-14133
-14804
-14440
-14302
-14204
-13731
-12984
-13067
-13260
-13939
-14158
-13500
-15420
-13498
-13646
-12768
-12440
-12582
-11964
-11813
-11900
-12836
-11312
-11853
-12462
-12147
-12412
-12321
-12423
-12399
-12783
-12413
-12913
-12253
-12644
-12475
-12776
-12595
-12744
-12753
-12616
-12677
-12620
-12854
-12673
-12882
-12842
-12801
-12654
-12723
-12655
-12611
-12480
-12495
-12592
-13374
-12620
-12891
-12254
-12399
-12110
-12316
-12475
-12606
-12700
-12840
-12283
-13080
-12577
-12372
-12740
-12851
-11950
-12112

];

arrayStill=[
    -15836
-15662
-15482
-15846
-15654
-15745
-15787
-15786
-15752
-15675
-15814
-15664
-15658
-15758
-15774
-15828
-15679
-15800
-15729
-15845
-15611
-15768
-15757
-15728
-15791
-15704
-15793
-15812
-15853
-15744
-15804
-15508
-15747
-15736
-15688
-15731
-15792
-15806
-15721
-15787
-15679
-15804
-15757
-15707
-15672
-15777
-15944
-15646
-15818
-15781
-15901
-15694
-15669
-15729
-15661
-15738
-15824
-15858
-15578
-15918
-15720
-15770
-15833
-15908
-15681
-15880
-15772
-15789
-15736
-15816
-15785
-15408
-15837
-15752
-15729
-15833
-15748
-15856
-15737
-15733
-15722
-15764
-15805
-15832
-15701
-15822
-15781
-15747
-15781
-15722
-15786
-15737
-15861
-15785
-15777
-15846
-15580
-15750
-15787
-15693
-15460
-15678
-15748
-15712
-15824
-15825
-15918
-15656
-15716
-15708
-15672
-15717
-15776
-15619
-16008
-15742
-15814
-15777
-15720
-15728
-15744
-15892
-15942
-15633
-15890
-15624
-15724
-15758
-15844
-15526
-15698
-15798
-15784
-15742
-15729
-15822
-15750
-15749
-15818
-15757
-15451
-15901
-15731
-15801
-15777
-15884
-15761
-15634
-15760
-15573
-15886
-15701
-15716
-15653
-15789
-15812
-15811
-15782
-15785
-15686
-15512
-15909
-15711
-15812
-15764
-15677
-15989
-15586
-15806
-15653
-15748
-15791
-15842
-15760
-15732
-15745
-15772
-15845
-15727
-15662
-15468
-15840
-15781
-15793
-15766
-15820
-15713
-15748
-15829
-15588
-15669
-15826
-15646
-15785
-15781
-15741
-15605
-15786
-15826
-15716];

%%%Plotting moving and standing still vs. sample number%%%

figure(1)
plot(arrayMoving)
title('Z-Data - Moving');
xlabel('Sample Number');
ylabel('Accelerometer data');

figure(2)
plot(arrayStill)
title('Z-Data - Standing still');
xlabel('Sample Number');
ylabel('Accelerometer data');

%%%%%%MOVING DATA%%%%%%
%%%Plotting and FFT%%%
L = 200;
Fs = 1;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(arrayMoving,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

%Plot single-sided amplitude spectrum
figure(3)
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Amplitude Spectrum - Moving')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% signal_avg = mean(arrayMoving);
% fprintf('|Signal Average| %f\n',abs(signal_avg));
% mag = abs(Y(1:NFFT/2+1));
% fprintf('0 Hz spike mag: %f\n',mag(1));

% %Frequency of a filter with coefficients b
% b = fir1(10,0.2);
% freqz(b)

arrayFIFO = zeros(1,95);
for i = 1:95
    avgTemp = mean(arrayMoving(i:i+4));
    arrayFIFO(i) = avgTemp;
end

figure(4)
plot(arrayFIFO)
title('MAF - moving');
xlabel('Sample Number');
ylabel('Accelerometer data');

%0.5 is the Nyquist frequency, which is half of the sampling frequency;
%Nyquist is the cutoff frequency
b = fir1(10,0.2);
arrayFIR = conv(b,arrayMoving);

figure(5)
plot(arrayFIR)
title('FIR - Moving');
xlabel('Sample Number');
ylabel('Accelerometer data');

%%%%%%NOT MOVING DATA%%%%%%
%%%Plotting and FFT%%%
Lf = 200;
NFFTf = 2^nextpow2(L); % Next power of 2 from length of y
Yf = fft(arrayStill,NFFT)/L;
ff = Fs/2*linspace(0,1,NFFT/2+1);

%Plot single-sided amplitude spectrum
figure(6)
plot(ff,2*abs(Yf(1:NFFTf/2+1))) 
title('Amplitude Spectrum - Standing still')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% signal_avgf = mean(arrayFlat);
% fprintf('Absolute Value of Signal Average: %f\n',abs(signal_avgf));
% magf = abs(Yf(1:NFFTf/2+1));
% fprintf('Magnitude of spike at 0 Hz: %f\n',magf(1));
% fprintf('They are indeed equivalent!\n');

% %Frequency of a filter with coefficients b
% b = fir1(10,0.2);
% freqz(b)

arrayFIFOstill = zeros(1,195);
for i = 1:195
    avgTempStill = mean(arrayStill(i:i+4));
    arrayFIFOstill(i) = avgTempStill;
end

figure(7)
plot(arrayFIFOstill)
title('MAF - Standing still');
xlabel('Sample Number');
ylabel('Accelerometer data');


%0.5 is the Nyquist frequency, which is half of the sampling frequency;
%Nyquist is the cutoff frequency
b = fir1(10,0.2);
arrayFIR = conv(b,arrayStill);

figure(8)
plot(arrayFIR)
title('FIR - Standing still');
xlabel('Sample Number');
ylabel('Accelerometer data');