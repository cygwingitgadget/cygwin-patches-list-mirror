Return-Path: <cygwin-patches-return-4474-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17471 invoked by alias); 4 Dec 2003 09:41:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17461 invoked from network); 4 Dec 2003 09:41:17 -0000
Date: Thu, 04 Dec 2003 09:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031204094116.GA26648@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <3.0.5.32.20031204002555.007ba380@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031204002555.007ba380@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00193.txt.bz2

On Thu, Dec 04, 2003 at 12:25:55AM -0500, Pierre A. Humblet wrote:
> Getting there, but I have questions.
> 1) Because I am inside cygwin, I assume I should use explicitly
>    struct __flock64 and fcntl64(). 
>    Or should I call fcntl_worker directly?

You can use fcntl_worker.  It's already declared in winsup.h.

> 2) Why does struct __flock64 have a "_off_t  l_start"
>    but a "_off64_t  l_len"  (in cygwin/types.h) ?

Urgh!  :-(   Thank god, this is only 3 days old.  Thanks for catching it.

> 3) If I use fcntl64, shouldn't I use lseek64 as well?
>    But then why does the rest of the utmp/wtmp code use lseek?

You can do this if you like but it's not necessary.  If you look what
values are used in these calls to lseek, you'll see that it's either
a seek to position 0 or a seek of sizeof(struct utmp).  And the return
value is never used.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
