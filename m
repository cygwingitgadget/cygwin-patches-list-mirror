From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: setup's list of sites
Date: Thu, 18 May 2000 12:54:00 -0000
Message-id: <200005181954.PAA26096@envy.delorie.com>
X-SW-Source: 2000-q2/msg00062.html

Objections?  Comments?

2000-05-18  DJ Delorie  <dj@cygnus.com>

	* setup.c (optionprompt): allow multi-column, clean up message
	about more options, be more robust about user input.
	(getdownloadsource): make the mirror URL a macro.
	(main): do mounts after done prompting user.

Index: setup.c
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/setup.c,v
retrieving revision 1.43
diff -p -3 -r1.43 setup.c
*** setup.c	2000/05/02 05:00:22	1.43
--- setup.c	2000/05/18 19:53:10
***************
*** 36,45 ****
  #include "strarry.h"
  #include "zlib/zlib.h"
  
  #define CYGNUS_KEY "Software\\Cygnus Solutions"
  #define DEF_ROOT "C:\\cygwin"
  #define DOWNLOAD_SUBDIR "latest/"
! #define SCREEN_LINES 25
  #define COMMAND9X "command.com /E:4096 /c "
  
  #ifndef NFILE_LIST
--- 36,48 ----
  #include "strarry.h"
  #include "zlib/zlib.h"
  
+ #define MIRRORFILE " http://sourceware.cygnus.com/cygwin/mirrors.html "
+ 
  #define CYGNUS_KEY "Software\\Cygnus Solutions"
  #define DEF_ROOT "C:\\cygwin"
  #define DOWNLOAD_SUBDIR "latest/"
! #define SCREEN_LINES 23
! #define SCREEN_COLS 80
  #define COMMAND9X "command.com /E:4096 /c "
  
  #ifndef NFILE_LIST
*************** prompt (const char *text, const char *de
*** 492,549 ****
  static int
  optionprompt (const char *text, SA * options)
  {
!   size_t n, response = -1;
    char buf[5];
    size_t base;
! 
!   n = 0;
  
!   do
      {
!       char *or;
!       enum
!       { CONTINUE, REPEAT, ALL }
!       mode;
  
!       base = n;
!       if (!base)
! 	puts (text);
  
!       for (n = 0; n < SCREEN_LINES - 2 && (n + base) < options->count; ++n)
! 	printf ("\t%d. %s\n", n + 1, options->array[n + base]);
  
!       if ((n + base) < options->count)
  	{
! 	  mode = CONTINUE;
! 	  or = " or [continue]";
  	}
!       else if (options->count > SCREEN_LINES - 2)
  	{
! 	  mode = REPEAT;
! 	  or = " or [repeat]";
  	}
!       else
  	{
! 	  mode = ALL;
! 	  or = "";
  	}
-       printf ("Select an option from 1-%d%s: ", n, or);
-       if (!fgets (buf, sizeof (buf), stdin))
- 	continue;
  
!       if (mode == CONTINUE && (!isalnum (*buf) || strchr ("cC", *buf)))
! 	continue;
!       else if (mode == REPEAT && (!isalnum (*buf) || strchr ("rR", *buf)))
  	{
! 	  n = 0;
! 	  continue;
  	}
  
-       response = atoi (buf);
      }
-   while (response < 1 || response > n);
- 
-   return base + response - 1;
  }
  
  static int
--- 495,567 ----
  static int
  optionprompt (const char *text, SA * options)
  {
!   size_t n, c, response = -1;
    char buf[5];
    size_t base;
!   int maxwidth=0, ncols, skip, percol;
  
!   for (n=0; n<options->count; n++)
      {
!       int sl = strlen(options->array[n]);
!       if (maxwidth < sl)
! 	maxwidth = sl;
!     }
!   ncols = SCREEN_COLS / (maxwidth + 5);
!   skip = (options->count + ncols - 1) / ncols;
!   printf("count = %d   ncols = %d   skip = %d\n",
! 	 options->count, ncols, skip);
!   percol = SCREEN_COLS / ncols;
  
!   base = 0;
  
!   puts (text);
  
!   while (1)
!     {
!       char *repeat, *enter;
! 
!       for (n=0; n < SCREEN_LINES; n++)
  	{
! 	  if (n + base >= options->count)
! 	    break;
! 	  for (c=0; c<ncols; c++)
! 	    {
! 	      int i = n + base + c * SCREEN_LINES;
! 	      if (i < options->count)
! 		printf("%2d. %-*s", i+1, percol-5, options->array[i]);
! 	    }
! 	  printf("\n");
  	}
! 
!       repeat = enter = "";
!       if (skip > SCREEN_LINES)
  	{
! 	  if (base)
! 	    repeat = " or `R' to repeat the list";
! 	  if (base + SCREEN_LINES*ncols < options->count)
! 	    enter = " or [Enter] for more options";
  	}
! 
!       printf ("Select an option from 1-%d%s%s: ", options->count, repeat, enter);
!       if (!fgets (buf, sizeof (buf), stdin))
  	{
! 	  /* This can only mean end-of-file, user has gone away */
! 	  exit(1);
  	}
  
!       response = atoi(buf);
!       if (response >= 1 && response <= options->count)
! 	return response - 1;
! 
!       if (buf[0] == 'c' || buf[0] == 'C' || buf[0] == '\r' || buf[0] == '\n')
  	{
! 	  if (base + SCREEN_LINES * ncols < options->count)
! 	    base += SCREEN_LINES * ncols;
  	}
+       if (buf[0] == 'r' || buf[0] == 'R')
+ 	base = 0;
  
      }
  }
  
  static int
*************** getdownloadsource ()
*** 1213,1220 ****
        exit (1);
      }
  
!   if (!geturl (" http://sourceware.cygnus.com/cygwin/mirrors.html ",
! 	       filename, 1))
      fputs ("Unable to retrieve the list of cygwin mirrors.\n", stderr);
    else
      {
--- 1231,1237 ----
        exit (1);
      }
  
!   if (!geturl (MIRRORFILE, filename, 1))
      fputs ("Unable to retrieve the list of cygwin mirrors.\n", stderr);
    else
      {
*************** those as the basis for your installation
*** 1517,1527 ****
  
        Sleep (0);
  
-       /* Create the root directory. */
-       mkdirp (root);		/* Ignore any return value since it may
- 				   already exist. */
-       mkmount (wd, "", root, "/", 1);
- 
        pkgstuff = get_pkg_stuff (root, updating);
  
        update =
--- 1534,1539 ----
*************** those as the basis for your installation
*** 1550,1555 ****
--- 1562,1572 ----
  	  xfree (dir);
  	}
        xfree (update);
+ 
+       /* Create the root directory. */
+       mkdirp (root);		/* Ignore any return value since it may
+ 				   already exist. */
+       mkmount (wd, "", root, "/", 1);
  
        /* Make the root directory the current directory so that recurse_dirs
  	 will * extract the packages into the correct path. */
