From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 16:32:00 -0000
Message-ID: <3C043080.D0E3AD8C@yahoo.com>
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks> <20011128002122.GA6919@redhat.com>
X-SW-Source: 2001-q4/msg00268.html
Message-ID: <20011127163200._xTi_jS-TiFnzi1iWUCQB57fpa4_0UKSZPvkQDB_Gj4@z>

Christopher Faylor wrote:
> 
> 
> Why?  For the reasons that both Gary and I mentioned.  It's self
> documenting?
> 
> Did you miss the point that I decided on the !foo because I had no
> choice?
> 

Once upon a time, not so very long ago, your self documentation added
precious cycles to the processing.  GCC fortunately is smart enough to
know how to get this right regardless.  I.E.: It makes no freaking
difference because the assembler is the same. ;)

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

