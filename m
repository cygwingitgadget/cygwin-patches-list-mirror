Return-Path: <cygwin-patches-return-1782-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13120 invoked by alias); 25 Jan 2002 09:45:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13106 invoked from network); 25 Jan 2002 09:45:23 -0000
Message-ID: <021701c1a584$f9371f90$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.com> <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq> <1011948812.18172.17.camel@lifelesswks>
Subject: Re: [PATCH]Package extention recognition (revision 1)
Date: Fri, 25 Jan 2002 01:45:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00139.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>
Cc: <cygwin-patches@cygwin.com>
Sent: Friday, January 25, 2002 00:53
Subject: Re: [PATCH]Package extention recognition (revision 1)


> On Fri, 2002-01-25 at 13:58, Michael A Chase wrote:
> > ----- Original Message -----
> > From: "Christopher Faylor" <cgf@redhat.com>
> > To: <cygwin-patches@cygwin.com>
> > Sent: Thursday, January 24, 2002 17:51
> > Subject: Re: [PATCH]Package extention recognition
> >
> >
> > > On Thu, Jan 24, 2002 at 05:48:35PM -0800, Michael A Chase wrote:
> > > >I noticed that find_tar_ext() always returns after checking for
> > ".tar.bz2"
> > > >and ".tar.gz" so it never gets to the check for ".tar".  As long as I
was
> > > >fixing that, it seemed like a good time to add ".cwp" as an accepted
file
> > > >extension.
> > >
> > > Haven't we already debated this issue?  I don't see any reason to
inflict
> > > a .cwp on the world and I can't imagine why we'd ever want a plain
.tar
> > > rather than a .tar.bz2.
> >
> > The last discussion I saw on ".cwp" kind of wandered off when someone
> > offered a patch that was more complicated than necessary.  It seemed
like a
> > good idea (along with .deb or rpm) to avoid the next round of 'Why
doesn't
> > the install I did with WinZip not work?', but I can easily change the
patch
> > remove both.
>
> .cwp was an idea to avoid Winzip users - but .bz2 does that too, as will
> deb or rpm. The previous patch wasn't rejected due to complexity, but
> due to incompleteness - it was a partial factoring, but didn't make the
> code easier to maintain or extend, as generic magic number support
> (which is present now) does. (ie when you pass a stream to
> archive::open, the extension doesn't matter, only the content. Ditto for
> decompressing.

".bz2" only 'protects' WinZip users until WinZip starts handling bzip2
files.  That may never happen, but ".cwp" (or ".rpm" or ".deb") isn't
vulnerable to WinZip improvements.

> > The current un-patched code leaves off ".tar" inadvertently.
>
> If that is the filemanip code, it seems fine to me, or perhaps you got
> your patch arguments the wrong way around for that file?
>
> Ok, some feedback: strdup is deprecated except where it's needed to
> interface with a C-library that deallocates via the malloc family.. Use
> new char[n+1] and strcpy. Eventually we'll either roll our own string
> class, grab an existing one, or use the STL.
>
> Regarding the source file tests, that approach looks ok. Long term it
> will be something like:
> find a binary,
> extract metadata,
> check for the source file(s) (which are explicitly named in the
> metadata).
>
> I'll apply the lot if you'll
> 1) cleanup the strduping,

The strdup() was in one of the lines I didn't change.  I'll change it.
While I'm at it, I'll look for other strdup() calls in the file and change
them as well.

> 2) Answer my query about filemanip.

The '-' lines below are from the unpatched filemanip.cc.  Notice the ';' at
the end of the 'if' lines.  That causes the return after the ".tar.gz" 'if'
statement to always be executed.  As a result, the test for ".tar" never
gets executed.

My original patch (which I forgot to attach to the first message) included a
test for ".cwp" to test the waters.  Should I add it back?  If I do, should
I also add ".rpm", and ".deb"?

--- filemanip.cc-0 Thu Jan 24 16:43:57 2002
+++ filemanip.cc Thu Jan 24 16:22:08 2002
@@ -69,10 +69,12 @@ find_tar_ext (const char *path)
   char *ext = strstr (path, ".tar.bz2");
   if (ext)
     return (end - ext) == 8 ? ext - path : 0;
-  if ((ext = strstr (path, ".tar.gz")));
-  return (end - ext) == 7 ? ext - path : 0;
-  if ((ext = strstr (path, ".tar")));
-  return (end - ext) == 4 ? ext - path : 0;
+  if ((ext = strstr (path, ".tar.gz")))
+    return (end - ext) == 7 ? ext - path : 0;
+  return 0;
 }

 /* Parse a filename into package, version, and extension components. */

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

