Return-Path: <cygwin-patches-return-3434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15954 invoked by alias); 21 Jan 2003 15:58:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15872 invoked from network); 21 Jan 2003 15:58:45 -0000
Date: Tue, 21 Jan 2003 15:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: nanosleep() patch
Message-ID: <20030121155842.GS29236@cygbert.vinschen.de>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@cygwin.com>
References: <20030117192853.GA1164@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117192853.GA1164@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00083.txt.bz2

Hi Jason,

On Fri, Jan 17, 2003 at 02:28:53PM -0500, Jason Tishler wrote:
> Attached is a patch that implements nanosleep() by attempting to
> reuse the current sleep() implementation which seems to provide the
> necessary functionality.
> 
> I'm not sure if there is a better way to convey the fact that
> sleep_worker() was interrupted than my current implementation.
> Comments on this issue and the patch in general are welcome.

I'm wondering if we could do without an extra function sleep_worker()
and let nanosleep() be the basic implementation.  So sleep() as well
as usleep() could call nanosleep().  Isn't that done that way in the
Linux kernel, too?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
