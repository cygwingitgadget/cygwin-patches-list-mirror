Return-Path: <cygwin-patches-return-1831-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17543 invoked by alias); 2 Feb 2002 02:45:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17489 invoked from network); 2 Feb 2002 02:45:16 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: For the curious: Setup.exe char-> String patch
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Fri, 01 Feb 2002 18:45:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760629F@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: For the curious: Setup.exe char-> String patch
Thread-Index: AcGrjhCYvTRHekB6RjmMPuhw27ZrXAAAwrLw
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00188.txt.bz2



> -----Original Message-----
> From: Michael A Chase [mailto:mchase@ix.netcom.com]
>=20
> I only saw two possible real problems.  Everything else is a matter of
> consistency which I could send you a patch for after this is=20
> implemented.
>
> String++.cc:
>=20
> +// does this character exist in the string?
> +// 0 is false, 1 is the first position...
> +size_t
> +String::find(char aChar) const
> +{
> +  for (size_t i=3D0; i < theData->length; ++i)
> +    if (theData->theString[i] =3D=3D aChar)
> +      return i;
> +  return 0;
>=20
> ### Won't this return 0 if aChar is in the first position in
> theData->theString?

Yes. Thank you.=20
=20
> String++.h:
>=20
> ### Do you want String::concat() and String::vconcat to be=20
> public?  The few
> places I see them being used could be ... String ("first") +=20
> next + next ...
> You lose a little efficiency by not calling String::concat,=20
> but you make up
> some of it by not having to call String::cstr_oneuse().

HMMM, worth thinking about. Remeber that vconcat can only be used with
char *'s, and we don't want them :}. (think unicode native storage).
There are other lower lever mechanisms to optimise String, but as we
aren't CPU bound, I'm not concerned at this point. One such example you
could look at is the SGI Rope class template. (I've not looked at that
but it's similar to what another project I'm on has been creating from
scratch, a team member recently said "hey, this is similar :}". As for
concat vs +, concat canonicalises paths, which is what broke Chuck's //
path references (because / indicated a posix path to the code AFAIK). I
don't think thats an appropriate use for String:: though, so wrote +,
and used that. Also, canonicalisation IMO should occur at the
io_stream::open and related calls, not at every manipulation: file path
fragments shouldn't get canonicalised.
=20
> archive.cc:

> ### To be consistent with other log() calls in this file=20
> change the last
> line to:
> + {log (LOG_TIMESTAMP, String ("Failed to make the path for ") +
> destfilename);

...

Yah, it's not 100% complete :]. Let me get it in first, then we can all
chip in an tidy up :}.
=20
> geturl.cc:
>=20
>  static void
> -init_dialog (char const *url, int length, HWND owner)
> +init_dialog (String const url, int length, HWND owner)

>    start_tics =3D GetTickCount ();
> +  delete[] sl;
>  }
>=20
> ### Is that delete[] safe?  You've been changing sl=20
> repeatedly in the for
> loop.

I'll check when I get home. I may have missed it - I've used a temp
variable most other places. Thanks for the catch (assuming it's a bug
:]).
=20
> log.cc/log.h:
>=20
> ### If I understand the change, a log line may be either=20
> timestamped or
> babble.  So a line can't be timestamped and only go to setup.log.full.
> Likewise all lines in setup.log must be timestamped.  I think=20
> we are losing
> some useful capablities by changing from flags to level.

mmm, yes, but we've also gained type safety. If you wish to submit a
flags class ( I can enlarge on that if needed) to allow log
(LOG_BABBLE|LOG_FULL & LOG_TIMESTAMP|LOG_LITERAL, String const &) that'd
be fine by me. I like enforcing type safety where possible.
=20
> mount.cc:
>=20
> ### It looks like it might be cleaner to make String cygpath=20
> (String const
> &) visible along with String cygpath (const char *, ...).  It=20
> seems like
> nearly every place I saw it used you are doing cygpath
> (xxx.cstr_oneuse(),0).

Yes, I want to... but doing it was going to be a right ol' pain
initially, so I pu tit to the side.
=20
> ### The few places that involve concatenation could be handled by
> String()+x+...  I'm willing to make a patch to catch any=20
> leftovers so String
> cygpath( const char *, ...) could be dropped.

Please do.
=20
> package_meta.cc:

> ### I don't think .cstr_oneuse() is needed for log():
> +       log (LOG_BABBLE, String("unlink ") + d);

another good catch.
=20
Thanks very much for the detailed analysis.=20

Rob
