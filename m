Return-Path: <cygwin-patches-return-1783-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25408 invoked by alias); 25 Jan 2002 10:04:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25373 invoked from network); 25 Jan 2002 10:04:28 -0000
Subject: Re: [PATCH]Package extention recognition (revision 1)
From: Robert Collins <robert.collins@itdomain.com.au>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <021701c1a584$f9371f90$a100a8c0@mchasecompaq>
References:
	<003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.
	com> <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq>
	<1011948812.18172.17.camel@lifelesswks> 
	<021701c1a584$f9371f90$a100a8c0@mchasecompaq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Fri, 25 Jan 2002 02:04:00 -0000
Message-Id: <1011953063.18172.21.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2002 10:04:26.0877 (UTC) FILETIME=[AC0CC2D0:01C1A587]
X-SW-Source: 2002-q1/txt/msg00140.txt.bz2

On Fri, 2002-01-25 at 20:44, Michael A Chase wrote:
> ----- Original Message -----
> ".bz2" only 'protects' WinZip users until WinZip starts handling bzip2
> files.  That may never happen, but ".cwp" (or ".rpm" or ".deb") isn't
> vulnerable to WinZip improvements.

.cwp is hardly protection, it's just as, or more, vulnerable to Winzip
improvements. .deb and .rpm are more resilient, but hardly beyond access
for Winzip.
 
> > > The current un-patched code leaves off ".tar" inadvertently.

> >
> > I'll apply the lot if you'll
> > 1) cleanup the strduping,
> 
> The strdup() was in one of the lines I didn't change.  I'll change it.
> While I'm at it, I'll look for other strdup() calls in the file and change
> them as well.

There shouldn't be any strdups elsewhere, I recall now why I hadn't
changed fromcwd.cc's strdup calls - because the code was commented out.
Having actually looked closely at this, I'm inclined to add a FIXME line
rather than your patch - not because your code is wrong, but because the
structs you are operating on are gone! (There's no info struct, and no
trust enum any more...).
 
> > 2) Answer my query about filemanip.
> 
> The '-' lines below are from the unpatched filemanip.cc.  Notice the ';' at
> the end of the 'if' lines.  That causes the return after the ".tar.gz" 'if'
> statement to always be executed.  As a result, the test for ".tar" never
> gets executed.

Doh!. 
 
> My original patch (which I forgot to attach to the first message) included a
> test for ".cwp" to test the waters.  Should I add it back?  If I do, should
> I also add ".rpm", and ".deb"?

No, I think bz2 will last us until .deb or rpm is ready. And we
shouldn't try to read something we can't :]. However your patch still
looks wrong because it removes the .tar support - which costs us nothing
to have, and may be useful for someone :}.
 
> --- filemanip.cc-0 Thu Jan 24 16:43:57 2002
> +++ filemanip.cc Thu Jan 24 16:22:08 2002
> @@ -69,10 +69,12 @@ find_tar_ext (const char *path)
>    char *ext = strstr (path, ".tar.bz2");
>    if (ext)
>      return (end - ext) == 8 ? ext - path : 0;
> -  if ((ext = strstr (path, ".tar.gz")));
> -  return (end - ext) == 7 ? ext - path : 0;
> -  if ((ext = strstr (path, ".tar")));
> -  return (end - ext) == 4 ? ext - path : 0;
> +  if ((ext = strstr (path, ".tar.gz")))
> +    return (end - ext) == 7 ? ext - path : 0;
> +  return 0;
>  }

Rob
