Return-Path: <cygwin-patches-return-4812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18530 invoked by alias); 3 Jun 2004 20:35:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18518 invoked from network); 3 Jun 2004 20:35:00 -0000
Date: Thu, 03 Jun 2004 20:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
Message-ID: <20040603203500.GA6889@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF81C4.1020105@att.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00164.txt.bz2

On Thu, Jun 03, 2004 at 03:53:40PM -0400, David Fritz wrote:
>I don't how much you want to rely on undocumented features, but ntdll.dll 
>exports a function called RtlIsDosDeviceName_U().  The WINE implementation 
>has the following to say about it:
>
>
>/***********************************************************************
> *             RtlIsDosDeviceName_U   (NTDLL.@)
> *
> * Check if the given DOS path contains a DOS device name.
> *
> * Returns the length of the device name in the low word and its
> * position in the high word (both in bytes, not WCHARs), or 0 if no
> * device name is found.
> */
>ULONG WINAPI RtlIsDosDeviceName_U( PCWSTR dos_name )

THANK YOU!  This is what I was vaguely remembering.

>Also, from the patch:
>
>/* COM and LPT must be followed by a single digit */
>
>The code in src/winsup/cygwin/devices.cc would seem to indicate that
>the number is not limited to a single digit.

I believe that whenever I try to limit COM to single digits someone
complains about their special board with 527 com ports or something.

cgf
