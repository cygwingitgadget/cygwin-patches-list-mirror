Return-Path: <cygwin-patches-return-3463-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31461 invoked by alias); 24 Jan 2003 16:06:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31435 invoked from network); 24 Jan 2003 16:06:29 -0000
Date: Fri, 24 Jan 2003 16:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep() patch
Message-ID: <20030124160627.GP29236@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030121155842.GS29236@cygbert.vinschen.de> <20030121160201.GA13579@redhat.com> <20030121161706.GU29236@cygbert.vinschen.de> <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com> <20030121211649.GA2060@tishler.net> <20030121213341.GA952@tishler.net> <20030121214016.GA19951@redhat.com> <20030122104402.GB29236@cygbert.vinschen.de> <20030124155815.GD612@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124155815.GD612@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00112.txt.bz2

On Fri, Jan 24, 2003 at 10:58:15AM -0500, Jason Tishler wrote:
> On Wed, Jan 22, 2003 at 11:44:02AM +0100, Corinna Vinschen wrote:
> > I like that patch.  Applied.
> 
> I just realized that nanosleep() is not getting declared.  Is the
> attached patch the best solution?  If so, then I will submit a patch to
> newlib.  If not, what is?

Hmm, no.  This exposes all other functions in time.h still unavailable.

I think adding a 

#if defined(__CYGWIN__) && !defined(_POSIX_TIMERS)
int _EXFUN(nanosleep, (const struct timespec  *rqtp, struct timespec *rmtp));
#endif

would be more adequate so far.

Adding all missing POSIX timer functions to Cygwin would be more
satisfactory, though ;-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
