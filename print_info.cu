#include <iostream>

int main(void) {
  cudaDeviceProp prop;
  
  int count;
  cudaGetDeviceCount(&count);
  
  printf("%d Cuda devices found!\n", count);
  
  for (int i=0; i<count; i++) {
    cudaGetDeviceProperties(&prop, i);
    printf( "--- General Information for device %d ---\n", i );
    printf( "Name:%s\n", prop.name );
    printf("Compute capability: %d. %d\n", prop.major, prop.minor);
    printf("Clock rate: %d\n", prop.clockRate);
    printf("Device copy overlap:  ");
    if (prop.deviceOverlap)
      printf( "Enabled\n" );
    else
      printf( "Disabled\n" );
      
    printf("Kernel execution timeout: ");
    if (prop.kernelExecTimeoutEnabled)
      printf( "Enabled\n" );
    else
      printf( "Disabled\n" );
      
    printf("Total global mem: %ld\n", prop.totalGlobalMem);
    printf("Total constant mem: %ld\n", prop.totalConstMem);
    printf("Max mem pitch: %ld\n", prop.memPitch);
      
      
      
    printf( "Multiprocessor count:  %d\n", prop.multiProcessorCount );
    printf("Registers per mp:  %d\n", prop.regsPerBlock);
    printf("Threads in warp: %d\n", prop.warpSize);
    printf( "Max threads per block: %d\n", prop.maxThreadsPerBlock );
    printf( "Max thread dimensions: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2] );
    printf( "Max grid dimensions: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2] );
  }
}