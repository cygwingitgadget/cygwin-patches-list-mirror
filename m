Return-Path: <cygwin-patches-return-1791-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27635 invoked by alias); 25 Jan 2002 18:06:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27620 invoked from network); 25 Jan 2002 18:06:46 -0000
Message-ID: <006c01c1a5cb$0782a0b0$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <02b901c1a58d$11e86820$a100a8c0@mchasecompaq> <1011955697.18203.27.camel@lifelesswks> <000901c1a58f$58a46640$a100a8c0@mchasecompaq> <20020125172432.GD27965@redhat.com>
Subject: Re: [PATCH]Package extention recognition (revision 2)
Date: Fri, 25 Jan 2002 10:06:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00148.txt.bz2

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, January 25, 2002 09:24
Subject: Re: [PATCH]Package extention recognition (revision 2)


> On Fri, Jan 25, 2002 at 02:59:17AM -0800, Michael A Chase wrote:
> >And that test is still there, I moved it into the if () so something like
> >".tar.bz2" wouldn't trigger the return .... : 0;  If all the ifs fail,
> >return 0; still occurs.
>
> Hmm.  Seems like someone has "improved" this code from when I wrote it.

Is the "improved" version my change or the way I found it?

> My version checked for a trailing component.  If it existed, it returned
> the index into the string.
>
> This version sort of does the same thing but if there is a .tar.bz2
> anywhere in the string prior to trailing component, it will fail
> regardless of whether the filename ends with .tar .tar.gz or .tar.bz2.
>
> Perhaps that is an acceptable risk but it puzzles me why anyone would
> move from an algorithm that was foolproof to one that wasn't.

I can go either way.  It is hard for me to imagine foo-0.0.tar.bz2.tar.gz
being valid, but my patched version would accept it while the original
version would reject it.  Neither version is fool proof for some values of
fool; both would pass foo-0.0.tar.gz.tar.bz2.  If you like I can move the
'(end - ext) == x' test back to the 'return' statement.

The trailing ';' on the 'if' statements still have to go or the ".tar" check
will never be executed.

I hope I'm more articulate after taking my nap.

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

--- filemanip.cc-0 Thu Jan 24 16:43:57 2002
+++ filemanip.cc Fri Jan 25 02:26:39 2002
@@ -66,13 +66,14 @@ find_tar_ext (const char *path)
 {
   char *end = strchr (path, '\0');
   /* check in longest first order */
-  char *ext = strstr (path, ".tar.bz2");
-  if (ext)
-    return (end - ext) == 8 ? ext - path : 0;
-  if ((ext = strstr (path, ".tar.gz")));
-  return (end - ext) == 7 ? ext - path : 0;
-  if ((ext = strstr (path, ".tar")));
-  return (end - ext) == 4 ? ext - path : 0;
+  char *ext;
+  if ((ext = strstr (path, ".tar.bz2")) && (end - ext) == 8)
+    return ext - path;
+  if ((ext = strstr (path, ".tar.gz")) && (end - ext) == 7)
+    return ext - path;
+  if ((ext = strstr (path, ".tar")) && (end - ext) == 4)
+    return ext - path;
+  return 0;
 }

 /* Parse a filename into package, version, and extension components. */


