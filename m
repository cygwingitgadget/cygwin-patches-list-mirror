From: David Peterson <David.Peterson@mail.idrive.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: new option for cygpath.exe
Date: Thu, 01 Feb 2001 09:20:00 -0000
Message-id: <B1F282D5B226D411B8B900E08110486F0451AC@sweetness.idrive.com>
X-SW-Source: 2001-q1/msg00045.html

Thu Feb 01 09:00:00 2001  David Peterson <chief@mail.idrive.com>

	* cygpath.cc: add option to output windows paths in
	different formats including UNC, DOS, and "mixed".
	(main): process options
	(doit): check new options flags


Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.7
diff -u -p -r1.7 cygpath.cc
--- cygpath.cc	2000/10/28 05:00:00	1.7
+++ cygpath.cc	2001/02/01 17:12:07
@@ -23,7 +23,8 @@ static char *prog_name;
 static char *file_arg;
 static char *close_arg;
 static int path_flag, unix_flag, windows_flag, absolute_flag;
-static int shortname_flag, ignore_flag;
+static int shortname_flag, ignore_flag, unc_flag, mixed_flag;
+static char *windows_format_arg;
 
 static struct option long_options[] =
 {
@@ -37,6 +38,7 @@ static struct option long_options[] =
   { (char *) "version", no_argument, NULL, 'v' },
   { (char *) "windows", no_argument, NULL, 'w' },
   { (char *) "short-name", no_argument, NULL, 's' },
+  { (char *) "type", required_argument, (int *) &windows_format_arg, 't' },
   { (char *) "windir", no_argument, NULL, 'W' },
   { (char *) "sysdir", no_argument, NULL, 'S' },
   { (char *) "ignore", no_argument, NULL, 'i' },
@@ -48,13 +50,18 @@ usage (FILE *stream, int status)
 {
   if (!ignore_flag || !status)
     fprintf (stream, "\
-Usage: %s [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name])
filename\n\
+Usage: %s [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]
[-t|--type type]) filename\n\
   -a|--absolute		output absolute path\n\
   -c|--close handle	close handle (for use in captured process)\n\
   -f|--file file	read file for path information\n\
   -u|--unix		print Unix form of filename\n\
   -w|--windows		print Windows form of filename\n\
   -s|--short-name	print Windows short form of filename\n\
+  -t|--type		print Windows form of filename with specified
type\n\
+                        requires -a or --absolute, type is one of the
following:\n\
+      dos 		    drive letter with back-slashes (C:\\WINNT)\n\
+      unc		    UNC style (//C/WINNT)\n\
+      mixed		    drive letter with forward-slashes (C:/WINNT)\n\
   -W|--windir		print `Windows' directory\n\
   -S|--sysdir		print `system' directory\n\
   -p|--path		filename argument is a path\n\
@@ -128,7 +135,7 @@ get_short_name (const char *filename)
   {
     fprintf (stderr, "%s: out of memory\n", prog_name);
     exit (1);
-  }
+  } 
   if (GetShortPathName (filename, sbuf, len) == ERROR_INVALID_PARAMETER)
   {
     fprintf (stderr, "%s: cannot create short name of %s\n", prog_name,
filename);
@@ -138,6 +145,55 @@ get_short_name (const char *filename)
 }
 
 static void
+convert_slashes (char* name)
+{
+	while (*name != '\0')
+	{
+		if (*name == '\\')
+			*name = '/';
+		name++;
+	}
+}
+
+static char*
+get_unc_name (const char *filename)
+{
+	int len = strlen(filename);
+	char* unc_buf = (char *) calloc(len + 2, 1);
+
+	if (unc_buf == NULL)
+	{
+      fprintf (stderr, "%s: out of memory\n", prog_name);
+      exit (1);
+	}
+
+	memcpy(unc_buf + 3, filename + 2, len - 2);
+	convert_slashes(unc_buf + 3);
+
+	unc_buf[0] = '/';
+	unc_buf[1] = '/';
+	unc_buf[2] = filename[0];
+
+	return unc_buf;
+}
+
+static char*
+get_mixed_name (const char* filename)
+{
+	char* mixed_buf = strdup(filename);
+	
+	if (mixed_buf == NULL)
+	{
+      fprintf (stderr, "%s: out of memory\n", prog_name);
+      exit (1);
+	}
+
+	convert_slashes(mixed_buf);
+
+	return mixed_buf;
+}
+
+static void
 doit (char *filename)
 {
   char *buf;
@@ -193,8 +249,14 @@ doit (char *filename)
       else
 	{
 	  (absolute_flag ? cygwin_conv_to_full_win32_path :
cygwin_conv_to_win32_path) (filename, buf);
+
 	  if (shortname_flag)
 	    buf = get_short_name (buf);
+
+	  if (unc_flag)
+		  buf = get_unc_name (buf);
+	  else if (mixed_flag)
+		  buf = get_mixed_name (buf);
 	}
     }
 
@@ -219,9 +281,11 @@ main (int argc, char **argv)
   unix_flag = 0;
   windows_flag = 0;
   shortname_flag = 0;
+  unc_flag = 0;
+  mixed_flag = 0;
   ignore_flag = 0;
   options_from_file_flag = 0;
-  while ((c = getopt_long (argc, argv, (char *) "hac:f:opsSuvwWi",
long_options, (int *) NULL))
+  while ((c = getopt_long (argc, argv, (char *) "hac:f:opsSuvwt:Wi",
long_options, (int *) NULL))
 	 != EOF)
     {
       switch (c)
@@ -263,6 +327,23 @@ main (int argc, char **argv)
 	    usage (stderr, 1);
 	  shortname_flag = 1;
 	  break;
+
+	case 't':
+		if (unix_flag || !windows_flag || !absolute_flag || (optarg
== NULL))
+			usage (stderr, 1);
+
+		windows_format_arg = ((*optarg == '=') ? (optarg + 1) :
(optarg));
+
+		if (0 == strcmp(windows_format_arg, "unc"))
+			unc_flag = 1;
+		else if (0 == strcmp(windows_format_arg, "mixed"))
+			mixed_flag = 1;
+		else if (0 == strcmp(windows_format_arg, "dos"))
+			;
+		else
+			usage (stderr, 1);
+
+		break;
 
 	case 'W':
 	  GetWindowsDirectory(buf, MAX_PATH);
