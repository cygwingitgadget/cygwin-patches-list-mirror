Return-Path: <cygwin-patches-return-7397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24562 invoked by alias); 24 May 2011 13:06:32 -0000
Received: (qmail 24383 invoked by uid 22791); 24 May 2011 13:05:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 24 May 2011 13:05:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 96E7D2CB9E4; Tue, 24 May 2011 15:05:36 +0200 (CEST)
Date: Tue, 24 May 2011 13:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
Message-ID: <20110524130536.GE848@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca> <20110523073139.GA17244@calimero.vinschen.de> <4DDB9631.30904@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DDB9631.30904@cs.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00163.txt.bz2

On May 24 07:27, Ryan Johnson wrote:
> On 23/05/2011 3:31 AM, Corinna Vinschen wrote:
> >On May 22 14:42, Ryan Johnson wrote:
> >>In theory, this should completely eliminate the case where us
> >>loading one DLL pulls in dependencies automatically (= uncontrolled
> >>and at Windows' whim). The problem would manifest as a DLL which
> >>"loads" in the same wrong place repeatedly when given the choice,
> >>and for which we would be unable to VirtualAlloc the offending spot
> >>(because the dll in question has non-zero refcount even after we
> >>unload it, due to the dll(s) that depend on it.
> >There might be a way around this.  It seems to be possible to tweak
> >the module list the PEB points to so that you can unload a library
> >even though it has dependencies.  Then you can block the unwanted
> >space and call LoadLibrary again.  See (*) for a discussion how
> >you can unload the exe itself to reload another one.  Maybe that's
> >something we can look into as well.  ObNote:  Of course, if we
> >could influnce the address at which a DLL gets loaded right from the
> >start, it would be the preferrable solution.
> >
> >
> >Corinna
> >
> >(*) http://www.blizzhackers.cc/viewtopic.php?p=4332690
> After poking around at (*) a bit, it looks like NtMapViewOfSection
> does more than I would have expected wrt dll loading. However, when
> I tried to fire up a toy program to test it, NtOpenSection always
> returns C0000024, regardless of whether I pass OBJ_KERNEL_HANDLE to
> it.
> 
> Does anybody have experience with those two functions?

The Cygwin source code, for instance, is using this function, see
fhandler_mem.cc.

C0000024 is STATUS_OBJECT_TYPE_MISMATCH.  I didn't see the error before,
but I have a vague idea why you get it.  Are you by any chance trying to
call NtOpenSection with the OBJECT_ATTRIBUTES set to the file?  If so,
that's wrong.  The OBJECT_ATTRIBUTES names the attributes of the section,
including its name if it has one.  It does not specify the file you're
trying to map.  What you're looking for is NtCreateSection.  It has an
extra parameter to specify the handle to an open file.

Here's an off-the-top-of-my-head example how you use it.  Assuming you
already have an open file handle "filehandle" and it's size "filesize":

  NTSTATUS status;
  HANDLE sectionhandle;
  OBJECT_ATTRIBUTES attr;
  LARGE_INTEGER sectionsize = { QuadPart: filesize };

  InitializeObjectAttributes (&attr, NULL, OBJ_INHERIT, NULL, NULL);
  status = NtCreateSection (&sectionhandle, SECTION_ALL_ACCESS, &attr,
			    &sectionsize, PAGE_EXECUTE_READ, SEC_IMAGE,
			    filehandle);
				     

HTH,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
