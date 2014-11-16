#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;
use List::Util qw/max min sum/;
use List::MoreUtils qw/distinct/;

my @labels = qw/Count Distinct Minimum Mean Median Max StdDev/;
my @procs = (
    sub { return scalar( @_ ) },
    sub { return scalar( List::MoreUtils::distinct( @_ ) ); },
    \&List::Util::min,
    \&mean,
    sub { my @sorted = sort { $a <=> $b } @_; return $sorted[@_/2]; },
    \&List::Util::max,
    \&stddev,
);

chomp( my @values = <DATA> );

my @summary = map { $_->( @values ) } @procs;

foreach my $i ( 0 .. $#labels )
{
    printf "%-10s: %g\n", $labels[$i], $summary[$i];   
}

sub mean
{
    return 0 unless @_;
    return List::Util::sum( @_ ) / @_;
}

sub stddev
{
    my $n = @_;
    return 0 unless $n > 1;
    my ($sum, $sum_sq) = (0, 0);
    foreach my $x (@_)
    {
        $sum += $x;
        $sum_sq += $x*$x;
    }
    return sqrt( ($sum_sq - ($sum * $sum) /$n)/( $n - 1 ) );
}

__DATA__
13.488
12.771
13.739
11.449
5.4
11.358
8.624
13.392
6.898
11.950
10.514
10.964
8.576
12.755
11.45
11.935
10.498
12.741
12.726
12.816
11.488
12.333
11.103
11.808
11.372
11.597
10.865
13.534
11.863
11.314
12.673
12.519
14.001
12.270
12.358
12.743
13.158
10.769
8.244
13.302
7.262
11.571
12.258
12.314
11.182
12.583
8.697
13.219
13.212
13.961
13.546
12.453
10.767
10.94
13.060
13.289
10.889
13.398
11.130
14.762
12.572
12.968
14.233
13.055
8.503
9.842
12.788
13.211
1.697
10.792
13.966
12.097
13.075
13.760
11.568
11.87
11.564
12.678
12.765
9.911
14.006
12.482
14.457
11.47
10.711
11.971
10.341
7.443
10.922
12.968
11.713
6.344
12.166
13.363
11.926
11.677
14.014
13.326
14.227
11.471
12.247
13.406
12.546
13.038
15.011
13.049
12.78
13.346
10.387
12.311
12.301
11.488
14.235
12.194
7.012
13.95
11.653
10.651
13.049
9.146
14.269
12.46
11.881
13.863
12.966
13.296
10.016
10.094
13.964
14.7
12.390
11.796
12.281
10.270
12.37
13.994
12.475
13.662
9.807
11.988
11.415
9.895
12.6
13.724
12.729
12.372
12.742
13.956
13.405
11.981
12.593
12.987
13.96
8.932
14.139
10.980
12.589
12.459
12.412
13.125
14.573
7.785
12.592
11.643
12.845
11.728
13.320
12.842
8.355
14.3
9.196
12.514
9.62
8.544
11.725
9.872
11.966
11.886
11.198
7.790
9.574
12.350
10.828
12.720
12.931
13.844
14.020
13.507
13.744
10.304
13.879
13.803
12.123
14.061
14.906
14.334
15.093
13.902
13.374
9.162
13.668
13.493
11.008
14.653
13.139
13.402
11.87
12.241
3.959
12.153
13.796
14.382
13.656
13.446
14.077
10.374
13.385
13.801
13.8
12.160
14.738
12.947
10.137
10.582
13.509
12.530
13.384
10.859
11.685
13.196
10.757
14.004
8.994
13.791
6.735
13.128
12.128
13.746
13.488
11.588
9.95
9.24
9.140
11.552
13.532
11.89
5.607
10.008
13.172
12.399
12.304
13.020
11.283
9.13
7.534
14.186
12.789
13.861
12.003
12.363
14.507
13.496
13.730
13.32
13.70
6.322
6.366
12.426
12.265
13.98
6.866
11.288
12.649
11.127
12.864
13.171
14.221
8.459
12.039
14.114
12.636
8.185
8.661
7.746
9.621
12.273
13.065
13.623
12.421
14.631
11.184
7.704
13.860
13.805
14.296
10.467
14.241
13.403
10.166
13.430
11.257
13.158
9.757
9.614
12.842
5.839
11.855
12.357
9.259
14.464
9.843
12.082
10.27
12.049
10.777
13.594
8.882
11.148
9.831
12.756
10.666
8.735
10.954
11.304
9.474
6.445
12.492
9.499
12.424
12.869
12.230
10.826
13.396
13.139
13.144
9.302
7.172
13.857
13.685
11.167
13.908
12.074
12.275
13.886
12.652
13.545
11.397
11.827
11.113
9.179
13.549
12.891
