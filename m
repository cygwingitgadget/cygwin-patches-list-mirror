From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: cygpath: print windows/system directories
Date: Wed, 17 May 2000 10:27:00 -0000
Message-id: <200005171727.NAA10177@envy.delorie.com>
X-SW-Source: 2000-q2/msg00059.html

We can still work on other ways to deal with these directories, but I
had this patch hanging around and it might be useful to someone.
Objections?

2000-05-17  DJ Delorie  <dj@cygnus.com>

	* cygpath.cc: add --windir/--sysdir options
	* utils.sgml: and document them

Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.3
diff -p -3 -r1.3 cygpath.cc
*** cygpath.cc	2000/04/13 05:23:30	1.3
--- cygpath.cc	2000/05/17 17:26:07
*************** static struct option long_options[] =
*** 35,40 ****
--- 35,42 ----
    { (char *) "file", required_argument, (int *) &file_arg, 'f'},
    { (char *) "version", no_argument, NULL, 'v' },
    { (char *) "windows", no_argument, NULL, 'w' },
+   { (char *) "windir", no_argument, NULL, 'W' },
+   { (char *) "sysdir", no_argument, NULL, 'S' },
    { 0, no_argument, 0, 0 }
  };
  
*************** Usage: %s [-p|--path] (-u|--unix)|(-w|--
*** 48,53 ****
--- 50,57 ----
    -f|--file file	read file for path information\n\
    -u|--unix     	print Unix form of filename\n\
    -w|--windows  	print Windows form of filename\n\
+   -W|--windir 	 	print `Windows' directory\n\
+   -S|--sysdir 	 	print `system' directory\n\
    -p|--path     	filename argument is a path\n",
  	   prog_name);
    exit (status);
*************** main (int argc, char **argv)
*** 115,120 ****
--- 119,125 ----
    int c;
    int options_from_file_flag;
    char *filename;
+   char buf[MAX_PATH], buf2[MAX_PATH];
  
    prog_name = strrchr (argv[0], '/');
    if (prog_name == NULL)
*************** main (int argc, char **argv)
*** 126,132 ****
    unix_flag = 0;
    windows_flag = 0;
    options_from_file_flag = 0;
!   while ((c = getopt_long (argc, argv, (char *) "hac:f:opuvw", long_options, (int *) NULL))
  	 != EOF)
      {
        switch (c)
--- 131,137 ----
    unix_flag = 0;
    windows_flag = 0;
    options_from_file_flag = 0;
!   while ((c = getopt_long (argc, argv, (char *) "hac:f:opSuvwW", long_options, (int *) NULL))
  	 != EOF)
      {
        switch (c)
*************** main (int argc, char **argv)
*** 163,175 ****
  	  windows_flag = 1;
  	  break;
  
  	case 'h':
  	  usage (stdout, 0);
  	  break;
  
  	case 'v':
  	  printf ("Cygwin pathconv version 1.0\n");
! 	  printf ("Copyright 1998 Cygnus Solutions\n");
  	  exit (0);
  
  	default:
--- 168,192 ----
  	  windows_flag = 1;
  	  break;
  
+ 	case 'W':
+ 	  GetWindowsDirectory(buf, MAX_PATH);
+ 	  cygwin_conv_to_posix_path(buf, buf2);
+ 	  printf("%s\n", buf2);
+ 	  exit(0);
+ 
+ 	case 'S':
+ 	  GetSystemDirectory(buf, MAX_PATH);
+ 	  cygwin_conv_to_posix_path(buf, buf2);
+ 	  printf("%s\n", buf2);
+ 	  exit(0);
+ 
  	case 'h':
  	  usage (stdout, 0);
  	  break;
  
  	case 'v':
  	  printf ("Cygwin pathconv version 1.0\n");
! 	  printf ("Copyright 1998,1999,2000 Cygnus Solutions\n");
  	  exit (0);
  
  	default:
Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.2
diff -p -3 -r1.2 utils.sgml
*** utils.sgml	2000/04/19 00:55:19	1.2
--- utils.sgml	2000/05/17 17:26:07
*************** or if you know what everything is alread
*** 66,75 ****
--- 66,78 ----
  <screen>
  Usage: cygpath [-p|--path] (-u|--unix)|(-w|--windows) filename
         cygpath [-v|--version]
+        cygpath [-W|--windir|-S|--sysdir]
    -u|--unix     print UNIX form of filename
    -w|--windows  print Windows form of filename
    -p|--path     filename argument is a path
    -v|--version  print program version
+   -W|--windir   print windows directory
+   -S|--sysdir   print system directory
  </screen>
  
  <para>The <command>cygpath</command> program is a utility that
