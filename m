Return-Path: <cygwin-patches-return-5306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18036 invoked by alias); 14 Jan 2005 20:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17964 invoked from network); 14 Jan 2005 20:28:41 -0000
Received: from unknown (HELO exgate.steeleye.com) (209.192.50.48)
  by sourceware.org with SMTP; 14 Jan 2005 20:28:41 -0000
Received: from steelpo.steeleye.com ([172.17.4.222]) by exgate.steeleye.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jan 2005 15:28:40 -0500
Content-class: urn:content-classes:message
Subject: RE: Control auto-uppercasing of environment variables
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jan 2005 20:28:00 -0000
Message-ID: <76CBF6B36306884D835E33553572BE52059ECF@steelpo>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Ernie Coskrey" <Ernie.Coskrey@steeleye.com>
To: <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 14 Jan 2005 20:28:40.0977 (UTC) FILETIME=[A2A1A010:01C4FA77]
X-SW-Source: 2005-q1/txt/msg00009.txt.bz2

Well, I suppose there are some similarities between what the uppercase_env =
and check_case options are used for, but check_case is specifically targete=
d at handling case sensitivity with regard to filenames, not environment va=
riables.  The subvalues of check_case are specified as "levels" (relaxed, a=
djust, and strict), so I don't think there's a clean way to use this unless=
 we completely changed the meaning of what check_case is intended to do.

You'd also have to be able to combine subvalues - for example, some users m=
ight want strict file checking and no environment variable uppercasing, oth=
ers might want relaxed file checking and uppercasing of environment variabl=
es.  A separate CYGWIN option seems cleaner.

Sorry about the patch format; I'll use the unified diff format in the futur=
e.

Ernie

> -----Original Message-----
> From: Igor Pechtchanski [mailto:pechtcha@cs.nyu.edu]
> Sent: Friday, January 14, 2005 2:52 PM
> To: Ernie Coskrey
> Cc: cygwin-patches@cygwin.com
> Subject: Re: Control auto-uppercasing of environment variables
>=20
>=20
> On Fri, 14 Jan 2005, Ernie Coskrey wrote:
>=20
> > Cygwin automatically converts all Windows environment=20
> variable names to
> > uppercase.  The attached patch allows users to control this=20
> behavior by
> > specifying an option in the CYGWIN environment variable:
> > (no)uppercase_env.  The default for this option will be=20
> "SET", so that
> > Cygwin's default behavior is the same as always.  Adding
> > "nouppercase_env" to the CYGWIN environment variable will=20
> cause Cygwin
> > to leave environment variable names in the same state as they are
> > defined in the Windows environment (except for PATH, which will be
> > uppercased as before).
> >
> > My company has a product which includes a number of shell scripts.
> > We've bundled our product with a commercial product which=20
> provided the
> > shell functionality, and this product did not uppercase environment
> > variables.  We'd like to rebase our product on Cygwin, and=20
> the ability
> > to turn off the auto-uppercase behavior would make this a=20
> much easier
> > prospect.  While it would be possible to port the scripts and change
> > variable names, there are issues that make this more=20
> complicated than it
> > first seems.  For instance, we remotely execute scripts on=20
> other systems
> > running our product, so during an upgrade it's possible=20
> that the shell
> > would be running in the old environment.  Referring to uppercase
> > variable names would break in this case.  Again, we could=20
> do something
> > to check the environmnent and use the correct version of=20
> the variable
> > name, but making Cygwin understand our existing scripts is a more
> > desirable solution.
> >
> > I have briefly discussed this with Christopher Faylor, who has some
> > reservations about this functionality.  His comments were:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I should point out that a few people have submitted similar=20
> patches over
> > the years and they have been rejected.  There are other=20
> ways to do what
> > you want to do which do not involve adding an option and=20
> slowing down
> > cygwin's startup.  We tend to be pretty stingy when it=20
> comes to adding
> > new options to the CYGWIN environment variable.
> >
> > But, if you want to discuss this, then cygwin-patches would=20
> be the place
> > to do so.  You can quote this email there, if you want.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I can understand the reluctance to add more and more options to the
> > CYGWIN environment variable.  I hope that the Cygwin community sees
> > enough value in the ability to control this aspect of=20
> Cygwin that this
> > modification is accepted.  I don't believe that there is any real
> > performance impact with this change - at most the code=20
> costs a few extra
> > machine cycles, but certainly nothing noticeable.
> >
> > Thanks for considering this modification.
>=20
> Ernie,
>=20
> I have no comments on the functionality of the patch, but it=20
> seems that
> since Cygwin already parses $CYGWIN for the check_case=20
> option, adding your
> option as a suboption of check_case instead of a brand new=20
> option might be
> the way to go, especially since the intent is similar.=20=20
> There's still the
> overhead of checking the setting, but that might be less of=20
> an obstacle
> than adding a new $CYGWIN top-level option.
>=20
> Also, it might be easier to review if you sent the patch in Unidiff
> format, rather than the context diff (use "diff -up" instead of "diff
> -c").
> 	Igor
> --=20
> 				http://cs.nyu.edu/~pechtcha/
>       |\      _,,,---,,_		pechtcha@cs.nyu.edu
> ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
>      |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
>     '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!
>=20
> "The Sun will pass between the Earth and the Moon tonight for a total
> Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
>=20
