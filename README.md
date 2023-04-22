# RSA
Recurrence Structure Analysis Toolbox (MATLAB)

How to apply Recurrence Structure Analysis (RSA) toolbox.

The RSA toolbox presents a time series segmentation technique for the detectection of metastable states (aka "recurrence domains").

There are essentially two ways to apply:

in the file LORENZEPL (34 - 41), RSA is applied to a single time series (from the Lorenz attractor).


% carry out RSA!
% recommended 1st attempt
% for probing ball size sampling

s = rsa(y, 100, 100, 'show', 1);

This invokes the RSA for data set y, with 100 threshold samples of the full range of state space (100%). The 'show' option plots the untility function based on a Markov chain optimization procedure. It is recommended to change the second parameter first, e.g. replacing 100 to 20 (i.e. 20% of data range), through

s = rsa(y, 100, 20, 'show', 1);

in this way, one should be able to reduce redundant threshold values. After this, it is recommended to increase the threshold sampling, e.g.

s = rsa(y, 500, 20);


Setting
ds = 500;
pr = 20;

leads then to the default Markov chain optimization 

s = rsa(y, ds, pr);                       % default: Markov optimization

Another possibility is entropy optimization:

s = rsa(y, ds, pr, 'optim', 'uniform'); % entropy optimization

One can also change the norm from Euclidian (default) e.g. to cosine similarity:

s = rsa(y, ds, pr, 'norm', 'cos');      % default Markov  + cosine similarity


Additionally, in the file ENSEMBLELORENZEPL (44 - 50), RSA can be applied to an ensemble of time series (e.g. obtained from cutting a long series into short segments, or from multiple realizations of measurements), with optional Hausdorff clustering in state space.


% carry out RSA!
s = ensemblersa(y, datasamp, prorange);     % default

% s = ensemblersa(y, datasamp, prorange, 'cluster', thres);
%           including Hausdorff clustering

% additional Hausdorff clustering
sc = hdcluster(y, s, thres); 



# References

beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
dynamical systems by symbolic dynamics.
Physical Review Letters, 110, 154101.

beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
by symbolic analysis: Applications to human language processing.
Philosophical Transactions of the Royal Society London, A373, 201400897.

beim Graben, P.; Sellers, K. K.; Fröhlich, F. & Hutt, A. (2016).
Optimal estimation of recurrence structures from time series.
EPL, 114, 38003

Tosic, T., Sellers, K. K., Fröhlich, F., Fedotenkova, M., beim Graben, P., & Hutt, A. (2016). Statistical frequency-dependent analysis of trial-to-trial variability in single time series by recurrence plots. Frontiers in Systems Neuroscience, 9, 184.

Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors: 
interweaving dynamical systems and experimental data. 
Frontiers in Applied Mathematics and Statistics, 3, 11.

beim Graben, P., Jimenez-Marin, A., Diez, I., Cortes, J. M., Desroches, M., & Rodrigues, S. (2019). Metastable brain resting state dynamics. Frontiers in Computational Neuroscience, 13, 62.


(C) Peter beim Graben, BCCN 2023
