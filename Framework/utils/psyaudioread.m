[y, fs, bits, other_info] = psyaudioread(fname, samples)
% [Y, FS, BITS, OTHER_INF] = PSYAUDIOREAD(FILENAME, SAMPLES)
%
% Interface function to obsolete WAVREAD or to AUDIOREAD in 
% newer versions of matlab. Should be used throughout psysound
% instead of wavread.

yinfo = [];

if nargin > 1
    if samples == 'size'
        if exist('audioread')
            other_info = audioinfo(fname);
            y = other_info.TotalSamples;
            return
        else
            y = wavread(fname,'size')
            return
        end
    end
end

if exist('audioread')
  % read the first sample of data and find the sample rate / wordsize and
  % file comment.wavread for the sample rate, bitsPerSample, info
  [Y, sampleRate] = audioread(fname, samples);
  % info is acquired with a different function
  other_info = audioinfo(fname);
  bits = other_info.BitsPerSample;
else
  % work out the size and channel count
  temp = wavread(fH.name, 'size');

  % This is by convention - see help wavread
  fH.samples  = temp(1);
  fH.channels = temp(2);
  % read the first sample of data and find the sample rate / wordsize and
  % file comment.wavread for the sample rate, bitsPerSample, info
  [Y, sampleRate, bitsPerSample, OPTS] = wavread(fH.name, 1);
  fH.bitsPerSample = bitsPerSample
end

