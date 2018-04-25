/* The main program of hello-c-world executable
 *
 * This program prints a simple greeting message to the C world.
*/

/* Software global configuration */
#include "config.h"

/* For printf(3) */
#include <stdio.h>

/* For EXIT_SUCCESS constant */
#include <stdlib.h>

/* For internationalization support */
#include <libintl.h>

/* Short hand function for gettext(3) */
#define _(String) gettext (String)

/* For setlocale(3) */
#include <locale.h>

int main(int argc, char** argv){
	/* Initializating I18N */
	/* - Assign program locale */
	setlocale (LC_ALL, "");

	/* - Let gettext function know where the translation data of PACKAGE is */
	/* TODO: If locale data not exist or not set, set LOCALEDIR to EXEDIR */
	bindtextdomain (PACKAGE, LOCALEDIR);

	/* - Specify text domain */
	textdomain (PACKAGE);

	/* --- */

	/* Print greeting Message */
	printf(_("Hello C world!\n"));

	/* --- */

	/* Leaving */
	return EXIT_SUCCESS;
}
