Return-Path: <cygwin-patches-return-3470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15390 invoked by alias); 1 Feb 2003 04:43:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15378 invoked from network); 1 Feb 2003 04:43:33 -0000
Date: Sat, 01 Feb 2003 04:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] - tc{set,get}attr() error checking and B0 support
Message-ID: <20030201044405.GA21007@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4.3.2.7.2.20030122170920.00b83008@smtphost-cod.intra.kyocera-wireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20030122170920.00b83008@smtphost-cod.intra.kyocera-wireless.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00119.txt.bz2

On Wed, Jan 22, 2003 at 05:34:36PM -0700, Troy Curtiss wrote:
>Per your comments on my prior patches, I have re-architected my
>error-checking changes so that the short-circuiting behavior in
>tcsetattr() is gone.  I also cleaned up the B0 (ie.  drop DTR) support
>to more closely resemble what POSIX expects while not enraging Win32 :)
>Please let me know if this passes muster - the prior test case program
>still applies.

I think the patch has nearly reached the size where an assignment is
required but since most of it is reformatting, I'll let it slide.

Rather than explicitly setting errno to EINVAL, the code had been
previously setting the errno based on the error reported by Windows.  I
don't see any reason to stop doing that.  It will probably default to
EINVAL anyway, but, if it doesn't, then a more explicit errno is
probably better.

Anyway, I'll check this in with some formatting and other stylistic
tweaks.

Thanks and sorry for the delay in reviewing this.
cgf
