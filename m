From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Cc: Earnie Boyd <mingw-dvlpr@lists.sourceforge.net>
Subject: [Fwd: Re: [MinGW-dvlpr] [Fwd: mingw/include/stddef.h]]
Date: Sat, 24 Feb 2001 10:03:00 -0000
Message-id: <3A97F77F.36F50B43@yahoo.com>
X-SW-Source: 2001-q1/msg00112.html

Corinna,

See Danny's analysis and question below.

Earnie.

P.S.: Corinna, you can respond to the mingw-dvlpr list and I'll see that
the post gets approved.

P.P.S.: Danny, you could have included cygwin-patches in your response.

-------- Original Message --------
From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: [MinGW-dvlpr] [Fwd: mingw/include/stddef.h]
To: mingw-dvlpr@lists.sourceforge.net


--- Danny Smith <danny_r_smith_2001@yahoo.co.nz> wrote: > --- Earnie
Boyd <earnie_boyd@yahoo.com> wrote: > Danny,
> > 
> > Can you answer Corinna's question?
> > 
> > Earnie.
> > 
> > -------- Original Message --------
> > From: Corinna Vinschen <cygwin-patches@cygwin.com>
> > Subject: mingw/include/stddef.h
> > To: cygpatch <cygwin-patches@cygwin.com>
> > 
> > Hi,
> > 
> > the current `stddef.h' file contains surprisingly the following:
> > 
> > ...
> > #ifndef __WCHAR_TYPE__
> > #ifdef __BEOS__
> > #define __WCHAR_TYPE__ unsigned char
> > #else
> > #define __WCHAR_TYPE__ int
> > #endif
> > #endif
> > ...
> > 
> > The surprise is the definition of __WCHAR_TYPE__ as `int' in case
> > of !BEOS.
> > 
> > Wouldn't it have more sense to define it as `unsigned short'???
> > 
> 
> Golly there's a lot of #ifdef's in stddef.h
> 
> I haven't walked through them all yet, but..
> 
> #include <stddef.h>
> #include <stdio.h>
> 
> int main(){
> __WCHAR_TYPE__ w = L'a';
> int i=1;
> 
> printf("sizeof __WCHAR_TYPE__: %d,  sizeof int: %d \n", 
> sizeof(w),sizeof(i));
> printf("(__WCHAR_TYPE__)-1:  %d \n", (__WCHAR_TYPE__)-1);
> return 0;
> }
> 
> produces:
> 
> sizeof __WCHAR_TYPE__: 2, sizeof int: 4 
> (__WCHAR_TYPE__)-1:  65535
> 
> which is what I thought it would and what Corrina wants too I think.
> 
> Danny
> 
> 



Anyway, stddef.h  gets fixincluded by gcc build, doesn't it? If grep
through gcc src find many of these

#ifndef __WCHAR_TYPE__
#define __WCHAR_TYPE__ int
#endif

which is a safe (big enough) type for wchar_t and perfectly legal.  In
the absence of a predefine, whats wrong with int?.

Danny


_____________________________________________________________________________
http://invites.yahoo.com.au - Yahoo! Invites
- Organise your Mardi Gras party online!

_______________________________________________
MinGW-dvlpr mailing list
MinGW-dvlpr@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/mingw-dvlpr

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

