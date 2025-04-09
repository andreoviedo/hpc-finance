#include <stdio.h>
#include <mkl_vsl.h>

void RandomNumbersTest()
{
	const int SEED = 777;
    float* rands = new float[1000]; /* buffer for random numbers */
    
    //Create the stream
    VSLStreamStatePtr stream;
    
    //Initialize the stream
    vslNewStream(&stream, VSL_BRNG_MCG31, SEED);

    //Generate
    float mean = 0.0f;
    float stdev = 1.0f;
    vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream, 1000, rands, mean, stdev);
   
    printf("Original Random Number Sequence\n"); 
    for (int i = 0; i<20; ++i) 
    {
        printf("%f, ", rands[i]);
    }
    
    printf("\n");

    // Delete the stream
    vslDeleteStream(&stream);
}

void LeapFroggingTest()
{
	const int SEED = 777;

	VSLStreamStatePtr stream1;
	VSLStreamStatePtr stream2;
	VSLStreamStatePtr stream3;

	/* Creating 3 identical streams */
	int status = vslNewStream(&stream1, VSL_BRNG_MCG31, SEED);
	status = vslCopyStream(&stream2, stream1);
	status = vslCopyStream(&stream3, stream1);

	/* Leapfrogging the streams */
	status = vslLeapfrogStream(stream1, 0, 3);
	status = vslLeapfrogStream(stream2, 1, 3);
	status = vslLeapfrogStream(stream3, 2, 3);

	float mean = 0.0f;
	float stdev = 1.0f;

	float* rands1 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream1, 10, rands1, mean, stdev);

	float* rands2 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream2, 10, rands2, mean, stdev);

	float* rands3 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream3, 10, rands3, mean, stdev);


        
        printf("\n\nLeap Frogging Sub Sequence\n"); 
	printf("Seq 1: ");
	for (int i = 0; i<10; ++i)
	{
		printf("%f, ", rands1[i]);
	}

	printf("\nSeq 2: ");

	for (int i = 0; i<10; ++i)
	{
		printf("%f, ", rands2[i]);
	}

	printf("\nSeq 3: ");

	for (int i = 0; i<10; ++i)
	{
		printf("%f, ", rands3[i]);
	}

	printf("\n");

	/* Deleting the stream */
	vslDeleteStream(&stream1);
	vslDeleteStream(&stream2);
	vslDeleteStream(&stream3);
}

void BlockSplittingTest()
{
	const int seed = 777;
        const int nskip = 5;
        const int nstreams = 3;	
        VSLStreamStatePtr stream[nstreams];
        
        for (int k=0; k<nstreams; k++ )
        {
             vslNewStream( &stream[k], VSL_BRNG_MCG31, seed );
             vslSkipAheadStream( stream[k], nskip*k );
        }

	float mean = 0.0f;
	float stdev = 1.0f;
	
	float* rands1 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream[0], 10, rands1, mean, stdev);

	float* rands2 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream[1], 10, rands2, mean, stdev);

	float* rands3 = new float[10]; /* buffer for random numbers */
	vsRngGaussian(VSL_RNG_METHOD_GAUSSIAN_ICDF, stream[2], 10, rands3, mean, stdev);

        printf("\n\nBlock Splitting \n"); 
	printf("Seq 1: ");
	for (int i = 0; i<5; ++i)
	{
		printf("%f, ", rands1[i]);
	}

	printf("\nSeq 2: ");
	for (int i = 0; i<5; ++i)
	{
		printf("%f, ", rands2[i]);
	}

	printf("\nSeq 3: ");
	for (int i = 0; i<5; ++i)
	{
		printf("%f, ", rands3[i]);
	}
	printf("\n");

	/* Deleting the streams */
	vslDeleteStream(&stream[0]);
	vslDeleteStream(&stream[1]);
	vslDeleteStream(&stream[2]);
}

int main()
{
   RandomNumbersTest();
   BlockSplittingTest();
   LeapFroggingTest();
}
