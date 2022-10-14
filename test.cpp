#include <cstddef>
#include <iostream>
#include <iterator>
#include <unistd.h>
#include <sys/wait.h>




using namespace std;



int main(){
    int arr[] = {1, 2, 3, 4, 1, 2};
    int arrSize = sizeof(arr) / sizeof(int);
    int start, end;
    int fd[2] = {};

    int id = fork();

    if (not id) {
        start = 0;
        end = arrSize / 2;
    }else {
        start = arrSize / 2;
        end = arrSize;
    }

    int sum = 0;
    for (int i = start; i < end; i++ ) {
        sum += arr[i];
    }

    cout << "Partial sum: " << sum << endl;
    if (not id) {
        close(fd[0]);
        if (write(fd[1], &sum, sizeof(sum)) == -1){
            cout << "Problem with write" << endl;
        }
        close(fd[1]);
    }else{
        wait(nullptr);
        int gotSum = 0;
        close(fd[1]);
        if (read(fd[0], &gotSum, sizeof(int)) == -1){
            cout << "Problem with read" << endl;
        }
        close(fd[0]);
        cout << "Total sum is " << sum+gotSum << endl;

    }
    return 0;

}

