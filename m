Return-Path: <cygwin-patches-return-4823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23985 invoked by alias); 3 Jun 2004 22:29:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23974 invoked from network); 3 Jun 2004 22:29:27 -0000
Date: Thu, 03 Jun 2004 22:29:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
Message-ID: <20040603222926.GA8964@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <20040603203500.GA6889@coe.casa.cgf.cx> <20040603221458.GA8514@coe.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603221458.GA8514@coe.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00175.txt.bz2

On Thu, Jun 03, 2004 at 06:14:58PM -0400, Christopher Faylor wrote:
>On Thu, Jun 03, 2004 at 04:35:00PM -0400, Christopher Faylor wrote:
>>On Thu, Jun 03, 2004 at 03:53:40PM -0400, David Fritz wrote:
>>>I don't how much you want to rely on undocumented features, but ntdll.dll 
>>>exports a function called RtlIsDosDeviceName_U().  The WINE implementation 
>>>has the following to say about it:
>>>
>>>
>>>/***********************************************************************
>>> *             RtlIsDosDeviceName_U   (NTDLL.@)
>>> *
>>> * Check if the given DOS path contains a DOS device name.
>>> *
>>> * Returns the length of the device name in the low word and its
>>> * position in the high word (both in bytes, not WCHARs), or 0 if no
>>> * device name is found.
>>> */
>>>ULONG WINAPI RtlIsDosDeviceName_U( PCWSTR dos_name )
>>
>>THANK YOU!  This is what I was vaguely remembering.
>
>Interestingly enough, I just added some checking to fhandler_base::open which
>used RtlIsDosDeviceName_U.  It caused a reboot of my XP system every time
>I tried it.  That's a first for XP.

Oops.  No, that was the result of passing garbage to
InitializeObjectAttributes apparently.  Seems like a pretty serious XP
bug regardless.

I've checked in a minimal change which protects against calling NtCreateFile
on a dos device.  Now what was the method that was used to get rid of those
pesky NULs and COM1s on my disk again?

cgf
