/* See LICENCE file for copyright and license details */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

static void
die(char *s)
{
	fputs(s, stderr);
	exit(EXIT_FAILURE);
}

int
main(int argc, const char *argv[])
{
	int ret = EXIT_FAILURE;
	Display *dpy;
	Window w;
	XWMHints *h;

	if (1 < argc && !strncmp(argv[1], "-v", 2)) {
		puts("hey-"VERSION);
		exit(EXIT_SUCCESS);
	}

	if (!(w = (Window)strtol(getenv("WINDOWID"), NULL, 0)))
		die("hey: WINDOWID environment variable not set, can't determine target window");

	if (!(dpy = XOpenDisplay(NULL)))
		die("hey: couldn't open display");

	if (!(h = XGetWMHints(dpy, w)))
		h = XAllocWMHints();
	if (h == NULL) {
		fputs("hey: unable to get or allocate XWMHints structure", stderr);
		goto early;
	}
		
	h->flags |= XUrgencyHint;

	if ((ret = !XSetWMHints(dpy, w, h)))
		fputs("hey: couldn't set hints on window", stderr);

	XFree(h);
	XSync(dpy, False);
early:
	XCloseDisplay(dpy);

	return ret;
}
