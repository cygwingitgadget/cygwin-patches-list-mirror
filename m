Return-Path: <cygwin-patches-return-3464-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21132 invoked by alias); 24 Jan 2003 17:36:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21119 invoked from network); 24 Jan 2003 17:36:30 -0000
Date: Fri, 24 Jan 2003 17:36:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: nanosleep() patch
In-reply-to: <20030124160627.GP29236@cygbert.vinschen.de>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030124174339.GB2056@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030121160201.GA13579@redhat.com>
 <20030121161706.GU29236@cygbert.vinschen.de>
 <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com>
 <20030121211649.GA2060@tishler.net> <20030121213341.GA952@tishler.net>
 <20030121214016.GA19951@redhat.com>
 <20030122104402.GB29236@cygbert.vinschen.de>
 <20030124155815.GD612@tishler.net> <20030124160627.GP29236@cygbert.vinschen.de>
X-SW-Source: 2003-q1/txt/msg00113.txt.bz2

On Fri, Jan 24, 2003 at 05:06:27PM +0100, Corinna Vinschen wrote:
> I think adding a 
> 
> #if defined(__CYGWIN__) && !defined(_POSIX_TIMERS)
> int _EXFUN(nanosleep, (const struct timespec  *rqtp, struct timespec *rmtp));
> #endif
> 
> would be more adequate so far.
> 
> Adding all missing POSIX timer functions to Cygwin would be more
> satisfactory, though ;-)

I didn't add all the missing POSIX timer functions, but I did do the
following:

    http://sources.redhat.com/ml/newlib/2003/msg00056.html

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
