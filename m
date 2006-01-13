Return-Path: <cygwin-patches-return-5710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16482 invoked by alias); 13 Jan 2006 04:15:33 -0000
Received: (qmail 16460 invoked by uid 22791); 13 Jan 2006 04:15:32 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 13 Jan 2006 04:15:31 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id EEB1313C23A; Thu, 12 Jan 2006 23:15:29 -0500 (EST)
Date: Fri, 13 Jan 2006 04:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Proposed clarification of the snapshot installation FAQ
Message-ID: <20060113041529.GB11985@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dpu1ks$i0a$1@sea.gmane.org> <43C32DA9.2070900@cygwin.com> <dpvba1$i83$1@sea.gmane.org> <43C3F412.1010008@cygwin.com> <dq3d00$4o7$1@sea.gmane.org> <Pine.GSO.4.63.0601111200110.9317@access1.cims.nyu.edu> <dq3h09$k5o$1@sea.gmane.org> <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu> <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00019.txt.bz2

On Thu, Jan 12, 2006 at 07:57:27PM -0800, Joshua Daniel Franklin wrote:
>On 1/11/06, Igor Peshansky wrote:
>> As mentioned in <http://cygwin.com/ml/cygwin/2006-01/msg00537.html>,
>> here's a patch to the FAQ to clarify the section on installing snapshots.
>> I didn't know whether the various *.texinfo files are still used, so I
>> ported the modifications there as well, just in case.
>
>Applied to faq-setup.xml (the texinfo files are no longer used... I suppose I
>should remove them). It would be nice to have a sample batch file that automated
>the cygwin1.dll replacement, too.

I was hoping for a little more discussion about this.  I think Corinna and I
are both a little despondent over the fact that we have to be SUPER precise
about obvious things like when you say something like "cd /tmp" it means
that you should be doing it in a POSIX shell.  I have to wonder what kind
of useful feedback we'll get from people who can't figure this out.  I also
was going to caution against telling everyone to "try a snapshot" at the
first hint of trouble.  I don't think that this should be used as a panacea,
although I realize that the length of time since the last cygwin release has
made it attractive.

...but that's not an issue for this mailing list...

Nevertheless, the advice about using "mv" to rename cygwin1.dll won't work
on every version of Windows and needs to be changed.  I didn't read much
else besides that because I was just too depressed by the fact that the
current words were <quote>confusing</unquote>.

cgf
