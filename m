From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Sat, 15 Dec 2001 22:43:00 -0000
Message-ID: <0f9101c185fd$05e09930$0200a8c0@lifelesswks>
References: <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com> <3C19F354.1E85323C@yahoo.com> <20011214161713.P740@cygbert.vinschen.de>
X-SW-Source: 2001-q4/msg00318.html
Message-ID: <20011215224300.3n0nqQ-L18QsEDjzoFAgCPrJuLZbqPBvixMyvhjo3ic@z>

===
----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>


> Agree.  I'm still for giving a nice PS1 by default (aka not '$ ')
> but it should get simplified so that it works for all bourne shell
> clones.

Sure. I suggest that a package gets created, and that bash, ash et al
depend on it that has a default prompt, and any other miscellaneous
things. Setup.exe will not overwrite /etc/profile if it exists at the
end of the package extraction and postinstall execution, so simply
having a package with
"/etc/profile.default" and a postinstall script that copies
profile.default to profile IFF profile is missing is very easy and
doesn't require setup.exe changes.

> In general a question raises (again, perhaps?):  Shouldn't we provide
> a default /etc/csh.login file as well?  At least as part of the tcsh
> package?

Yes.

Rob
