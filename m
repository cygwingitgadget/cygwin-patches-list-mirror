Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 224CD3883028; Mon,  5 Jun 2023 16:55:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 224CD3883028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1685984119;
	bh=6dQH1e85mVA3LJlGs1MzIM85fGQu7KxF3S1pde/ELLw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gx3g6v88bFX4mF477gopzsaPsh77fQh7eDdGe9rAPLICM00ck+QO6vAXMnP/64W/3
	 5PdnJVy+I8zWqsf3QjRQnswDFyOaj08a89BzwtuJoTof7awsgu3mLIlxqLkzXQ2V+F
	 evYCndzzczhse9LFkmzkFXViqug8TZgitRvIvzUc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17D98A80D4E; Mon,  5 Jun 2023 18:55:17 +0200 (CEST)
Date: Mon, 5 Jun 2023 18:55:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@shaw.ca>
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Message-ID: <ZH4TdYlr+RAFbOHe@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@shaw.ca>
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
 <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On May 12 16:36, Jon Turney wrote:
> On 08/05/2023 04:12, Brian Inglis wrote:
> > cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows [20]20H1/[20]2004+
> > 		    => user_shstk User mode program Shadow Stack support
> > AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
> > Sync AMD 0x80000008:0 ebx flags across two output locations
> 
> Thanks.  I applied this.
> 
> Does this need applying to the 3.4 branch as well?
> 
> > ---
> >   winsup/cygwin/fhandler/proc.cc | 29 ++++++++++++++++++++++-------
> 
> > +      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
> > +      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
> > +					 && wincap.build_number () >= 19041)

No problems checking for the OS versions, but not like this.

  wincap.osname () >= "10.0"   ?

That will not do what you expect it to do.  wincap.osname() is a char *
and the >= operator will not work as on cstring in C++, but compare the
pointer values of the two strings instead.

While changing this to

  strcmp (wincap.osname (), "10.0") >= 0

is possible, it doesn't make sense.  For all supported Windows versions,
the build number is unambiguously bumped with each new release.  So
there's no older OS version with a build number >= 19041.  As a result,
the check for osname() can simply go away.

But then again, this is a windows feature which would best served by
adding a bit flag to the wincaps array, *and* we already have a wincaps
array for windows versions starting with build number 19041
(wincap_10_2004).

So, Brian, would you mind to create a followup patch which rather defines
a new bitflag in the wincaps array, set it to false or true according
to the OS version, and check this flag instead?


Thanks,
Corinna
