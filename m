Return-Path: <cygwin-patches-return-3443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31959 invoked by alias); 21 Jan 2003 18:01:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31936 invoked from network); 21 Jan 2003 18:01:29 -0000
Date: Tue, 21 Jan 2003 18:01:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: nanosleep() patch
In-reply-to: <20030121161706.GU29236@cygbert.vinschen.de>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030121180536.GC628@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030117192853.GA1164@tishler.net>
 <20030121155842.GS29236@cygbert.vinschen.de>
 <20030121160201.GA13579@redhat.com>
 <20030121161706.GU29236@cygbert.vinschen.de>
X-SW-Source: 2003-q1/txt/msg00092.txt.bz2

Corinna,
Chris,

Thanks for your feedback.

On Tue, Jan 21, 2003 at 05:17:06PM +0100, Corinna Vinschen wrote:
> On Tue, Jan 21, 2003 at 11:02:01AM -0500, Christopher Faylor wrote:
> > On Tue, Jan 21, 2003 at 04:58:42PM +0100, Corinna Vinschen wrote:
> > >I'm wondering if we could do without an extra function
> > >sleep_worker() and let nanosleep() be the basic implementation.  So
> > >sleep() as well as usleep() could call nanosleep().  Isn't that
> > >done that way in the Linux kernel, too?
> > 
> > In that case, nanosleep needs to be rewritten to deal with the same
> > issues as sleep().
> 
> Sure.  nanosleep would be sleep_worker with timespec arguments.

OK, I will rework the patch as specified above.

Regarding usleep(), I was afraid to change it to use nanosleep() (aka
sleep_worker()) because its implementation was different than sleep().
Additionally, its current behavior does not seem to agree with what is
documented in "man 3 usleep" under Red Hat Linux 8.0.  Should I include
a reworked usleep() in the next version of this patch?

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
