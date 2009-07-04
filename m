Return-Path: <cygwin-patches-return-6553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4808 invoked by alias); 4 Jul 2009 14:17:40 -0000
Received: (qmail 4793 invoked by uid 22791); 4 Jul 2009 14:17:38 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Jul 2009 14:17:32 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id F3CD83B0008 	for <cygwin-patches@cygwin.com>; Sat,  4 Jul 2009 10:17:21 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B1E3D444725; Sat,  4 Jul 2009 10:17:21 -0400 (EDT)
Date: Sat, 04 Jul 2009 14:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: AttachConsole broken autoload
Message-ID: <20090704141721.GA11034@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A4F4F5B.8090806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A4F4F5B.8090806@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00007.txt.bz2

On Sat, Jul 04, 2009 at 01:47:23PM +0100, Dave Korn wrote:
>
>  Got this error when I tried to run with a DLL built from today's CVS HEAD:
>
>> ---------------------------
>> bash.exe - Entry Point Not Found
>> ---------------------------
>> The procedure entry point AttachConsole could not be located in the dynamic link library KERNEL32.dll. 
>> ---------------------------
>> OK   
>> ---------------------------
>
>  Checked that it doesn't exist on W2K:
>
>http://msdn.microsoft.com/en-us/library/ms681952(VS.85).aspx
>> Minimum supported client	Windows XP
>> Minimum supported server	Windows Server 2003
>
>  Something's gone wrong with the autoload definition, because here's the
>reference:
>
>> $ nm fhandler_console.o | grep AttachConsole
>>          U _AttachConsole@4
>
>... but here's the definition:
>
>> $ nm autoload.o | grep AttachConsole
>> 00000000 T _AttachConsole@0
>> 00000000 T _win32_AttachConsole@0
>
>... leading to the DLL still having an explicit import for it:
>
>> $ dumpbin /imports new-cygwin1.dll | grep AttachConsole
>>                    D  AttachConsole
>
>  Attached patch looks like the obvious fix to me and builds a DLL without an
>import for AttachConsole; resulting DLL loads and runs on W2k.  Ok?
>
>	* autoload.cc (AttachConsole):  Correct size of args.

Yes, I think that's an obvious fix.

cgf
