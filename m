Return-Path: <cygwin-patches-return-2778-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7534 invoked by alias); 6 Aug 2002 22:33:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7519 invoked from network); 6 Aug 2002 22:33:26 -0000
Message-ID: <013b01c23d99$a180f930$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01e501c23d74$400b2c90$6132bc3e@BABEL> <20020806220731.GG1386@redhat.com>
Subject: Re: init_cheap and _csbrk
Date: Tue, 06 Aug 2002 15:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00226.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> On Tue, Aug 06, 2002 at 07:08:21PM +0100, Conrad Scott wrote:
> I've checked in a modified version of this.  I actually wanted
to
> allocate some slop for the cygheap but the pagetrunc made sure
that
> I actually didn't do that.  So, I've changed things so that an
extra
> couple of pages are allocated.  It would be nice to find out
what the
> minimal amount of memory used during a small program would be
and
> just allocate that at the start to minimize calls to
VirtualAlloc.

I wasn't thinking of efficiency while I was looking at this.  I
was actually trying to understand an apparent memory leak on fork.
(I found that BTW: it's the "well-known" one in the per_thread
mechanism.  So I've stopped worrying about it.)

But: the slop will never get used AFAICT (so it's not really
slop).  That is, this padding just pushes the cygheap_max pointer
further up; all subsequent calls to _csbrk will allocate past that
point, and so the slop will remain unused.  So if you want the
slop to be allocated in future, you'll need to drag cygheap_max
back down to (char *) (cygheap + 1) + sbs --- ooh! that looks
familiar --- after the recursive call.  Unless I'm missing the
obvious of course.

> Also my aesthetic sense differs from yours so I didn't apply
that part.

That's the beauty of aesthetics :-)

Thanks,

// Conrad


