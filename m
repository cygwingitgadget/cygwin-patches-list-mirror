Return-Path: <cygwin-patches-return-1762-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1862 invoked by alias); 23 Jan 2002 01:37:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1848 invoked from network); 23 Jan 2002 01:37:42 -0000
Message-ID: <3C4E13BA.EEC19242@yahoo.com>
Date: Tue, 22 Jan 2002 17:37:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Collins <robert.collins@itdomain.com.au>
CC: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
Subject: Re: include/sys/strace.h
References: <3C4E0C9F.1BEECC02@yahoo.com> <0d8701c1a3ab$57a8f430$0200a8c0@lifelesswks>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00119.txt.bz2

Robert Collins wrote:
> 
> ===
> ----- Original Message -----
> From: "Earnie Boyd" <earnie_boyd@yahoo.com>
> To: "Earnie Boyd" <Cygwin-Patches@Cygwin.Com>
> Sent: Wednesday, January 23, 2002 12:06 PM
> Subject: include/sys/strace.h
> 
> > I've created simple macros to set strace.active ON or OFF when
> > --enable-debugging is enabled.
> >
> > Comments?
> 
> I'm not sure of the purpose of the macros - could you enlarge on that
> please.
> 

Sure,

There is a nice DebugView utility from sysinternals.com that captures
the OutputDebugString info into it's own window.  I can _STRACE_ON when
entering a function I suspect needs debugging and _STRACE_OFF before
leaving it to minimize the amount of strace output.  Doing this gives me
more control of what I'm debugging within the Cygwin1.dll.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

