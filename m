Return-Path: <cygwin-patches-return-1829-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 862 invoked by alias); 2 Feb 2002 02:05:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 848 invoked from network); 2 Feb 2002 02:05:07 -0000
Message-ID: <001301c1ab8d$fc224f90$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <021a01c1ab6b$8ec39fc0$0200a8c0@lifelesswks>
Subject: Re: For the curious: Setup.exe char-> String patch
Date: Fri, 01 Feb 2002 18:05:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00186.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Sent: Friday, February 01, 2002 13:58
Subject: For the curious: Setup.exe char-> String patch


> This is what I'm preparing to commit. I'm mailing it here as a preview,
> because doing the changelog is going to take.... some time. (160Kb diff
> to wade through).
>
> The cstr_oneuse() is designed to allow efficient (via caching, not
> implemented yet) leak-safe char * usage of a string. An equivalent
> wcstr_oneuse() can be implemented to expose a wide char variant. (The
> underlying encoding of the string class will eventually be UTF-8/UTF-16
> or something similar).
>
> I haven't implemented substrings yet, which is why the large number of
> .cstr_oneuse() calls and a few non-converted routines.
>
> Anyway, it's all working for me: ].

I only saw two possible real problems.  Everything else is a matter of
consistency which I could send you a patch for after this is implemented.

1.  In String++.cc, I think 0 may be returned for a character in the first
position since the for loop starts with i=0.

2.  In geturl.cc, I think you are deleting a char[] after changing the
pointer.

String++.cc:

+// does this character exist in the string?
+// 0 is false, 1 is the first position...
+size_t
+String::find(char aChar) const
+{
+  for (size_t i=0; i < theData->length; ++i)
+    if (theData->theString[i] == aChar)
+      return i;
+  return 0;

### Won't this return 0 if aChar is in the first position in
theData->theString?

String++.h:

### Do you want String::concat() and String::vconcat to be public?  The few
places I see them being used could be ... String ("first") + next + next ...
You lose a little efficiency by not calling String::concat, but you make up
some of it by not having to call String::cstr_oneuse().

archive.cc:

- if (io_stream::mkpath_p (PATH_TO_FILE, destfilename))
- {log (LOG_TIMESTAMP, "Failed to make the path for %s", destfilename);
+ if (io_stream::mkpath_p (PATH_TO_FILE, destfilename.cstr_oneuse()))
+ {log (LOG_TIMESTAMP, "Failed to make the path for %s",
destfilename.cstr_oneuse());

### To be consistent with other log() calls in this file change the last
line to:
+ {log (LOG_TIMESTAMP, String ("Failed to make the path for ") +
destfilename);

- if (io_stream::mkpath_p (PATH_TO_FILE, destfilename))
- {log (LOG_TIMESTAMP, "Failed to make the path for %s", destfilename);
+ if (io_stream::mkpath_p (PATH_TO_FILE, destfilename.cstr_oneuse()))
+ {log (LOG_TIMESTAMP, "Failed to make the path for %s",
destfilename.cstr_oneuse());

### To be consistent with other log() calls in this file change the last
line to:
+ {log (LOG_TIMESTAMP, String ("Failed to make the path for ") +
destfilename);

desktop.cc:

-  fname = concat (path, "/", title, ".pif", 0); /* check for a pif as well
*/
+  fname = String::concat (path, "/", title.cstr_oneuse(), ".pif", 0); /*
check for a pif as well */

### To avoid exposing String::concat() change last line to:
+  fname = String (path) + "/" + title + ".pif"; /* check for a pif as well
*/

-  fname = concat (path, "/", title, ".pif", 0); /* check for a pif as well
*/
+  fname = String::concat (path, "/", title.cstr_oneuse(), ".pif", 0); /*
check for a pif as well */

### To avoid exposing String::concat() change last line to:
+  fname = String (path) + "/" + title + ".pif"; /* check for a pif as well
*/

download.cc:

+       log (LOG_TIMESTAMP, "Downloaded %s", local.cstr_oneuse());

### To minimize the use of log( level, format, ....), change the line to:
+       log (LOG_TIMESTAMP, String ("Downloaded ") + local);

geturl.cc:

 static void
-init_dialog (char const *url, int length, HWND owner)
+init_dialog (String const url, int length, HWND owner)
 {
   if (is_local_install)
     return;

-  char const *sl = url;
+  char const *sl = url.cstr();
   char const *cp;
-  for (cp = url; *cp; cp++)
+  for (cp = sl; *cp; cp++)
     if (*cp == '/' || *cp == '\\' || *cp == ':')
       sl = cp + 1;
   max_bytes = length;
@@ -71,6 +74,7 @@ init_dialog (char const *url, int length
   Progress.SetText3("Connecting...");
   Progress.SetBar1(0);
   start_tics = GetTickCount ();
+  delete[] sl;
 }

### Is that delete[] safe?  You've been changing sl repeatedly in the for
loop.

- log (LOG_BABBLE, "get_url_to_membuf %s", _url);
+  log (LOG_BABBLE, "get_url_to_membuf %s", _url.cstr_oneuse());

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_BABBLE, String ("get_url_to_membuf ") + _url);

-  log (LOG_BABBLE, "get_url_to_file %s %s", _url, _filename);
+  log (LOG_BABBLE, "get_url_to_file %s %s", _url.cstr_oneuse(),
_filename.cstr_oneuse());

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_BABBLE, String ("get_url_to_file ") + _url + " " + _filename);

localdir.cc:

-  log (0, "Selected local directory: %s", local_dir);
-  if (SetCurrentDirectoryA (local_dir))
+  log (LOG_TIMESTAMP, "Selected local directory: %s",
local_dir.cstr_oneuse());
+  if (SetCurrentDirectoryA (local_dir.cstr_oneuse()))

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_TIMESTAMP, String ("Selected local directory: ") + local_dir);

main.cc:

+  log (LOG_TIMESTAMP, "Current Directory: %s", cwd);

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_TIMESTAMP, String ("Current Directory: ") + local_dir);

log.cc/log.h:

### If I understand the change, a log line may be either timestamped or
babble.  So a line can't be timestamped and only go to setup.log.full.
Likewise all lines in setup.log must be timestamped.  I think we are losing
some useful capablities by changing from flags to level.

mount.cc:

### It looks like it might be cleaner to make String cygpath (String const
&) visible along with String cygpath (const char *, ...).  It seems like
nearly every place I saw it used you are doing cygpath
(xxx.cstr_oneuse(),0).

### The few places that involve concatenation could be handled by
String()+x+...  I'm willing to make a patch to catch any leftovers so String
cygpath( const char *, ...) could be dropped.

package_meta.cc:

-       log (LOG_BABBLE, "unlink %s", d);
-       SetFileAttributes (d, dw & ~FILE_ATTRIBUTE_READONLY);
-       DeleteFile (d);
+       log (LOG_BABBLE, String("unlink ")+ d.cstr_oneuse());
+       SetFileAttributes (d.cstr_oneuse(), dw & ~FILE_ATTRIBUTE_READONLY);
+       DeleteFile (d.cstr_oneuse());

### I don't think .cstr_oneuse() is needed for log():
+       log (LOG_BABBLE, String("unlink ") + d);

site.cc:

-    log (0, "site: %s", site_list[n]->url);
+    log (LOG_TIMESTAMP, "site: %s", site_list[n]->url.cstr_oneuse());

### To minimize the use of log( level, format, ....), change the line to:
+    log (LOG_TIMESTAMP, String ("site: ") + site_list[n]->url);

-  log (0, "Adding site: %s", other_url);
+  log (LOG_BABBLE, "Adding site: %s", other_url.cstr_oneuse());

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_BABBLE, String ("Adding site: ") + other_url);

source.cc:

-  log (0, "source: %s",
+  log (LOG_TIMESTAMP, "source: %s",

### To minimize the use of log( level, format, ....), change the line to:
+  log (LOG_TIMESTAMP, String ("source: ") +

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

