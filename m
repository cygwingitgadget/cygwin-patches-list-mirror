Return-Path: <cygwin-patches-return-3438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7269 invoked by alias); 21 Jan 2003 16:17:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7203 invoked from network); 21 Jan 2003 16:17:08 -0000
Date: Tue, 21 Jan 2003 16:17:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep() patch
Message-ID: <20030121161706.GU29236@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030117192853.GA1164@tishler.net> <20030121155842.GS29236@cygbert.vinschen.de> <20030121160201.GA13579@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121160201.GA13579@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00087.txt.bz2

On Tue, Jan 21, 2003 at 11:02:01AM -0500, Christopher Faylor wrote:
> On Tue, Jan 21, 2003 at 04:58:42PM +0100, Corinna Vinschen wrote:
> >I'm wondering if we could do without an extra function sleep_worker()
> >and let nanosleep() be the basic implementation.  So sleep() as well
> >as usleep() could call nanosleep().  Isn't that done that way in the
> >Linux kernel, too?
> 
> In that case, nanosleep needs to be rewritten to deal with the same
> issues as sleep().

Sure.  nanosleep would be sleep_worker with timespec arguments.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
