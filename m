Return-Path: <cygwin-patches-return-1875-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31835 invoked by alias); 20 Feb 2002 22:03:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31765 invoked from network); 20 Feb 2002 22:03:25 -0000
Message-ID: <20020220220324.95101.qmail@web20008.mail.yahoo.com>
Date: Wed, 20 Feb 2002 14:13:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: New file for winsup/utils
To: cygwin-patches@cygwin.com
Cc: Robert Collins <robert.collins@itdomain.com.au>
In-Reply-To: <005501c1b9f7$0928e420$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-503233784-1014242604=:95080"
X-SW-Source: 2002-q1/txt/msg00232.txt.bz2

--0-503233784-1014242604=:95080
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1981

OK, here is a new util:

Usage mkshortcut.exe [OPTION]... TARGET 
NOTE: All filename arguments must be in unix (POSIX) format
  -a|--arguments=ARGS   use arguments ARGS 
  -h|--help             output usage information and exit
  -i|--icon             icon file for link to use
  -j|--iconoffset       offset of icon in icon file (default is 0)
  -n|--name             name for link (defaults to TARGET)
  -v|--version          output version information and exit
  -A|--allusers         use 'All Users' instead of current user for -D,-P
  -D|--desktop          create link relative to 'Desktop' directory
  -P|--smprograms       create link relative to Start Menu 'Programs' directory

For example:
./mkshortcut -a '-rv -e /bin/bash --login -i' -D /bin/rxvt
creates a shortcut to rxvt with bash login on the Desktop.

This will allow the creation of Windows shortcuts from scripts or batch
files. My goal is to include this in the cygwin package so that it can be
used from setup.exe to create the cygwin bash shortcuts (allowing the 
removal of mklink.c and much (more) of desktop.cc), and used from packages
to create shortcuts to executables, manuals, FAQs, websites, etc. Changelog:

2001-02-20 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

* mkshortcut.c: new file, utility to create shortcuts from scripts
* utils.sgml: updated to include mkshortcut

--- Robert Collins <robert.collins@itdomain.com.au> wrote:
> 
> ===
> ----- Original Message ----- 
> From: "Joshua Franklin" <joshuadfranklin@yahoo.com>
> 
> > I've written a program that does just this. It's a
> > fully scriptable and can set icons. I'm 
> > hoping to get it included in cygwin sometime, but
> > I'm waiting until the new setup.exe comes out to 
> > bother developers with it. In the meantime, you can
> > get it at:
> 
> Why are you waiting? 
> 
> Rob
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
--0-503233784-1014242604=:95080
Content-Type: text/plain; name="mkshortcut.c"
Content-Description: mkshortcut.c
Content-Disposition: inline; filename="mkshortcut.c"
Content-length: 7250

/* mkshortcut.c -- create a Windows shortcut 
   Copyright 2002 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. 

Written by Joshua Daniel Franklin

Exit values
	1: user error (syntax error)
	2: system error (out of memory, etc.)
	3: windows error (interface failed)
*/

#define NOCOMATTRIBUTE

#include <shlobj.h>
#include <olectlid.h>
#include <stdio.h>
#include <getopt.h>

static char *prog_name;
static char *argument_arg, *name_arg;
static int icon_flag, unix_flag, windows_flag;
static int allusers_flag, desktop_flag, smprograms_flag;

static struct option long_options[] =
{
  { "arguments", required_argument, NULL, 'a'},
  { "help", no_argument, NULL, 'h'},
  { "icon", required_argument, NULL, 'i'},
  { "iconoffset", required_argument, NULL, 'j'},
  { "name", required_argument, NULL, 'n'},
  { "version", no_argument, NULL, 'v'},
  { "allusers", no_argument, NULL, 'A'},
  { "desktop", no_argument, NULL, 'D'},
  { "smprograms", no_argument, NULL, 'P'},
  { NULL, 0, NULL, 0 }
};
  
static void
usage (FILE *stream, int status)
{
  fprintf (stream, "\
Usage %s [OPTION]... TARGET \n\
NOTE: All filename arguments must be in unix (POSIX) format\n\
  -a|--arguments=ARGS	use arguments ARGS \n\
  -h|--help		output usage information and exit\n\
  -i|--icon		icon file for link to use\n\
  -j|--iconoffset	offset of icon in icon file (default is 0)\n\
  -n|--name		name for link (defaults to TARGET)\n\
  -v|--version		output version information and exit\n\
  -A|--allusers		use 'All Users' instead of current user for -D,-P\n\
  -D|--desktop		create link relative to 'Desktop' directory\n\
  -P|--smprograms	create link relative to Start Menu 'Programs' directory\
", prog_name);
  exit (status);
}

int
main (int argc, char **argv)
{
  LPITEMIDLIST id;
  HRESULT hres;
  IShellLink *sl;
  IPersistFile *pf;
  WCHAR widepath[MAX_PATH];

  int opt, tmp, offset;
  char *args, *str2, *str1;
  char lname[MAX_PATH], exename[MAX_PATH], dirname[MAX_PATH], iconname[MAX_PATH];

  prog_name = strrchr (argv[0], '/');
  if (prog_name == NULL)
    prog_name = strrchr (argv[0], '\\');
  if (prog_name == NULL)
    prog_name = argv[0];
  else
    prog_name++;

  offset=0;
  icon_flag=0;
  unix_flag=0;
  windows_flag=0;
  allusers_flag=0;
  desktop_flag=0;
  smprograms_flag=0;

  while ( (opt = getopt_long(argc, argv, (char *) "a:i:j:n:hvADP", long_options, NULL) ) != EOF)
  {
    switch(opt)
      {
      case 'a':
	argument_arg = optarg;
	break;
      case 'h':
	usage(stdout, 0);
	break;
      case 'i':
	icon_flag=1;
	cygwin_conv_to_full_win32_path(optarg, iconname);
	break;
      case 'j':
	if (!icon_flag)
	  usage(stderr, 1); 
	offset = atoi(optarg);
	break;
      case 'n':
	name_arg = optarg;
	break;
      case 'v':
	printf ("Cygwin shortcut creator version 1.0\n");
	printf ("Copyright 2002 Red Hat, Inc.\n");
	exit(0);
      case 'A':
	allusers_flag=1;
	break;
      case 'D':
	if (smprograms_flag)
	  usage(stderr,1);
	desktop_flag=1;
	break;
      case 'P':
	if (desktop_flag)
	  usage(stderr,1);
	smprograms_flag=1;
	break;
      default:
	usage(stderr, 1);
	break;
      }
  }

  if (optind != argc - 1)
    usage (stderr, 1);

  // If there's a colon in the TARGET, it should be a URL
  if ( strchr(argv[optind], ':') != NULL)
  {
    // Nope, somebody's trying a W32 path 
    if (argv[optind][1] == ':')
      usage(stderr,1);
    strcpy(exename, argv[optind]);
    dirname[0]='\0';  //No working dir for URL
  }
  else
  {
    strcpy(str1, argv[optind]);
    cygwin_conv_to_full_win32_path(str1, exename);

    // Get a working dir from the exepath
    str1 = strrchr(exename, '\\');
    tmp = strlen (exename) - strlen (str1);
    strncpy (dirname, exename, tmp);
    dirname[tmp]='\0';
  }

  // Generate a name for the link if not given
  if (name_arg == NULL)
  {
    // Strip trailing /'s if any
    str2 = str1 = argv[optind];
    tmp = strlen(str1) - 1;
    while ( strrchr(str1,'/') == (str1+tmp) )
    {
      str1[tmp]='\0';
      tmp--;
    }
    // Get basename
    while (*str1)
    {
      if (*str1 == '/')
        str2 = str1 + 1;
      str1++;
    }
  }
  else 
  {
    // User specified a name, so check it and convert 
    if ( desktop_flag || smprograms_flag)
    {
      // Absolute path not allowed on Desktop/SM Programs
      if (name_arg[0] == '/')
        usage(stderr, 1); 
    }
    // Sigh. Another W32 path
    if ( strchr(name_arg, ':') != NULL)
      usage(stderr,1);
    cygwin_conv_to_win32_path(name_arg, str2);
  }
  
  // Add suffix to link name if necessary
  if (strlen(str2) > 4)
  {
    tmp = strlen(str2) - 4;
    if (strncmp (str2+tmp, ".lnk", 4) != 0 )
      strcat (str2, ".lnk");
  }
  else strcat (str2, ".lnk");
  strcpy (lname, str2);

  // Prepend relative path if necessary 
  if (desktop_flag) 
  {
    if (!allusers_flag)
      SHGetSpecialFolderLocation(NULL, CSIDL_DESKTOPDIRECTORY,&id);
    else
      SHGetSpecialFolderLocation(NULL, CSIDL_COMMON_DESKTOPDIRECTORY,&id);
    SHGetPathFromIDList(id, lname);
    // Make sure Win95 without "All Users" has output 
    if ( strlen(lname) == 0 ) {
      SHGetSpecialFolderLocation(NULL, CSIDL_DESKTOPDIRECTORY,&id);
      SHGetPathFromIDList(id, lname);
    }
    strcat(lname, "\\");
    strcat(lname, str2);
  }

  if (smprograms_flag)
  {
    if (!allusers_flag)
      SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);
    else
      SHGetSpecialFolderLocation(NULL, CSIDL_COMMON_PROGRAMS, &id);
    SHGetPathFromIDList(id, lname);
    // Make sure Win95 without "All Users" has output 
    if ( strlen(lname) == 0 ) {
      SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);
      SHGetPathFromIDList(id, lname);
    }
    strcat(lname, "\\");
    strcat(lname, str2);
  }

  // Beginning of Windows interface
  hres=OleInitialize(NULL);
  if (hres != S_FALSE && hres != S_OK) 
  {
    fprintf(stderr, "%s: Could not initialize OLE interface\n", prog_name);
    exit(3);
  }

  hres = CoCreateInstance(&CLSID_ShellLink, NULL, CLSCTX_INPROC_SERVER, &IID_IShellLink, (void **) &sl);
  if (SUCCEEDED(hres)) 
  {
    hres = sl->lpVtbl->QueryInterface(sl, &IID_IPersistFile, (void **) &pf);
    if (SUCCEEDED(hres)) 
    {
      sl->lpVtbl->SetPath (sl, exename);
cygwin_conv_to_full_posix_path(exename, str1);
      sl->lpVtbl->SetDescription (sl, str1);
      sl->lpVtbl->SetWorkingDirectory (sl, dirname);
      if (argument_arg) sl->lpVtbl->SetArguments (sl, argument_arg);
      if (icon_flag) sl->lpVtbl->SetIconLocation (sl, iconname, offset);

      // Make link name Unicode-compliant 
      MultiByteToWideChar (CP_ACP, 0, lname, -1, widepath, MAX_PATH);
      hres = pf->lpVtbl->Save (pf, widepath, TRUE);
      if (!SUCCEEDED(hres)) 
      {
        fprintf(stderr, "%s: Save to persistant storage failed (Does the directory you are writing to exist?)\n", prog_name);
        exit(3);
      }
      pf->lpVtbl->Release (pf);
      sl->lpVtbl->Release (sl);
    }
    else 
    {
      fprintf(stderr, "%s: QueryInterface failed\n", prog_name);
      exit(3);
    }
  }
  else 
  {
    fprintf(stderr, "%s: CoCreateInstance failed\n", prog_name);
    exit(3);
  }
}

--0-503233784-1014242604=:95080
Content-Type: text/html; name="utils.sgml-patch"
Content-Description: utils.sgml-patch
Content-Disposition: inline; filename="utils.sgml-patch"
Content-length: 2645

--- utils.sgml-orig	Wed Feb 20 14:58:47 2002
+++ utils.sgml	Wed Feb 20 15:28:43 2002
@@ -303,6 +303,50 @@ local machine or the default (or given) 
 
 </sect2>
 
+<sect2 id="mkshortcut"><title>mkshortcut</title>
+
+<screen>
+Usage mkshortcut.exe [OPTION]... TARGET 
+NOTE: All filename arguments must be in unix (POSIX) format
+  -a|--arguments=ARGS   use arguments ARGS 
+  -h|--help             output usage information and exit
+  -i|--icon             icon file for link to use
+  -j|--iconoffset       offset of icon in icon file (default is 0)
+  -n|--name             name for link (defaults to TARGET)
+  -v|--version          output version information and exit
+  -A|--allusers         use 'All Users' instead of current user for -D,-P
+  -D|--desktop          create link relative to 'Desktop' directory
+  -P|--smprograms       create link relative to Start Menu 'Programs' directory
+</screen>
+
+<para> <command>mkshortcut</command> is a command-line interface 
+to the creation of Windows shortcut (OLE link) files. It exists mainly to
+aid in the creation of shortcuts in scripts or batch files.</para>
+
+<example><title>Creating shortcuts to rxvt</title>
+<screen>
+<prompt>$</prompt> <userinput>mkshortcut -a '-e /bin/bash --login -i' /bin/rxvt.exe </userinput>
+<prompt>$</prompt> <userinput>mkshortcut -a '-rv -sl 5000 -tn rxvt -fn "FixedSys" -e /bin/bash --login -i' -n "My rxvt shortcut" -i /bin/rxvt.exe -j 1 -D /bin/rxvt.exe </userinput>
+</screen>
+</example>
+
+<para>In the first example, a simple shortcut to the rxvt terminal emulator is
+created in the current directory. The <literal>-a</literal> option gives the
+shortcut the arguments to create an interactive login bash shell. The default 
+name of the new shortcut is created from the basename of the executable plus the
+win32 ".lnk" extension, so in this case will be "rxvt.lnk". The second example
+is functionally similar but demonstrates some of <command>mkshortcut</command>'s
+ options.  First, more options are passed to rxvt (reverse color, scrollback 
+lines, terminal name, default font to use). Also a name for the new shortcut is 
+specified with the <literal>-n</literal> option. The filename will be "My rxvt
+shortcut.lnk" Note that shortcut names can 
+and often do contain spaces. The <literal>-i</literal> and <literal>-j</literal>
+ options control the shortcut's icon, in this case the second icon in the
+rxvt executable (icons are offset from 0). Finally, the <literal>-D</literal>
+option makes the icon appear on the Desktop instead of the current directory.
+</para>
+</sect2>
+
 <sect2 id="passwd"><title>passwd</title>
 
 <screen>

--0-503233784-1014242604=:95080--
