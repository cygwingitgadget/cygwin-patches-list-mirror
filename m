Return-Path: <cygwin-patches-return-4314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8243 invoked by alias); 24 Oct 2003 12:11:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8229 invoked from network); 24 Oct 2003 12:11:37 -0000
Date: Fri, 24 Oct 2003 12:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::fcntl (F_SETFL)
Message-ID: <20031024121135.GC1653@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310231746410.823@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310231746410.823@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00033.txt.bz2

On Thu, Oct 23, 2003 at 05:53:13PM -0500, Brian Ford wrote:
> I'm working on my stupid pedantic patch tricks.  Can you tell? :)
> 
> 2003-10-23  Brian Ford  <ford@vss.fsi.com>
> 
> 	* fhandler.cc (fhandler_base::fcntl): Don't clobber O_APPEND when
> 	both O_NONBLOCK/O_NDELAY are set for F_SETFL.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
