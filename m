Return-Path: <cygwin-patches-return-6312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5257 invoked by alias); 19 Mar 2008 03:00:46 -0000
Received: (qmail 5244 invoked by uid 22791); 19 Mar 2008 03:00:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 03:00:29 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 12DF7B638A; Tue, 18 Mar 2008 23:00:28 -0400 (EDT)
Date: Wed, 19 Mar 2008 03:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
Message-ID: <20080319030027.GC22446@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47E05D34.FCC2E30A@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47E05D34.FCC2E30A@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00086.txt.bz2

On Tue, Mar 18, 2008 at 05:24:20PM -0700, Brian Dessent wrote:
>
>This patch adds the ability to see functions/symbols in the .stackdump
>files generated when there's a fault.  It parses the export sections of
>each loaded module and finds the closest exported address for each stack
>frame address.  This of course won't be perfect as it will show the
>wrong function if the frame is in the middle of a non-exported function,
>but it's better than what we have now.
>
>This also uses a couple of tricks to make the output more sensible.  It
>can "see through" the sigfe wrappers and print the actual functions
>being wrapped.  It also has a set of internal symbols that it consults
>for symbols in Cygwin.  This allows it to get the bottom frame correct
>(_dll_crt0_1) even though that function isn't exported.  If there are
>any other such functions they can be easily added to the 'hints' array.
>
>Also attached is a sample output of an invalid C program and the
>resulting stackdump.  Note that the frame labeled _sigbe really should
>be a frame somewhere inside the main .exe.  I pondered trying to extract
>the sigbe's return address off the signal stack and using that for the
>label but I haven't quite gotten there, since I can't think of a
>reliable way to figure out the correct location on the tls stack where
>the real return address is stored.
>
>Of course the labeling works for any module/dll, not just cygwin1.dll,
>but I didn't have a more elaborate testcase to demonstrate.
>
>Brian
>2008-03-18  Brian Dessent  <brian@dessent.net>
>
>	* exceptions.cc (maybe_adjust_va_for_sigfe): New function to cope
>	with signal wrappers.
>	(prettyprint_va): New function that attempts to find a symbolic
>	name for a memory location by walking the export sections of all
>	modules.
>	(stackdump): Call it.
>	* gendef: Mark __sigfe as a global so that its address can be
>	used by the backtrace code.
>	* ntdll.h (struct _PEB_LDR_DATA): Declare.
>	(struct _LDR_MODULE): Declare.
>	(struct _PEB): Use actual LDR_DATA type for LdrData.
>	(RtlImageDirectoryEntryToData): Declare.

Sorry, but I don't like this concept.  This bloats the cygwin DLL for a
condition that would be better served by either using gdb or generating
a real coredump.

OTOH, adding a list of loaded dlls to a stackdump might not be a bad
idea so that some postprocessing program could generate the same output
as long as that didn't add too much code to cygwin.

cgf
