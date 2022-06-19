program test;

  int a;
  int seed = 655;

  initial begin


    //flat distribution, -> signed 32 bit random
    a = $random();
    $display("random a = %0d", a);

    //flat distribution, -> unsigned 32 bit random
    a = $urandom();
    $display("urandom a = %0d", a);

    //flat distribution over a range
    a = $urandom_range(50, 100);
    $display("urandom_range a = %0d", a);

    //exponential decay function (seed, mean_value)
    a = $dist_exponential(seed, 30);
    $display("exponential a = %0d", a);

    //Bell-Shaped distribution (seed, mean, deviation)
    a = $dist_normal(seed, 30, 2);
    $display("normal a = %0d", a);

    //Bell-Shaped distribution (seed, mean)
    a = $dist_poisson(seed, 30);
    $display("poisson a = %0d", a);

    //Bell-Shaped distribution (seed, start, end)
    a = $dist_uniform(seed, 30, 50);
    $display("uniform a = %0d", a);



  end



endprogram
