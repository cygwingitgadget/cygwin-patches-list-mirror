Return-Path: <cygwin-patches-return-5711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23480 invoked by alias); 13 Jan 2006 04:38:17 -0000
Received: (qmail 23470 invoked by uid 22791); 13 Jan 2006 04:38:17 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 13 Jan 2006 04:38:14 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k0D4cDA7027183 	for <cygwin-patches@cygwin.com>; Thu, 12 Jan 2006 23:38:13 -0500 (EST)
Date: Fri, 13 Jan 2006 04:38:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Proposed clarification of the snapshot installation FAQ
In-Reply-To: <20060113041529.GB11985@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.63.0601122333160.27020@access1.cims.nyu.edu>
References: <dpu1ks$i0a$1@sea.gmane.org> <43C32DA9.2070900@cygwin.com>  <dpvba1$i83$1@sea.gmane.org> <43C3F412.1010008@cygwin.com> <dq3d00$4o7$1@sea.gmane.org>  <Pine.GSO.4.63.0601111200110.9317@access1.cims.nyu.edu> <dq3h09$k5o$1@sea.gmane.org>  <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu>  <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com>  <20060113041529.GB11985@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00020.txt.bz2

On Thu, 12 Jan 2006, Christopher Faylor wrote:

> On Thu, Jan 12, 2006 at 07:57:27PM -0800, Joshua Daniel Franklin wrote:
> >On 1/11/06, Igor Peshansky wrote:
> >> As mentioned in <http://cygwin.com/ml/cygwin/2006-01/msg00537.html>,
> >> here's a patch to the FAQ to clarify the section on installing
> >> snapshots. I didn't know whether the various *.texinfo files are
> >> still used, so I ported the modifications there as well, just in
> >> case.
> >
> >Applied to faq-setup.xml

Thanks.

> >(the texinfo files are no longer used... I suppose I should remove
> >them).

Yes, please.

> >It would be nice to have a sample batch file that automated the
> >cygwin1.dll replacement, too.
>
> I was hoping for a little more discussion about this.  I think Corinna
> and I are both a little despondent over the fact that we have to be
> SUPER precise about obvious things like when you say something like "cd
> /tmp" it means that you should be doing it in a POSIX shell.  I have to
> wonder what kind of useful feedback we'll get from people who can't
> figure this out.  I also was going to caution against telling everyone
> to "try a snapshot" at the first hint of trouble.  I don't think that
> this should be used as a panacea, although I realize that the length of
> time since the last cygwin release has made it attractive.
>
> ...but that's not an issue for this mailing list...

Right.

> Nevertheless, the advice about using "mv" to rename cygwin1.dll won't
> work on every version of Windows and needs to be changed.

Hmm, it's worked for me on Win98, Win2k, and WinXP (though I suppose there
could be differences on, say, WinNT4 or something)...  I basically wanted
to avoid giving too many things to do in Windows Explorer.  But no matter
-- I'll submit a patch with this change shortly.

FWIW, I usually do "cd /bin && cygstart cmd", and then close the bash
shell and do the renaming in the CMD window.  However, I don't think this
particular set of instructions can rely on the presence of cygstart...

> I didn't read much else besides that because I was just too depressed by
> the fact that the current words were <quote>confusing</unquote>.

Sigh...  I'm sure there'll be complaints about my wording too.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
