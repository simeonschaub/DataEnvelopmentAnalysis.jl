# Tests for Profit DEA Models
@testset "ProfitDEAModel" begin

    ## Test Profit DEA Model
    # Test with Zofio, Pastor and Aparicio (2013) data
    X = [1 1; 1 1; 0.75 1.5; 0.5 2; 0.5 2; 2 2; 2.75 3.5; 1.375 1.75]
    Y = [1 11; 5 3; 5 5; 2 9; 4 5; 4 2; 3 3; 4.5 3.5]
    P = [2 1; 2 1; 2 1; 2 1; 2 1; 2 1; 2 1; 2 1]
    W = [2 1; 2 1; 2 1; 2 1; 2 1; 2 1; 2 1; 2 1]

    GxGydollar = 1 ./ (sum(P, dims = 2) + sum(W, dims = 2))
    GxGydollar = repeat(GxGydollar, 1, 2)

    deaprofitdollar = deaprofit(X, Y, W, P, GxGydollar, GxGydollar)

    @test typeof(deaprofitdollar) == ProfitDEAModel

    @test efficiency(deaprofitdollar, :Economic)   ≈ [2; 2; 0; 2; 2; 8; 12; 4] atol = 1e-3
    @test efficiency(deaprofitdollar, :Technical)  ≈ [0; 0; 0; 0; 0; 6; 12; 3] atol = 1e-3
    @test efficiency(deaprofitdollar, :Allocative) ≈ [2; 2; 0; 2; 2; 2; 0; 1] atol = 1e-3

    # Print
    show(IOBuffer(), deaprofitdollar)

    # Test errors
    @test_throws ErrorException deaprofit([1; 2 ; 3], [4 ; 5], [1; 1; 1], [4; 5], [1; 2 ; 3], [4 ; 5]) #  Different number of observations
    @test_throws ErrorException deaprofit([1; 2; 3], [4; 5; 6], [1; 2; 3; 4], [4; 5; 6], [1; 2; 3], [4; 5; 6]) # Different number of observation in input prices
    @test_throws ErrorException deaprofit([1; 2; 3], [4; 5; 6], [1; 2; 3], [4; 5; 6; 7], [1; 2; 3], [4; 5; 6]) # Different number of observation in output prices
    @test_throws ErrorException deaprofit([1 1; 2 2; 3 3], [4; 5; 6], [1 1 1; 2 2 2; 3 3 3], [4; 5; 6], [1 1; 2 2; 3 3], [4; 5; 6]) # Different number of input prices and inputs
    @test_throws ErrorException deaprofit([1; 2; 3], [4 4; 5 5; 6 6], [1; 2; 3], [4 4 4; 5 5 5; 6 6 6], [1; 2; 3], [4 4; 5 5; 6 6]) # Different number of oputput prices and outputs
    @test_throws ErrorException deaprofit([1 1; 2 2; 3 3], [4; 5; 6], [1 1; 2 2; 3 3], [4; 5; 6], [1 1 1; 2 2 2; 3 3 3], [4; 5; 6]) # Different size of inputs direction
    @test_throws ErrorException deaprofit([1; 2; 3], [4 4; 5 5; 6 6], [1; 2; 3], [4 4; 5 5; 6 6], [1; 2; 3], [4 4 4; 5 5 5; 6 6 6]) # Different size of inputs direction

    # ------------------
    # Test Vector and Matrix inputs and outputs
    # ------------------
    # Tests against results in R

    # Inputs is Matrix, Outputs is Vector
    X = [2 2; 1 4; 4 1; 4 3; 5 5; 6 1; 2 5; 1.6	8]
    Y = [1; 1; 1; 1; 1; 1; 1; 1]
    W = [1 1; 1 1; 1 1; 1 1; 1 1; 1 1; 1 1; 1 1]
    P = [1; 1; 1; 1; 1; 1; 1; 1]

    @test efficiency(deaprofit(X, Y, W, P, X, Y)) ≈ [0; 0.1666666667; 0.1666666667; 0.375; 0.5454545455; 0.375; 0.375; 0.5283018868]

    # Inputs is Vector, Output is Matrix
    X = [1; 1; 1; 1; 1; 1; 1; 1]
    Y = [7 7; 4 8; 8 4; 3 5; 3 3; 8 2; 6 4; 1.5 5]
    W = [1; 1; 1; 1; 1; 1; 1; 1]
    P = [1 1; 1 1; 1 1; 1 1; 1 1; 1 1; 1 1; 1 1]

    @test efficiency(deaprofit(X, Y, W, P, X, Y)) ≈ [0; 0.1538461538; 0.1538461538; 0.6666666667; 1.142857143; 0.3636363636; 0.3636363636; 1]

    # Inputs is Vector, Output is Vector
    X = [2; 4; 8; 12; 6; 14; 14; 9.412]
    Y = [1; 5; 8; 9; 3; 7; 9; 2.353]
    W = [1; 1; 1; 1; 1; 1; 1; 1]
    P = [1; 1; 1; 1; 1; 1; 1; 1]

    @test efficiency(deaprofit(X, Y, W, P, X, Y)) ≈ [0.6666666667; 0; 0.0625; 0.1904761905; 0.4444444444; 0.3809523810; 0.2608695652; 0.6849978751]

end
