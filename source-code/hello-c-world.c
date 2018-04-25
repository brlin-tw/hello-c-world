/* The main program of hello-c-world executable
 *
 * This program prints a simple greeting message to the C world.
*/

/* For printf(3) */
#include <stdio.h>

/* For EXIT_SUCCESS constant */
#include <stdlib.h>

int main(int argc, char** argv){
	printf("Hello C world!\n");
	return EXIT_SUCCESS;
}
