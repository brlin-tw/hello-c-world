/* The main program of hello-c-world executable
 *
 * This program prints a simple greeting message to the C world.
*/

/* Software global configuration */
#include "config.h"

/* For puts(3) */
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
	puts(_("Hello C world!"));

	/* --- */

	/* Application information */
	/* - Additionally add a newline to separate the main output body */
	putchar('\n');

	/* - Application name */
	printf(_("The \"%s\" application\n"), _(APPLICATION_NAME));

	/* - Author attribution */
	printf (_("Written by %s, et. al..\n"),
        /* TRANSLATORS: This is a proper name.  See the gettext
           manual, section Names.  Note this is actually a non-ASCII
           name: The first name, "博仁" is (with Unicode escapes)
           "\u535A\u4EC1" or (with HTML entities) "&#x535a;&#x4ec1;".
           Pronunciation is like "博(buo)-仁(ren), 林(Lin)".  */
        _("林博仁(Buo-ren, Lin)"));

	/* - Bug report address */
	/* TRANSLATORS: The placeholder indicates the bug-reporting address
   for this package.  Please add _another line_ saying
   "Report translation bugs to <...>\n" with the address for translation
   bugs (typically your translation team's web or email address).  */
	printf(_("Report bugs to <%s>.\n"), BUGREPORT_ADDRESS);

	/* Leaving */
	return EXIT_SUCCESS;
}
