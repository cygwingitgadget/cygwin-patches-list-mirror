From: Jan Nieuwenhuizen <janneke@gnu.org>
To: cygwin-patches@cygwin.com
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Sun, 16 Dec 2001 08:30:00 -0000
Message-ID: <m31yhv9lh1.fsf@appel.lilypond.org>
References: <m3bshtmxhb.fsf@appel.lilypond.org> <878764062.20011128173421@nyckelpiga.de> <m37ks9lgxi.fsf@appel.lilypond.org> <4434079433.20011129221637@familiehaase.de> <m3oflgy98n.fsf@appel.lilypond.org> <9517228633.20011203135833@familiehaase.de> <m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu> <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <105201c18604$ea001670$0200a8c0@lifelesswks> <3C1CB581.7E2DF6E3@yahoo.com>
X-SW-Source: 2001-q4/msg00323.html
Message-ID: <20011216083000.zZDQJFSBzHJhAVSDG5AaTjn61SbEPL3OPfxtSvu6tHI@z>

Earnie Boyd <earnie_boyd@yahoo.com> writes:

> Robert Collins wrote:
> > 
> > Right. Well setup compiled before w32api got broken. I've said it twice
> > now: revert your w32api (which is what's broken) and setup will build
> > cleanly.
> > 
> > Fixing w32api again is important, and can be address'd in parallel.
> > Anyone that wants to build setup.exe will have motivation to fix w32api
> > :].
> > 
> 
> Can you remind me as to what's broke?

From an earlier mail (haven't checked latest cvs):


    > The Werror is in by design. If your patch won't build with it, I won't
    > accept you patch.

    Ah, good.  But it was not for my patch!  The latest cvs setup.exe
    won't build without it, in my environment.  I get warnings (-> errors)
    like:

    /home/fred/usr/src/cygwin/cygwin-1.3.6/usr/src/cygwin/src/winsup/w32api/include/rpcndr.h:252: warning: function declaration isn't a prototype
    In file included from /home/fred/usr/src/cygwin/cygwin-1.3.6/usr/src/cygwin/src/winsup/w32api/include/ole2.h:5,
                     from /home/fred/usr/src/cygwin/cygwin-1.3.6/usr/src/cygwin/src/winsup/w32api/include/shlobj.h:8,
                     from mklink2.c:3:
    /home/fred/usr/src/cygwin/cygwin-1.3.6/usr/src/cygwin/src/winsup/w32api/include/objbase.h:165: warning: function declaration isn't a prototype
    /home/fred/usr/src/cygwin/cygwin-1.3.6/usr/src/cygwin/src/winsup/w32api/include/objbase.h:166: warning: function declaration isn't a prototype
    make: *** [mklink2.o] Error 1


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
