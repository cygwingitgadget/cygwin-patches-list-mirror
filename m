Return-Path: <cygwin-patches-return-1800-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23555 invoked by alias); 28 Jan 2002 15:53:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23342 invoked from network); 28 Jan 2002 15:53:26 -0000
Message-ID: <043a01c1a72a$988ae8f0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
References: <3C4E0C9F.1BEECC02@yahoo.com>
Subject: Re: include/sys/strace.h
Date: Mon, 28 Jan 2002 07:53:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 27 Jan 2002 12:03:08.0016 (UTC) FILETIME=[9567D700:01C1A72A]
X-SW-Source: 2002-q1/txt/msg00157.txt.bz2

Chris, I'd actually kinda like to see this included, I can see it being
handy from time to time.

Rob
===
----- Original Message -----
From: "Earnie Boyd" <earnie_boyd@yahoo.com>
To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
Sent: Wednesday, January 23, 2002 12:06 PM
Subject: include/sys/strace.h


> I've created simple macros to set strace.active ON or OFF when
> --enable-debugging is enabled.
>
> Comments?
>
> Earnie.


------------------------------------------------------------------------
--------


> 2002.01.22  Earnie Boyd  <earnie@users.sf.net>
>
> * include/sys/strace.h (_STRACE_ON): Define.
> (_STRACE_OFF): Ditto.
>
> Index: strace.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/include/sys/strace.h,v
> retrieving revision 1.12
> diff -u -3 -p -r1.12 strace.h
> --- strace.h 2001/04/03 02:53:25 1.12
> +++ strace.h 2002/01/23 01:00:40
> @@ -77,6 +77,13 @@ extern strace strace;
>  #define _STRACE_MALLOC 0x20000 // trace malloc calls
>  #define _STRACE_THREAD 0x40000 // thread-locking calls
>  #define _STRACE_NOTALL 0x80000 // don't include if _STRACE_ALL
> +#if defined (DEBUGGING)
> +# define _STRACE_ON strace.active = 1;
> +# define _STRACE_OFF strace.active = 0;
> +#else
> +# define _STRACE_ON
> +# define _STRACE_OFF
> +#endif
>
>  #ifdef __cplusplus
>  extern "C" {
>
