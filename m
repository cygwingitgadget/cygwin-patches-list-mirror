Return-Path: <cygwin-patches-return-4417-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31268 invoked by alias); 17 Nov 2003 22:18:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31257 invoked from network); 17 Nov 2003 22:18:57 -0000
Date: Mon, 17 Nov 2003 22:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: (fhandler_base::lseek): Include high order bits in return.
Message-ID: <20031117221856.GQ18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311171454590.922@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311171454590.922@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00136.txt.bz2

On Mon, Nov 17, 2003 at 03:29:07PM -0600, Brian Ford wrote:
> This bug fix got our app past its first problem with > 2 Gig files, but
> then it tripped over ftello.  I'm still trying to figure that one out.
> 
> It looks like it got a 32 bit sign extended value somewhere.  Any help would
> be appreciated.  Thanks.
> 
> 2003-11-17  Brian Ford  <ford@vss.fsi.com>
> 
> 	* fhandler.cc (fhandler_base::lseek): Include high order offset
> 	bits in return value.

Good catch.  Applied.

Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
