/* The main program of hello-c-world executable
 *
 * This program prints a simple greeting message to the C world.
*/

/* Software global configuration */
#include "config.h"

/* For input/output routines like puts(3) etc. */
#include <stdio.h>

/* For EXIT_* exit status constants */
#include <stdlib.h>

/* For internationalization support */
#include <libintl.h>

/* Short hand function for gettext(3) */
#define _(String) gettext (String)

/* For setlocale(3) */
#include <locale.h>

/* For support of finding the executable location(relocatable support) */
#include <whereami.h>

/* For library dynamic loading support */
#include <dlfcn.h>

int main(int argc, char** argv){
	void *library_handle;
	char *dynamic_load_error;
	/* int WAI_PREFIX(getExecutablePath)(char* out, int capacity, int* dirname_length); */
	int (*wai_getExecutablePath)(char*, int, int*);

	char* executable_path = NULL;
	int executable_path_length, executable_dirname_length;

	library_handle = dlopen("library.so", RTLD_LAZY);
	if (! library_handle){
		fprintf(stderr, "%s\n", dlerror());
		exit(EXIT_FAILURE);
	}

	/* Clear any existing error */
	dlerror();

	*(void **) (&wai_getExecutablePath) = dlsym(library_handle, "wai_getExecutablePath");

	/* Relocatable support */
	/* - Fetch required string length */
	executable_path_length = wai_getExecutablePath(
		NULL
		, 0
		, &executable_dirname_length
	);
	if(!executable_path_length){
		fprintf(
			stderr,
			"FATAL: Failed to determine executable path length.\n"
		);
		return EXIT_FAILURE;
	}
	executable_path = (char*)malloc(executable_path_length + 1);
	wai_getExecutablePath(
		executable_path,
		executable_path_length,
		&executable_dirname_length
	);
	executable_path[executable_path_length] = '\0';

	printf("Executable path: %s\n", executable_path);

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
