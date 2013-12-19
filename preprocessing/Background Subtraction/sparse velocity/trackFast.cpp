#include "mex.h"
#include <matrix.h>
#include <math.h>
#include <stdio.h>
using namespace std;
double min(double a, double b);
double max(double a, double b);
void track(double* S,double *b, double *P, int cI,int cJ, int t, int T, int n,int m, int r);

void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
    
    /* allocate memory for input etc., some magic is here */
    mxArray *S, *b,*P;
    double *S_pr,*b_pr,*a,*P_pr;
    
    int cI,cJ,t,T,n,m,r;
    
    /* copy inputs */
    S=mxDuplicateArray(prhs[0]);
    //b=mxDuplicateArray(prhs[1]);
    cI=mxGetScalar(mxDuplicateArray(prhs[1]));
    cJ=mxGetScalar(mxDuplicateArray(prhs[2]));
    t=mxGetScalar(mxDuplicateArray(prhs[3]));
    T=mxGetScalar(mxDuplicateArray(prhs[4]));
    n=mxGetScalar(mxDuplicateArray(prhs[5]));
    m=mxGetScalar(mxDuplicateArray(prhs[6]));
    r=mxGetScalar(mxDuplicateArray(prhs[7]));
    //b=mxDuplicateArray(prhs[8]);
    
    //b=plhs[0];
    /* initialize outputs*/
    b=plhs[0]=mxCreateDoubleMatrix(3,T,mxREAL);
    P=plhs[1]=mxCreateDoubleMatrix(n*m,T,mxREAL);
    //b_pr=mxGetPr(b);
//   b_j=plhs[1]=mxCreateDoubleMatrix(T-t,1,mxREAL);
//   b_s=plhs[2]=mxCreateDoubleMatrix(T-t,1,mxREAL);
    
    S_pr=mxGetPr(S);
    
    b_pr=mxGetPr(b);
    P_pr=mxGetPr(P);
    
    track(S_pr,b_pr,P_pr,cI,cJ,t,T,n,m,r);
    
}


void track(double* S,double* b, double* P_pr, int cI,int cJ, int t,int T, int n,int m, int r)
{
    int minI,minJ,maxI,maxJ,maxEnergy,v;
    double probSparse,probV,currentEnergy,maxSparse,fullProb,currentProb;
    double v_prev_x,v_prev_y,v_next_x,v_next_y,maxVelSparse;
    double sigma1=8;
    double sigma2=15;
    double sigma3=3;
    double probSvel=0;
    //int size=T-t;
    // double b[T][3];
    
    //double * b = (double *) malloc(sizeof(double)*(T*3));
    //b[time*n +1
    
    // initially v is set to zero
    v=0;
    probV=1;
    probSparse=1;
    cI=cI-1;
    cJ=cJ-1;
    //mexPrintf ("cI: %d, cJ: %d, n: %d, m: %d, r: %d \n",cI,cJ,n,m,r);
    //loop through every frame
    for (int time=t;time<=T;time++){
        
        
        minI=max(0,cI-r);
        minJ=max(0,cJ-r);
        
        maxI=min(n-1,cI+r);
        maxJ=min(m-1,cJ+r);
        maxSparse=0;
        maxVelSparse=0;
        for (int i=minI;i<=maxI;i++){
            for (int j=minJ;j<=maxJ;j++){
                
                if (S[(j*n+i)+(time-1)*m*n]>=maxSparse){
                    maxSparse=S[(j*n+i)+(time-1)*m*n];
                }
                
                if (time!=t){
                    
                    if (S[(j*n+i)+(time-1)*m*n]-S[(j*n+i)+(time-2)*m*n]>=maxVelSparse){
                    maxVelSparse=S[(j*n+i)+(time-1)*m*n]-S[(j*n+i)+(time-2)*m*n];
                    }
                    
                }
                
            }
        }
        
        
        currentEnergy=0;
        currentProb=0;
        // for every element of the array
        for (int i=minI;i<=maxI;i++){
            for (int j=minJ;j<=maxJ;j++){
                
//                 if (S[(j*n+i)+(time-1)*m*n]>=currentEnergy){
//                     maxSparse=currentEnergy;
//                 }
                probSparse=exp(-(pow(S[(j*n+i)+(time-1)*m*n]-maxSparse,2.0))/(2*sigma1*sigma1));
                
                if (time!=t){
                    v_next_x=i-cI;
                    v_next_y=j-cJ;
                    
                    v_prev_x=cI-b[(time-1-1)*3]-1;
                    v_prev_y=cJ-b[(time-1-1)*3+1]-1;
                    
                    probV=exp(-(pow(v_next_x-v_prev_x,2.0)+pow(v_next_y-v_prev_y,2.0))/(2*sigma2*sigma2));
                    
                    probSvel=exp(-(pow(S[(j*n+i)+(time-1)*m*n]-S[(j*n+i)+(time-2)*m*n]-maxVelSparse,2.0))/(2*sigma3*sigma3));
                }else{
                    probV=1;
                }
                fullProb=probV*probSparse;
                P_pr[(j*n+i)+(time-1)*m*n]=fullProb;
                
                if (fullProb>=currentProb){
                    currentEnergy=S[(j*n+i)+(time-1)*m*n];
                    b[(time-1)*3]=i+1;
                    b[(time-1)*3+1]=j+1;
                    b[(time-1)*3+2]=currentEnergy;
                    currentProb=fullProb;
                    
                    
                }
                //mexPrintf ("Time: %d: %f \n",(j*n+i)+(time-1)*m*n);
//                 if (S[(j*n+i)+(time-1)*m*n]>=currentEnergy){
//                     currentEnergy=S[(j*n+i)+(time-1)*m*n];
//                     b[(time-1)*3]=i+1;
//                     b[(time-1)*3+1]=j+1;
//                     b[(time-1)*3+2]=currentEnergy;
//
//
//                 }
//
                
                
            }
        }
        
        cI=b[(time-1)*3]-1;
        cJ=b[(time-1)*3+1]-1;
        
    }
    
    //return b;
    
    
    
}




double min(double a, double b){
    
    if (a>=b){
        return b;
    }else{
        return a;
    }
    
}

double max(double a, double b){
    
    if (a<=b){
        return b;
    }else{
        return a;
    }
    
}
