Return-Path: <cygwin-patches-return-1763-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14050 invoked by alias); 23 Jan 2002 08:22:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14025 invoked from network); 23 Jan 2002 08:22:38 -0000
Message-ID: <20020123082238.41330.qmail@web14506.mail.yahoo.com>
Date: Wed, 23 Jan 2002 00:22:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Fwd: [MinGW-patches] Patch for GPROF runtime on Win32
To: cygwin-patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00120.txt.bz2

This patch was submitted for mingw runtime. It may also be applicable to
cygwin. Any comments (apart from formatting)?

Here is the Changelog entry:

2002-01-22  Pascal Obry  <obry@gnat.com>

	* profile/profil.h (PROFADDR): Cast idx to unsigned long long to
	avoid overflow.
	* profile/gmon.c: Define bzero as memset if mingw32.
	(monstartup): Use it.


 --- Pascal Obry <obry@gnat.com> wrote: > To:
mingw-patches@lists.sourceforge.net
> From: obry@gnat.com (Pascal Obry)
> Subject: [MinGW-patches] Patch for GPROF runtime on Win32
> Date: Mon, 21 Jan 2002 09:52:52 -0500 (EST)
> 
> 
> The GPROF runtime support is broken in 2 places on
> Win32. We have add a report about GPROF not working
> on an Ada program. This is in fact not a GNU/Ada
> issue. We have been able to reproduce the problem and
> we propose the following fix (see attachement). 
> With this fix in the program run fine and provides 
> good output.
> 
> <<
> *** d:/home/obry/cvs/mingw/runtime/profile/profil.h Tue Jun  5 01:26:04
> 2001
> --- ./profil.h Sun Jan 20 10:32:46 2002
> ***************
> *** 29,35 ****
>   
>   /* convert an index into an address */
>   #define PROFADDR(idx, base, scale)	\
> ! 	((base) + ((((idx) << 16) / (scale)) << 1))
>   
>   /* convert a bin size into a scale */
>   #define PROFSCALE(range, bins)		(((bins) << 16) / ((range) >> 1))
> --- 29,36 ----
>   
>   /* convert an index into an address */
>   #define PROFADDR(idx, base, scale)	\
> !  ((base) + \
> !      ((((unsigned long long)(idx) << 16) / (unsigned long long)(scale))
> << 1))
>   
>   /* convert a bin size into a scale */
>   #define PROFSCALE(range, bins)		(((bins) << 16) / ((range) >> 1))
> *** d:/home/obry/cvs/mingw/runtime/profile/gmon.c Sat Jan 19 21:00:56
> 2002
> --- ./gmon.c Sun Jan 20 10:09:22 2002
> ***************
> *** 55,60 ****
> --- 55,64 ----
>   /* XXX needed? */
>   //extern char *minbrk __asm ("minbrk");
>   
> + #ifdef __MINGW32__
> + #define bzero(ptr,size) memset (ptr, 0, size);
> + #endif
> + 
>   struct gmonparam _gmonparam = { GMON_PROF_OFF };
>   
>   static int	s_scale;
> ***************
> *** 102,110 ****
>   		ERR("monstartup: out of memory\n");
>   		return;
>   	}
> ! #ifdef notdef
>   	bzero(cp, p->kcountsize + p->fromssize + p->tossize);
> ! #endif
>   	p->tos = (struct tostruct *)cp;
>   	cp += p->tossize;
>   	p->kcount = (u_short *)cp;
> --- 106,115 ----
>   		ERR("monstartup: out of memory\n");
>   		return;
>   	}
> ! 
> ! 	/* zero out the cp structure as value will be added there */
>   	bzero(cp, p->kcountsize + p->fromssize + p->tossize);
> ! 
>   	p->tos = (struct tostruct *)cp;
>   	cp += p->tossize;
>   	p->kcount = (u_short *)cp;
> >>
> 
> Pascal Obry.
> 
> _______________________________________________
> MinGW-patches mailing list
> MinGW-patches@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/mingw-patches 


http://my.yahoo.com.au - My Yahoo!
- It's My Yahoo! Get your own!
