Return-Path: <cygwin-patches-return-4028-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17036 invoked by alias); 27 Jul 2003 23:36:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17018 invoked from network); 27 Jul 2003 23:36:21 -0000
Message-ID: <3F246153.3020504@netscape.net>
Date: Sun, 27 Jul 2003 23:36:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Export argz/envz functions
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030609020804040805020609"
X-SW-Source: 2003-q3/txt/msg00044.txt.bz2


--------------030609020804040805020609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2270

For the last 8 months, I've been running a dll with these functions 
exported.  I've recompiled some gnu apps which utilize these functions, 
such as binutils/libtool and have experienced no adverse side-effects. 
It does mean, however that we decrease code bloat in the apps which link 
to the dll and increase code-sharing, which is good thing.

Here's a quick description of what they are and a link to the relevant 
man pages:

"An argz vector is a pointer to a character buffer together with a 
length. The intended interpretation of the character buffer is array of 
strings, where the strings are separated by NUL bytes. If the length is 
nonzero, the last byte of the buffer must be a NUL."

"An envz vector is a special argz vector, namely one where the strings 
have the form "name=value". Everything after the first '=' is considered 
to be the value. If there is no '=', the value is taken to be NULL. 
(While the value in case of a trailing '=' is the empty string "".) "

http://www.gnu.org/manual/glibc-2.2.5/html_node/Argz-Functions.html
http://www.gnu.org/manual/glibc-2.2.5/html_node/Envz-Functions.html

Since no-one bothered to document the functions for the newlib manual, I 
suggest that we just add the relevant manpages from the linux manpages 
project, since the implementation is compatible.  I'll see about 
contributing proper source documentation in the future so that they get 
documented in the newlib info pages.

So as you've probably gathered, these functions are an invention of 
Glibc, but they have been ported to BSD.  They are also used in quite a 
few gnu packages, if available on the host system.  I find them useful 
and good for glibc interoperability, costing very little in terms of 
overhead.

I was required to make the symbol alias because some configure programs 
look for functions with a "__" prefix, others look for functions without 
the prefix.  Either way, it seems relatively innocuous to make the 
alias, so that's the reasoning behind that.

Can this be considered for last-minute submission to 1.5.1?  Thanks!

Cheers,
Nicholas

BTW- I have ported some more widechar (wcsxfrm) and common functions 
(i.e. basename & dirname) to newlib, and will submit these patches once 
my copyright assignment is processed.

--------------030609020804040805020609
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 357

2003-07-27  Nicholas Wourms  <nwourms@netscape.net>

    * cygwin.din: Export argz_add argz_add_sep argz_append argz_count
    argz_create argz_create_sep argz_delete argz_extract argz_insert
    argz_next argz_replace argz_stringify envz_add envz_entry envz_get 
    envz_merge envz_remove envz_strip
    * include/cygwin/version.h: Bump api minor number.

--------------030609020804040805020609
Content-Type: text/plain;
 name="export-arg-env-z.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export-arg-env-z.patch"
Content-length: 2330

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.92
diff -u -3 -p -r1.92 cygwin.din
--- cygwin.din  25 Jul 2003 16:13:11 -0000  1.92
+++ cygwin.din  27 Jul 2003 23:08:12 -0000
@@ -141,6 +141,30 @@ alarm
 _alarm = alarm
 alphasort
 _alphasort = alphasort
+argz_add
+__argz_add = argz_add
+argz_add_sep
+__argz_add_sep = argz_add_sep
+argz_append
+__argz_append = argz_append
+argz_count
+__argz_count = argz_count
+argz_create
+__argz_create = argz_create
+argz_create_sep
+__argz_create_sep = argz_create_sep
+argz_delete
+__argz_delete = argz_delete
+argz_extract
+__argz_extract = argz_extract
+argz_insert
+__argz_insert = argz_insert
+argz_next
+__argz_next = argz_next
+argz_replace
+__argz_replace = argz_replace
+argz_stringify
+__argz_stringify = argz_stringify
 asctime
 _asctime = asctime
 asctime_r
@@ -362,6 +390,18 @@ endpwent
 _endpwent = endpwent
 endutent
 _endutent = endutent
+envz_add
+__envz_add = envz_add
+envz_entry
+__envz_entry = envz_entry
+envz_get
+__envz_get = envz_get
+envz_merge
+__envz_merge = envz_merge
+envz_remove
+__envz_remove = envz_remove
+envz_strip
+__envz_strip = envz_strip
 erand48
 _erand48 = erand48
 erf
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.125
diff -u -3 -p -r1.125 version.h
--- include/cygwin/version.h    25 Jul 2003 16:13:12 -0000  1.125
+++ include/cygwin/version.h    27 Jul 2003 23:08:12 -0000
@@ -210,12 +210,17 @@ details. */
        88: Export _getreent
        89: Export __mempcpy
        90: Export _fopen64
+       91: Export argz_add argz_add_sep argz_append argz_count argz_create
+         argz_create_sep argz_delete argz_extract argz_insert
+         argz_next argz_replace argz_stringify envz_add envz_entry
+         envz_get envz_merge envz_remove envz_strip
+
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 90
+#define CYGWIN_VERSION_API_MINOR 91
 
      /* There is also a compatibity version number associated with the
    shared memory regions.  It is incremented when incompatible

--------------030609020804040805020609--
