Return-Path: <cygwin-patches-return-1784-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30738 invoked by alias); 25 Jan 2002 10:17:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30724 invoked from network); 25 Jan 2002 10:17:52 -0000
Message-ID: <026301c1a589$84e33570$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.com> <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq><1011948812.18172.17.camel@lifelesswks> <021701c1a584$f9371f90$a100a8c0@mchasecompaq> <1011953063.18172.21.camel@lifelesswks>
Subject: Re: [PATCH]Package extention recognition (revision 1)
Date: Fri, 25 Jan 2002 02:17:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00141.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>
Cc: <cygwin-patches@cygwin.com>
Sent: Friday, January 25, 2002 02:04
Subject: Re: [PATCH]Package extention recognition (revision 1)


> On Fri, 2002-01-25 at 20:44, Michael A Chase wrote:
> > ----- Original Message -----
> > ".bz2" only 'protects' WinZip users until WinZip starts handling bzip2
> > files.  That may never happen, but ".cwp" (or ".rpm" or ".deb") isn't
> > vulnerable to WinZip improvements.
>
> .cwp is hardly protection, it's just as, or more, vulnerable to Winzip
> improvements. .deb and .rpm are more resilient, but hardly beyond access
> for Winzip.
>
> > > > The current un-patched code leaves off ".tar" inadvertently.
>
> > >
> > > I'll apply the lot if you'll
> > > 1) cleanup the strduping,
> >
> > The strdup() was in one of the lines I didn't change.  I'll change it.
> > While I'm at it, I'll look for other strdup() calls in the file and
change
> > them as well.
>
> There shouldn't be any strdups elsewhere, I recall now why I hadn't
> changed fromcwd.cc's strdup calls - because the code was commented out.
> Having actually looked closely at this, I'm inclined to add a FIXME line
> rather than your patch - not because your code is wrong, but because the
> structs you are operating on are gone! (There's no info struct, and no
> trust enum any more...).

I had originally only touched it to make sure the additional allowed archive
extensions wouldn't break the code.  There's already a FIXME.  Maybe it
should be replaced with something that says the structures no longer exist.
Unless the right answer is to just delete the whole mess.

  // Reinstate this FIXME:

to

  // Reinstate this FIXME: Use new classes in place of obsolete structures.

> > > 2) Answer my query about filemanip.
> >
> > The '-' lines below are from the unpatched filemanip.cc.  Notice the ';'
at
> > the end of the 'if' lines.  That causes the return after the ".tar.gz"
'if'
> > statement to always be executed.  As a result, the test for ".tar" never
> > gets executed.
>
> Doh!.
>
> > My original patch (which I forgot to attach to the first message)
included a
> > test for ".cwp" to test the waters.  Should I add it back?  If I do,
should
> > I also add ".rpm", and ".deb"?
>
> No, I think bz2 will last us until .deb or rpm is ready. And we
> shouldn't try to read something we can't :]. However your patch still
> looks wrong because it removes the .tar support - which costs us nothing
> to have, and may be useful for someone :}.

The second patch left out ".tar" because it wasn't being executed.  I'll put
it back.

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

