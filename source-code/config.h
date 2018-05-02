/* software configuration file
 *
 * This file contains some definitions that are shared through all the program modules.
 * 林博仁(Buo-ren, Lin) <Buo.Ren.Lin@gmail.com> © 2018
 */

#ifndef CONFIG_H
	#define PACKAGE "hello-c-world"
	#define APPLICATION_NAME "Hello C World"

	#define BUGREPORT_ADDRESS "https://github.com/Lin-Buo-Ren/hello-c-world/issues"

	#ifndef INSTALLATION_PREFIX
		#define INSTALLATION_PREFIX "/usr/local"
	#endif

	#ifndef LOCALEDIR
		#define LOCALEDIR INSTALLATION_PREFIX"/share/locale"
	#endif

	#define CONFIG_H
#endif
