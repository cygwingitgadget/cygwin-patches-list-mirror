Return-Path: <cygwin-patches-return-4504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25359 invoked by alias); 15 Dec 2003 11:55:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25348 invoked from network); 15 Dec 2003 11:55:32 -0000
Message-ID: <3FDDA282.3000600@att.net>
Date: Mon, 15 Dec 2003 11:55:00 -0000
From: David Fritz <zeroxdf@att.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: enable argument permutation by default for getopt_long() and not
 getopt() [PATCH] (was Re: getopt() musings)
Content-Type: multipart/mixed;
 boundary="------------080809080207070807050601"
X-SW-Source: 2003-q4/txt/msg00223.txt.bz2

This is a multi-part message in MIME format.
--------------080809080207070807050601
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 10488

I have moved this discussion to cygwin-patches as it seemed appropriate. 
For reference, the original thread is here: 
http://sources.redhat.com/ml/cygwin/2003-11/msg00865.html

Max Bowsher wrote:

<snip>
 > It does require someone to put in a fair amount of time:
 >
 > 1) Resolving the uncertainties you mention.

I was hoping someone that has been on the GNU scene longer than I would 
chime in on my assumptions. But open source has its benefits:

I checked the glibc CVS repository. The initial revision of 
/libc/posix/getopt.c 
(http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/libc/posix/getopt.c?rev=1.1&content-type=text/plain&cvsroot=glibc) 
was checked in on 1992-05-12 (11+ years ago).

Argument permutation was enabled by default. The first copyright date in 
the file is 1987. I do not know where to get the older versions. 
Regardless, it would appear that argument permutation has been the 
default for a very long time, if not always.

It would not seem unreasonable to me to conclude that Cygwin's 
getopt_long() is non-standard, if one considers GNU precedent 
'standard'. And since, AFAIK, they invented it, I don't know of any 
other metric by which to judge compliance.

I also checked the NetBSD CVS repository. The initial revision of 
/src/lib/libc/stdlib/getopt_long.c 
(http://cvsweb.netbsd.org/bsdweb.cgi/~checkout~/src/lib/libc/stdlib/getopt_long.c?rev=1.1&content-type=text/plain) 
was checked in on 1999-07-23.

It appears that argument permutation was not supported in the initial 
revision. However, with revision 1.4 
(http://cvsweb.netbsd.org/bsdweb.cgi/~checkout~/src/lib/libc/stdlib/getopt_long.c?rev=1.4&content-type=text/plain) 
on 2000-04-02 the implementation was replaced with the initial version 
of what is now the current implementation. (Also the implementation from 
which Cygwin's is derived.) In this version argument permutation is 
implemented and enabled by default. This leaves an ~8 month time span 
where NetBSD's CVS repository included a version of getopt_long() that 
did not support argument permutation (and was incompatible with it's GNU 
template).

According to the page entitled "The History of the NetBSD Project" 
(http://www.netbsd.org/Misc/history.html), NetBSD 1.4.1 and 1.4.2 were 
released during this time period. I could not find any mention of 
getopt_long() in the change logs for those releases (nor in the logs for 
1.4 and 1.4.3). The change log for NetBSD 1.5 mentions the inclusion of 
the latter version of getopt_long().

     libc: add getopt_long(3) from Dieter Baron and Thomas Klausner.
         [christos 20000402]

Just to be sure, I checked the source archives for 1.4, 1.4.1, 1.4.2 and 
1.4.3; they did not include an implementation of getopt_long(). So I 
don't think the incompatible version of getopt_long() was ever released 
as part of NetBSD.


 > 2) Finding out what permutation broke in the first place.

After a review of the mailing list archives, it seems that of primary 
concern were programs that took a shell command as an argument. For example,

$ foo x bar -y

Where it is intended to pass the option 'x' to foo and the option 'y' to 
bar (which is invoked by foo). With argument permutation, both 'x' and 
'y' would be passed to foo. As if it had been

$ foo x y bar

One program specifically mentioned as being broken by argument 
permutation was strace. (I'd link to the messages but many of the 
discussions took place on cygwin-developers and the web-based archives 
for that list are no longer publicly accessible.) It seems strace was 
the impetus for this change, but it was said that the worry was not 
specifically with strace but rather any program that might break because 
of the non-standard behavior. An expressed desire was not to "cause 
people problems or generate unnecessary cygwin email traffic."

I do understand the desire to conform to the relevant standards, even 
without forcing users to define POSIXLY_CORRECT. However, I would note 
that the change itself has caused problems 
(http://sources.redhat.com/ml/cygwin/2002-06/msg01253.html) and 
generated traffic 
(http://sources.redhat.com/ml/cygwin/2002-09/msg00165.html, 
http://sources.redhat.com/ml/cygwin/2003-01/msg01742.html).

strace is a program that comes with Cygwin. The current version of 
strace uses getopt_long() and does not explicitly disable argument 
permutation. I attribute this to the fact that strace was changed to use 
getopt_long() instead of getopt() after Cygwin's getopt_long() had been 
neutered. Otherwise this would invalidate my pervious assumption, but I 
do believe that this is an oversight in strace.

This would seem to introduce a new twist: programs that were developed 
with Cygwin's weird version of getopt_long() might break. I have looked 
through the programs in Cygwin's utils subdirectory and it seems that 
ssp is also affected. I have attached a patch for ssp and strace that 
disables argument permutation by specifying a '+' as the first character 
of the short option string.

Another interesting thing about strace is that it is a mingw executable. 
It is statically linked to the copy of getopt_long() in 
/usr/lib/mingw/libmingwex.a.

Both /src/winsup/cygwin/getopt.c and /src/winsup/mingw/mingwex/getopt.c 
would need to be patched.

<side note>

Apart from argument permutation, another side effect of inverting 
POSIXLY_CORRECT semantics came up in this thread: 
http://sources.redhat.com/ml/cygwin/2002-07/msg02227.html.

The GNU extended version of getopt() and getopt_long() support a feature 
whereby "If the first character of optstring is `-', then each 
non-option argv-element is handled as if it were the argument of an 
option with character code 1." The so called 'return-in-order' feature.

As noted in a comment in the source code for the NetBSD implementation 
(again, from which Cygwin's is derived), GNU getopt() supports this 
feature regardless of whether or not POSIXLY_CORRECT is defined. The 
NetBSD implementation does not support this when POSIXLY_CORRECT is defined.

In a follow-up to the above mentioned message on Wed, 31 Jul 2002 
00:02:19 -0400 cgf said:

 > AFAICT, this is a GNU getopt specific feature.  Cygwin doesn't use GNU
 > getopt.
 >
 > If you want to send a patch to get this working with cygwin, however,
 > we'll cheerfully accept it.
 >
 > cgf

I believe that Cygwin's getopt() does support this, it's just disabled. 
It could be re-enable by removing the test for POSIXLY_CORRECT when 
deciding whether or not to enable this feature.

It's a non-standard feature as far as getopt() is concerned. One might 
reasonably expect it to work with getopt_long(), though.

It seems fairly innocuous to me and given the above (albeit old) 
statement by cgf, I have re-enabled it in the attached patch.

With the patch getopt*() will support the feature regardless of the 
definition of POSIXLY_CORRECT or POSIXLY_INCORRECT_GETOPT, just like GNU.

</side note>

 > 3) Making the necessary tweaks

A patch that implements the change is attached.

I have tested it with a recent CVS checkout and it seems to work.

Note that I do not currently have a copyright assignment on file with 
Red Hat. I am unsure if the patch is sufficiently complex that it would 
require one. I could submit an assignment if necessary.

 > 4) Verifying nothing is broken.

This is the hard part. For one, it was not until recently that getopt() 
and getopt_long() were moved (back?) into the DLL proper. Previously, 
they had been statically linked. So any packages or locally installed 
programs that have not been rebuilt since the change would be unaffected 
and any breakage would go unnoticed until they were rebuilt. However, 
given that it appears that argument permutation has been the default 
with getopt_long() (and indeed the GNU implementation of getopt()) for 
quite some time if not always, it seems, AFAICT, unlikely that 
re-enabling it for getopt_long() would break anything. Except, perhaps, 
for the previously mentioned caveat of programs developed with Cygwin's 
modified getopt_long().

Many of the programs I thought to try are unaffected by the change, 
either because they haven't been updated since getopt() was moved into 
the DLL (grep, find) or because they already support argument 
permutation, presumably because they were built with their own copy of 
getopt_long() (fileutils, textutils, diff). But some programs support 
argument permutation that previously did not (wget, file, the programs 
in winsup/utils). Further, I've verified that argument permutation is 
still disabled by default for programs that use getopt() (and not 
getopt_long()).

It turns out that very few of the programs currently distributed with 
Cygwin are linked dynamically to the copy of getopt() or getopt_long() 
in cygwin1.dll. (Well, at least very few of the programs that I have 
installed, anyway. I currently have 190 packages installed but there are 
quite a few packages that I do not have installed and have not checked 
or tested.) Here is the list of .exe files in my /bin directory that are 
dynamically linked to cygwin1.dll's getopt():

cal.exe
col.exe
column.exe
ipcs.exe
lpr.exe
mcookie.exe
namei.exe
readlink.exe
rev.exe
whois.exe

and likewise for getopt_long():

cygpath.exe
fc-cache.exe
fc-list.exe
file.exe
getfacl.exe
getopt.exe
kill.exe
mkgroup.exe
mkpasswd.exe
mount.exe
passwd.exe
ps.exe
regtool.exe
setfacl.exe
shutdown.exe
ssp.exe
umount.exe
wget.exe

So this would seem to be a mostly forward-looking change.

I'm eager to hear what others think.

Cheers,
David Fritz

 >
 > I think its a worthwhile cause, but I don't have the time to dedicate 
to it
 > just right now.
 >
 >
 > Max.

ChangeLog entries for the atached patches:

cygwin-getopt-patch.diff:

2003-12-15  David Fritz  <zeroxdf@att.net>

     * getopt.c: Enable argument permutation by default for
     getopt_long() and not for getopt().
     Support 'return-in-order' feature regardless of the definition
     of POSIXLY_CORRECT or POSIXLY_INCORRECT_GETOPT.


mingw-getopt-patch.diff:

2003-12-15  David Fritz  <zeroxdf@att.net>

     * mingwex/getopt.c: Enable argument permutation by default for
     getopt_long() and not for getopt().
     Support 'return-in-order' feature regardless of the definition
     of POSIXLY_CORRECT or POSIXLY_INCORRECT_GETOPT.


ssp-strace-patch.diff:

2003-12-15  David Fritz  <zeroxdf@att.net>

     * strace.cc: Disable command-line argument permutation.
     * ssp.cc: Ditto.





--------------080809080207070807050601
Content-Type: text/plain;
 name="cygwin-getopt-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-getopt-patch.diff"
Content-length: 1615

Index: getopt.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/getopt.c,v
retrieving revision 1.5
diff -u -p -r1.5 getopt.c
--- getopt.c	16 Sep 2003 03:39:55 -0000	1.5
+++ getopt.c	15 Dec 2003 07:56:52 -0000
@@ -70,15 +70,18 @@ __weak_alias(getopt_long,_getopt_long)
 extern char *__progname;
 #endif
 
+static int using_long;
+
 #define IGNORE_FIRST	(*options == '-' || *options == '+')
 #define PRINT_ERROR	((opterr) && ((*options != ':') \
 				      || (IGNORE_FIRST && options[1] != ':')))
 
-#define IS_POSIXLY_CORRECT (getenv("POSIXLY_INCORRECT_GETOPT") == NULL)
+#define IS_POSIXLY_CORRECT (using_long ? (getenv("POSIXLY_CORRECT") != NULL) : \
+                                (getenv("POSIXLY_INCORRECT_GETOPT") == NULL))
 
 #define PERMUTE         (!IS_POSIXLY_CORRECT && !IGNORE_FIRST)
-/* XXX: GNU ignores PC if *options == '-' */
-#define IN_ORDER        (!IS_POSIXLY_CORRECT && *options == '-')
+/* XXX: GNU ignores PC if *options == '-'; and now so do we */
+#define IN_ORDER        (*options == '-')
 
 /* return values */
 #define	BADCH	(int)'?'
@@ -347,6 +350,8 @@ getopt(nargc, nargv, options)
 	_DIAGASSERT(nargv != NULL);
 	_DIAGASSERT(options != NULL);
 
+	using_long = 0;
+
 	if ((retval = getopt_internal(nargc, nargv, options)) == -2) {
 		++optind;
 		/*
@@ -383,6 +388,8 @@ getopt_long(nargc, nargv, options, long_
 	_DIAGASSERT(options != NULL);
 	_DIAGASSERT(long_options != NULL);
 	/* idx may be NULL */
+
+	using_long = 1;
 
 	if ((retval = getopt_internal(nargc, nargv, options)) == -2) {
 		char *current_argv, *has_equal;

--------------080809080207070807050601
Content-Type: text/plain;
 name="mingw-getopt-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mingw-getopt-patch.diff"
Content-length: 1643

Index: getopt.c
===================================================================
RCS file: /cvs/src/src/winsup/mingw/mingwex/getopt.c,v
retrieving revision 1.2
diff -u -p -r1.2 getopt.c
--- getopt.c	3 Mar 2003 10:27:57 -0000	1.2
+++ getopt.c	15 Dec 2003 07:57:58 -0000
@@ -69,15 +69,18 @@ __weak_alias(getopt_long,_getopt_long)
 extern char __declspec(dllimport) *__progname;
 #endif
 
+static int using_long;
+
 #define IGNORE_FIRST	(*options == '-' || *options == '+')
 #define PRINT_ERROR	((opterr) && ((*options != ':') \
 				      || (IGNORE_FIRST && options[1] != ':')))
 
-#define IS_POSIXLY_CORRECT (getenv("POSIXLY_INCORRECT_GETOPT") == NULL)
+#define IS_POSIXLY_CORRECT (using_long ? (getenv("POSIXLY_CORRECT") != NULL) : \
+                                (getenv("POSIXLY_INCORRECT_GETOPT") == NULL))
 
 #define PERMUTE         (!IS_POSIXLY_CORRECT && !IGNORE_FIRST)
-/* XXX: GNU ignores PC if *options == '-' */
-#define IN_ORDER        (!IS_POSIXLY_CORRECT && *options == '-')
+/* XXX: GNU ignores PC if *options == '-'; and now so do we */
+#define IN_ORDER        (*options == '-')
 
 /* return values */
 #define	BADCH	(int)'?'
@@ -346,6 +349,8 @@ getopt(nargc, nargv, options)
 	_DIAGASSERT(nargv != NULL);
 	_DIAGASSERT(options != NULL);
 
+	using_long = 0;
+
 	if ((retval = getopt_internal(nargc, nargv, options)) == -2) {
 		++optind;
 		/*
@@ -382,6 +387,8 @@ getopt_long(nargc, nargv, options, long_
 	_DIAGASSERT(options != NULL);
 	_DIAGASSERT(long_options != NULL);
 	/* idx may be NULL */
+
+	using_long = 1;
 
 	if ((retval = getopt_internal(nargc, nargv, options)) == -2) {
 		char *current_argv, *has_equal;

--------------080809080207070807050601
Content-Type: text/plain;
 name="ssp-strace-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ssp-strace-patch.diff"
Content-length: 1145

Index: ssp.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/ssp.c,v
retrieving revision 1.7
diff -u -p -r1.7 ssp.c
--- ssp.c	26 Apr 2003 21:52:03 -0000	1.7
+++ ssp.c	15 Dec 2003 07:59:25 -0000
@@ -39,7 +39,9 @@ static struct option longopts[] =
   {NULL, 0, NULL, 0}
 };
 
-static char opts[] = "cdehlstvV";
+/* Specify '+' as the first character of the short option string to
+   disable argument permutation. */
+static char opts[] = "+cdehlstvV";
 
 #define KERNEL_ADDR 0x77000000
 
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/strace.cc,v
retrieving revision 1.28
diff -u -p -r1.28 strace.cc
--- strace.cc	26 Apr 2003 21:52:03 -0000	1.28
+++ strace.cc	15 Dec 2003 07:59:28 -0000
@@ -870,7 +870,9 @@ struct option longopts[] = {
   {NULL, 0, NULL, 0}
 };
 
-static const char *const opts = "b:dhfm:no:p:S:tTuvw";
+/* Specify '+' as the first character of the short option string to
+   disable argument permutation. */
+static const char *const opts = "+b:dhfm:no:p:S:tTuvw";
 
 static void
 print_version ()

--------------080809080207070807050601--
