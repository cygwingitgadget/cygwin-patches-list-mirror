Return-Path: <cygwin-patches-return-5644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5264 invoked by alias); 7 Sep 2005 21:27:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5247 invoked by uid 22791); 7 Sep 2005 21:27:37 -0000
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 07 Sep 2005 21:27:37 +0000
Received: from buzzy-box (hmm-dca-ap03-d12-119.dial.freesurf.nl [62.100.11.119])
	by green.qinip.net (Postfix) with SMTP
	id 2DB8245A7; Wed,  7 Sep 2005 23:27:31 +0200 (MET DST)
Message-ID: <n2m-g.dfnqh4.3vv7psd.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [patch] Don't append extra NUL to registry-strings.
References: <n2m-g.dfddna.3vvbaub.1@buzzy-box.bavag> <SERRANOF2fPmsSVhGOD000000e6@SERRANO.CAM.ARTIMI.COM>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.7.0 KorrNews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <SERRANOF2fPmsSVhGOD000000e6@SERRANO.CAM.ARTIMI.COM>
Date: Wed, 07 Sep 2005 21:27:00 -0000
X-SW-Source: 2005-q3/txt/msg00099.txt.bz2

Op Mon, 5 Sep 2005 11:31:28 +0100 schreef Dave Korn
in <SERRANOF2fPmsSVhGOD000000e6@SERRANO.CAM.ARTIMI.COM>:
:  ----Original Message----
: > From: Buzz
[Dave Korn:]
: >>    To me this is the even more important reason.  Some registry strings
: >>  do include the trailing zero, some don't;
: >
: > I don't see how this could be.
:
:    Because internally (native API) the registry stores NT-style
:  UNICODE_STRING structures, which have an explicit length count.  See also 

I see.

:  http://www.sysinternals.com/Information/TipsAndTrivia.html#HiddenKeys
[Names of registry-strings can contain \0.]

This is not relevant, as it concerns the names of registry-keys, not
their value. As we're using RegQueryValueEx, we won't be seeing those
hidden entries.

:  http://blogs.msdn.com/oldnewthing/archive/2004/08/24/219444.aspx
[Actually anything in the registery turns out to be a counted array of
bytes, and the type-indicator is just a hint... :-( ]

This, however is to the point, and another reason to regret ever using
MS software.

Patch retracted.

Regtool may need fixing, though, if I understand the above correctly...
...Yes, it does.


utils/ChangeLog entry:

2005-09-07  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* regtool.cc: Extend copyright-years.
	(print_version): Ditto.
	(cmd_list): Don't depend on terminating '\0' being present on
	string-values.
	(cmd_get): Don't attempt to read more than present, but keep
	extra space for terminating '\0'. Really output REG_BINARY.
	Don't leak memory.
	(cmd_set): Include trailing '\0' in string's length.


--- src/winsup/utils/regtool.cc	27 Feb 2005 17:55:54 -0000	1.17
+++ src/winsup/utils/regtool.cc	7 Sep 2005 19:54:41 -0000
@@ -1,6 +1,6 @@
 /* regtool.cc
 
-   Copyright 2000, 2001, 2002, 2003, 2004 Red Hat Inc.
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005 Red Hat Inc.
 
 This file is part of Cygwin.
 
@@ -138,7 +138,7 @@ print_version ()
   printf ("\
 %s (cygwin) %.*s\n\
 Registry Tool\n\
-Copyright 2000, 2001, 2002 Red Hat, Inc.\n\
+Copyright 2000, 2001, 2002, 2003, 2004, 2005 Red Hat, Inc.\n\
 Compiled on %s\n\
 ", prog_name, len, v, __DATE__);
 }
@@ -398,6 +398,7 @@ cmd_list ()
 	m = maxvalnamelen + 1;
 	n = maxvaluelen + 1;
 	RegEnumValue (key, i, value_name, &m, 0, &t, (BYTE *) value_data, &n);
+	value_data[n] = 0;
 	if (!verbose)
 	  printf ("%s\n", value_name);
 	else
@@ -515,11 +516,11 @@ cmd_set ()
 			  sizeof (v));
       break;
     case KT_STRING:
-      rv = RegSetValueEx (key, value, 0, REG_SZ, (const BYTE *) a, strlen (a));
+      rv = RegSetValueEx (key, value, 0, REG_SZ, (const BYTE *) a, strlen (a) + 1);
       break;
     case KT_EXPAND:
       rv = RegSetValueEx (key, value, 0, REG_EXPAND_SZ, (const BYTE *) a,
-			  strlen (a));
+			  strlen (a) + 1);
       break;
     case KT_MULTI:
       for (i = 1, n = 1; argv[i]; i++)
@@ -569,15 +570,14 @@ cmd_get ()
   rv = RegQueryValueEx (key, value, 0, &vtype, 0, &dsize);
   if (rv != ERROR_SUCCESS)
     Fail (rv);
-  dsize++;
-  data = (char *) malloc (dsize);
+  data = (char *) malloc (dsize + 1);
   rv = RegQueryValueEx (key, value, 0, &vtype, (BYTE *) data, &dsize);
   if (rv != ERROR_SUCCESS)
     Fail (rv);
   switch (vtype)
     {
     case REG_BINARY:
-      fwrite (data, dsize, 0, stdout);
+      fwrite (data, dsize, 1, stdout);
       break;
     case REG_DWORD:
       printf ("%lu\n", *(DWORD *) data);
@@ -593,6 +593,7 @@ cmd_get ()
 	  bufsize = ExpandEnvironmentStrings (data, 0, 0);
 	  buf = (char *) malloc (bufsize + 1);
 	  ExpandEnvironmentStrings (data, buf, bufsize + 1);
+	  free (data);
 	  data = buf;
 	}
       printf ("%s\n", data);


[I suppose other types should be checked for correct size as well...]

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
