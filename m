From: Earnie Boyd <earnie_boyd@yahoo.com>
To: CP List <Cygwin-Patches@Cygwin.Com>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Fri, 14 Dec 2001 07:53:00 -0000
Message-ID: <3C1A2024.ECAA4B91@yahoo.com>
References: <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com> <3C19F354.1E85323C@yahoo.com> <20011214161713.P740@cygbert.vinschen.de> <3C1A1D6D.EEC404C8@yahoo.com>
X-SW-Source: 2001-q4/msg00313.html
Message-ID: <20011214075300.J4tgIMjImUNomvwLpm-ZSVt9srTbFJt6seRmVdnCnzA@z>

Earnie Boyd wrote:
> 
> Corinna Vinschen wrote:
> >
> > Agree.  I'm still for giving a nice PS1 by default (aka not '$ ')
> > but it should get simplified so that it works for all bourne shell
> > clones.
> >
> 
> PS1="`whoami`@`hostname` `basename \`pwd\``> "
> 

Oops. Make that.
PS1="`whoami`@`hostname`> "

There isn't a portable way to set the current working directory in the
prompt string.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

