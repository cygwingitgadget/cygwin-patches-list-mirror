From: Earnie Boyd <earnie_boyd@yahoo.com>
To: DJ Delorie <dj@redhat.com>
Cc: mingw-patches@lists.sourceforge.net, cygwin-patches@cygwin.com
Subject: Re: winnt.h: VOID already defined
Date: Thu, 05 Jul 2001 14:23:00 -0000
Message-id: <3B44F6A9.120CAFB2@yahoo.com>
References: <200107052028.QAA18173@greed.delorie.com>
X-SW-Source: 2001-q3/msg00002.html

These were moved inside the void protect back in 1998 by Anders
Norlander.  There must be some reason for him to have done so.  I
haven't found it yet though.

DJ Delorie wrote:
> 
> If I try to cross-build a native cygwin expect under linux, tcl's
> headers already define VOID to void, and thus winnt.h is missing a
> number of important typedefs.  This patch seems to fix it, but I'm
> worried that this just hides a true problem elsewhere.
> 
> Index: winnt.h
> ===================================================================
> RCS file: /cvs/uberbaum/winsup/w32api/include/winnt.h,v
> retrieving revision 1.22
> diff -p -3 -r1.22 winnt.h
> *** winnt.h     2001/05/17 21:13:10     1.22
> --- winnt.h     2001/07/05 20:07:35
> *************** extern "C" {
> *** 41,50 ****
> 
>   #ifndef VOID
>   #define VOID void
>   typedef char CHAR;
>   typedef short SHORT;
>   typedef long LONG;
> - #endif
>   typedef CHAR CCHAR;
>   typedef unsigned char UCHAR,*PUCHAR;
>   typedef unsigned short USHORT,*PUSHORT;
> --- 41,50 ----
> 
>   #ifndef VOID
>   #define VOID void
> + #endif
>   typedef char CHAR;
>   typedef short SHORT;
>   typedef long LONG;
>   typedef CHAR CCHAR;
>   typedef unsigned char UCHAR,*PUCHAR;
>   typedef unsigned short USHORT,*PUSHORT;

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

