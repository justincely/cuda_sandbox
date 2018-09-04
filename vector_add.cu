#include <iostream>    // Needed to perform IO operations
using namespace std;

#define N 100000

__global__ void add(int n, int *a, int *b, int *c) {
  
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int stride = blockDim.x * gridDim.x;
  
  printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
  
  for (int i = index; i < n; i += stride) {
    c[i] = a[i] + b[i];
  }
  
}

int main(void) {
  int blockSize = 256;
  int numBlocks = (N + blockSize -1) / blockSize;
  int a[N], b[N], c[N];
  int *dev_a, *dev_b, *dev_c;
  
  cudaMalloc((void**)&dev_a, N*sizeof(int));
  cudaMalloc((void**)&dev_b, N*sizeof(int));
  cudaMalloc((void**)&dev_c, N*sizeof(int));

  for (int i=0; i<N; i++) {
    a[i] = -i;
    b[i] = i*i;
  }
  
  cudaMemcpy(dev_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, N*sizeof(int), cudaMemcpyHostToDevice);
  
  add<<<numBlocks, blockSize>>>(N, dev_a, dev_b, dev_c);
  
  cudaDeviceSynchronize();
  
  cudaMemcpy(c, dev_c, N*sizeof(int), cudaMemcpyDeviceToHost);
  
  for (int i=0; i<N; i++) {
    printf( "%d + %d = %d\n", a[i], b[i], c[i] );
  }
  
  cudaFree(dev_a);
  cudaFree(dev_b);
  cudaFree(dev_c);
  
  return 0;
}