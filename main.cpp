#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <map>
#include <vector>
#include <math.h>
#include <utility>
#include <stack>
#include <queue>
#include <random>
#include <fstream>
using namespace std;



vector<int> matching_to_cycle_lengths(vector<int> m1, vector<int> m2){
    
    vector<int> loopLengths(m1.size());
    int next1 = 0;
    int next2;
    int numLoops = 0;
    
    for(int i = 0; i < m1.size() - 1; i++){
        
        if(m1[i] != 0){
            numLoops++;
            next1 = i;
        }
        
        while(m1[next1] != 0){
            next2 = m1[next1];
            m1[next1] = 0;
            m1[next2] = 0;
            next1 = m2[next2];
            m2[next1] = 0;
            m2[next2] = 0;
            loopLengths[numLoops - 1] += 2;
        }
    }
    return loopLengths;
}



vector<int> make_nc_matching(vector<int> points){
    
    stack<int> zeros;
    queue<int> ones;
    vector<int> ncmatching(points.size());

    for(int i = 0; i < points.size(); i++){
        if(points[i] == 0) zeros.push(i);
        else{
            if(zeros.empty()) ones.push(i);
            else{
                ncmatching[i] = zeros.top();
                ncmatching[zeros.top()] = i;
                zeros.pop();
            }
        }
    }
    
    while(!zeros.empty()){
        ncmatching[zeros.top()] = ones.front();
        ncmatching[ones.front()] = zeros.top();
        zeros.pop();
        ones.pop();
    }

    return ncmatching;
}


/*vector<int> nc_matching(int pairs, double a){
    
    vector<int> points(2*pairs,0);
    vector<int> top(2*pairs);
    vector<int> bottom(2*pairs);
    random_device rd;
    mt19937 mt(rd());
    int same = 2*ceil(a*pairs);
    int diff = 2*pairs - same;
    
    //  0 = (+/+), 1 = (-/-), 2 = (+/-), 3 = (-/+)
    
    fill(points.begin(),points.begin() + same/2,1);
    fill(points.begin() + same, points.end() - diff/2,2);
    fill(points.end()-diff/2,points.end(),3);
    
    shuffle(points.begin(), points.end(), mt);
    
    for(int i = 0; i < 2*pairs; i++){
        top[i] = points[i] % 2;
        bottom[i] = (points[i] & 1) ^ ((points[i] & 2)>>1);
    }
    
    return matching_to_cycle_lengths(make_nc_matching(top), make_nc_matching(bottom));
}*/



void nc_matching_top(int pairs, double a, int iterations){

    ofstream flongest;
    ofstream fnum;
    int b = a*100;
    int num;
    flongest.open("ncLongestCycle" + to_string(pairs) + "_0." + to_string(b) + ".txt",ios_base::app);
    fnum.open("ncNumCycles" + to_string(pairs) + "_0." + to_string(b) + ".txt",ios_base::app);
    
    vector<int> cycleLengths;
    vector<int> points(2*pairs,0);
    vector<int> top(2*pairs);
    vector<int> bottom(2*pairs);
    random_device rd;
    mt19937 mt(rd());
    int same = 2*ceil(a*pairs);
    int diff = 2*pairs - same;
    
    //  0 = (+/+), 1 = (-/-), 2 = (+/-), 3 = (-/+)
    
    fill(points.begin(),points.begin() + same/2,1);
    fill(points.begin() + same, points.end() - diff/2,2);
    fill(points.end()-diff/2,points.end(),3);
    
    
    for(int i = 0; i < iterations; i++){
        
        cout<<i<<endl;
        
        shuffle(points.begin(), points.end(), mt);
       
        for(int i = 0; i < 2*pairs; i++){
            top[i] = points[i] % 2;
            bottom[i] = (points[i] & 1) ^ ((points[i] & 2)>>1);
        }
        
        cycleLengths = matching_to_cycle_lengths(make_nc_matching(top), make_nc_matching(bottom));
        
        flongest << *max_element(cycleLengths.begin(),cycleLengths.end());
        flongest << "\n";
        
        num = 0;
        for(int x :cycleLengths){
            if(x) num++;
        }
        fnum << num << "\n";

    }
    flongest.close();
    fnum.close();
}





void nc_matching_top_a(int pairs, int iterations){
    
    ofstream f;
    f.open("nca" + to_string(pairs) + ".txt");
    
    vector<int> cycleLengths;
    vector<int> points(2*pairs,0);
    vector<int> top(2*pairs);
    vector<int> bottom(2*pairs);
    vector<int> maxLengths(iterations);
    vector<int> numCycles(iterations);
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dist(0,2*pairs-1);
    int k,temp,num;
    long meanNumCycles, meanMaxLength, varNum, varLength;
    
    
    for(double a = 0; a <= 1.001; a += 0.01){
    
        int same = 2*ceil(a*pairs);
        int diff = 2*pairs - same;
        
        //  0 = (+/+), 1 = (-/-), 2 = (+/-), 3 = (-/+)
        
        fill(points.begin(),points.end(), 0);
        fill(points.begin(),points.begin() + same/2,1);
        fill(points.begin() + same, points.end() - diff/2,2);
        fill(points.end()-diff/2,points.end(),3);
        
        cout << a << endl;
        
        for(int i = 0; i < iterations; i++){
        
            
            for(int j = 1; j < 2*pairs; j++){
                temp = points[j];
                k = dist(mt) % j + 1;
                points[j] = points[k];
                points[k] = temp;
            }
        
            for(int j = 0; j < 2*pairs; j++){
                top[j] = points[j] % 2;
                bottom[j] = (points[j] & 1) ^ ((points[j] & 2)>>1);
                //bottom[j] = (points[j] != 1 and points[j] != 2);
            }
            
            cycleLengths = matching_to_cycle_lengths(make_nc_matching(top), make_nc_matching(bottom));
            
            maxLengths[i] = *max_element(cycleLengths.begin(),cycleLengths.end());

            num = 0;
            for(int x :cycleLengths){
                if(x) num++;
            }
            
            numCycles[i] = num;
        }
        
        meanNumCycles = accumulate(numCycles.begin(),numCycles.end(),0)/iterations;
        meanMaxLength = accumulate(maxLengths.begin(),maxLengths.end(),0)/iterations;
        
        varNum = 0;
        varLength = 0;
        for(int j = 0; j < iterations; j++){
            varNum += pow(numCycles[j] - meanNumCycles,2);
            varLength += pow(maxLengths[j] - meanMaxLength,2);
        }
        
        
        f << a << " " << meanNumCycles << " " << (int) sqrt(varNum/iterations) << " " << meanMaxLength << " " << (int) sqrt(varLength/iterations) << "\n";
        
    }
    f.close();
}






tuple<vector<int>,vector<int>,vector<int>,vector<int>> rwmatching2(int pairs){
    
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dist(0,3);
    
    vector<int> matching(2*pairs,-1);
    vector<int> lengths(pairs,0);
    vector<int> maxy(pairs,0);
    vector<int> displacements(pairs,0);
    
    int n,x,y;
    int num = -1;
    bool foundpath,matched;
    pair<int,int> key;
    map<pair<int,int>,int> visited;
    
    
    for(int i = 0; i < 2*pairs-1; i++){
        
        if(matching[i] != -1){ continue; }
        
        x = i;
        y = -1;
        num++;
        lengths[num]++;

        visited[make_pair(x, y)] |= 1;
        y++;
        visited[make_pair(x, y)] |= 4;
        
        matched = false;
        while(!matched){
            
            key = make_pair(x, y);
            lengths[num]++;

            foundpath = false;
            while(!foundpath){
                n = dist(mt);
                if ((visited[key] bitand (1<<n)) == 0){
                    foundpath = true;
                }
            }
            
            if(n == 0){
                visited[key] |= 1;
                y++;
                maxy[num] = max(maxy[num],y);
                visited[make_pair(x, y)] |= 4;
            }
            else if(n == 1){
                visited[key] |= 2;
                x = (x + 1) % (2*pairs);
                visited[make_pair(x, y)] |= 8;
            }
            else if(n == 2){
                visited[key] |= 4;
                matched = !y;
                y--;
                visited[make_pair(x, y)] |= 1;
            }
            else if(n == 3){
                visited[key] |= 8;
                x = (2*pairs + x - 1) % (2*pairs);
                visited[make_pair(x, y)] |= 2;
            }
        }
        matching[i] = x;
        matching[x] = i;
        displacements[num] = min(abs(x-i),2*pairs-abs(x-i));
    }
    return make_tuple(matching,lengths,maxy,displacements);
}





void rw_matching_top(int pairs, int iterations){
    
    ofstream fcycleLengths, frwLengths, fmaxy, fbaseDisp;
    string p = to_string(pairs);
    fcycleLengths.open("cycleLengths" + p + ".txt");
    frwLengths.open("rwLengths" + p + ".txt");
    fmaxy.open("maxy" + p + ".txt");
    fbaseDisp.open("baseDisp" + p + ".txt");
    
    for(int i = 0; i < iterations; i++){

        cout << i << endl;
        
        auto data = rwmatching2(pairs);
        
        vector<int> matching1 = get<0>(data);
        vector<int> rwLengths = get<1>(data);
        vector<int> maxy = get<2>(data);
        vector<int> baseDisp = get<3>(data);
        
        for(int x : rwLengths) frwLengths << x << " ";
        frwLengths << "\n";
        
        for(int x : maxy) fmaxy << x << " ";
        fmaxy << "\n";
        
        for(int x : baseDisp) fbaseDisp << x << " ";
        fbaseDisp << "\n";

        // second matching
        
        data = rwmatching2(pairs);
        
        vector<int> matching2 = get<0>(data);
        rwLengths = get<1>(data);
        maxy = get<2>(data);
        baseDisp = get<3>(data);
        
        for(int x : rwLengths) frwLengths << x << " ";
        frwLengths << "\n";
        
        for(int x : maxy) fmaxy << x << " ";
        fmaxy << "\n";
        
        for(int x : baseDisp) fbaseDisp << x << " ";
        fbaseDisp << "\n";
        
        
        vector<int> cycleLengths = matching_to_cycle_lengths(matching1, matching2);
        
        sort(cycleLengths.begin(),cycleLengths.end(),greater<int>());
        
        for(int x : cycleLengths){
            if(x) fcycleLengths << x <<" ";
        }
        fcycleLengths << "\n";
    }
    
    fcycleLengths.close();
    frwLengths.close();
    fmaxy.close();
    fbaseDisp.close();
  
}


void rw2(int dim, int iterations, int klongest){
    
    int n,x,y;
    bool foundpath;
    signed char m[dim][dim];
    int numLoops[iterations];
    int loopLengths[iterations][klongest];
    
    vector<int> currentLengths(ceil(0.0256*dim*dim+0.7564*dim) + 1000);
    
    for(int i = 0; i < iterations; i++){
        numLoops[i] = 0;
    }
    
    
    for(int i = 0; i < iterations; i++){
        
        cout << i << endl;
        
        for(int a = 0; a < dim; a++){
            for(int b = 0; b < dim; b++){
                m[a][b] = 0;
            }
        }
        
        
        for(int j = 0; j < dim; j ++){
            for(int k = 0; k < dim; k ++){
                
                if((m[j][k] bitand 15) == 15){ continue; }
                
                x = j;
                y = k;
                
                do{
                    foundpath = false;
                    while(!foundpath){
                        n = rand() % 4;
                        if ((m[x][y] bitand (1<<n)) == 0){
                            foundpath = true;
                        }
                    }
                    
                    if(n == 0) {
                        m[x][y] |= 1;
                        y = (y+1)%dim;
                        m[x][y] |= 4;
                    }
                    else if (n == 1){
                        m[x][y] |= 2;
                        x = (x+1) % dim;
                        m[x][y] |= 8;
                    }
                    else if (n == 2){
                        m[x][y] |= 4;
                        y = (y+dim-1) % dim;
                        m[x][y] |= 1;
                    }
                    else if (n == 3){
                        m[x][y] |= 8;
                        x = (x+dim-1)%dim;
                        m[x][y] |= 2;
                    }
                    
                    currentLengths[numLoops[i]]++;
                    
                }while(x != j or y != k);
                
                numLoops[i]++;
            }
        }
        
        sort(currentLengths.begin(), currentLengths.end(), greater<int>());
        
        for(int l = 0; l < klongest; l++){
            loopLengths[i][l] = currentLengths[l];
        }
        
       fill(currentLengths.begin(),currentLengths.end(),0);
    }
}



int find_free_edge(int state){
    int dir = 0;
    while(((1<<dir) & state) != 0) dir ++;
    return dir;
}


void mirrors(int dim, double p1, double p2, int iterations, int threshold){

    random_device rd;
    mt19937 mt(rd());
    uniform_real_distribution<double> dist(0,1);
    
    int v[dim][dim];
    int m[dim][dim];
    int x,y,dir,startdir,length,numLoops;
    double n;
    
    int p1int = p1*100;
    int p2int = p2*100;
    
    ofstream f;
    ofstream fnum;
    f.open("mirrors" + to_string(dim) + "_" + to_string(p1int) + "_" + to_string(p2int) + ".txt");
    fnum.open("mirrorsNum" + to_string(dim) + "_" + to_string(p1int) + "_" + to_string(p2int) + ".txt");
    
    for(int iter = 0; iter < iterations; iter++){
        
        cout << iter << endl;
    
        for(int i = 0; i < dim; i++){
            for(int j = 0; j < dim; j++){
                
                n = dist(mt);
                if(n < p1) m[i][j] = 3;
                else if(n < p1 + p2 ) m[i][j] = 1;
                else m[i][j] = 0;
                v[i][j] = 0;
            }
        }
        
        numLoops = 0;

        for(int i = 0; i < dim; i++){
            for(int j = 0; j < dim; j++){
        
                while((v[i][j] & 15) != 15){
                    
                    x = i;
                    y = j;
                    length = 0;
                    startdir = find_free_edge(v[i][j]);
                    dir = startdir;
                    
                    do{
                        if(dir == 0){
                            v[x][y] |= 1;
                            y = (y + 1) % dim;
                            v[x][y] |= 4;
                        }
                        else if(dir == 1){
                            v[x][y] |= 2;
                            x = (x + 1) % dim;
                            v[x][y] |= 8;
                        }
                        else if(dir == 2){
                            v[x][y] |= 4;
                            y = (y - 1 + dim) % dim;
                            v[x][y] |= 1;
                        }
                        else{
                            v[x][y] |= 8;
                            x = (x - 1 + dim) % dim;
                            v[x][y] |= 2;
                        }
                        
                        dir = dir^m[x][y];
                        length++;
                        
                    }while(x != i or y != j or dir != startdir);
                    
                    if(length >= threshold) f << length << " ";
                    numLoops++;
                }
            }
        }
        
        f << "\n";
        fnum << numLoops << "\n";
    }
    
    f.close();
    fnum.close();
}


void mirrors_triangle(int dim, long iterations){
    
    random_device rd;
    mt19937 mt(rd());
    uniform_real_distribution<double> dist(0,1);
    
    int v[dim][dim];
    int m[dim][dim];
    int x,y,dir,startdir;
    long length, maxlength, longest, numLoops;
    double n;
    
    
    ofstream f;
   
    f.open("triangle.txt",ios_base::app);
    
    
    for(double p1 = 0; p1 <= 0.5; p1 += 0.05){
        for(double p2 = p1; p2 <= 1.01 - p1; p2 += 0.05){
            
            numLoops = 0;
            longest = 0;
            cout << p1 << " " << p2 << endl;

            for(int iter = 0; iter < iterations; iter++){
                
                maxlength = 0;
                
                for(int i = 0; i < dim; i++){
                    for(int j = 0; j < dim; j++){
                        
                        n = dist(mt);
                        if(n < p1) m[i][j] = 3;
                        else if(n < p1 + p2 ) m[i][j] = 1;
                        else m[i][j] = 0;
                        v[i][j] = 0;
                    }
                }
                
                for(int i = 0; i < dim; i++){
                    for(int j = 0; j < dim; j++){
                        
                        while((v[i][j] & 15) != 15){
                            
                            x = i;
                            y = j;
                            length = 0;
                            startdir = find_free_edge(v[i][j]);
                            dir = startdir;
                            
                            do{
                                if(dir == 0){
                                    v[x][y] |= 1;
                                    y = (y + 1) % dim;
                                    v[x][y] |= 4;
                                }
                                else if(dir == 1){
                                    v[x][y] |= 2;
                                    x = (x + 1) % dim;
                                    v[x][y] |= 8;
                                }
                                else if(dir == 2){
                                    v[x][y] |= 4;
                                    y = (y - 1 + dim) % dim;
                                    v[x][y] |= 1;
                                }
                                else{
                                    v[x][y] |= 8;
                                    x = (x - 1 + dim) % dim;
                                    v[x][y] |= 2;
                                }
                                
                                dir = dir^m[x][y];
                                length++;
                                
                            }while(x != i or y != j or dir != startdir);
                            
                            if(length > maxlength) maxlength = length;

                            numLoops++;
                        }
                    }
                }
                longest += maxlength;
            }
            
            f << p1 << " " << p2 << " " << numLoops/iterations << " " << longest/iterations << "\n";
        }
    }
    f.close();
}






int main(int argc, const char * argv[]) {

    
    rw_matching_top(1024, 1000);
    
    return 0;

    }
