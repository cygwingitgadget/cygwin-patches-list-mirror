Return-Path: <cygwin-patches-return-4919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4975 invoked by alias); 28 Aug 2004 15:10:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4928 invoked from network); 28 Aug 2004 15:10:46 -0000
Date: Sat, 28 Aug 2004 15:10:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Truncate
Message-ID: <20040828151118.GB27978@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040827214238.00819640@incoming.verizon.net> <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net> <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net> <3.0.5.32.20040827214238.00819640@incoming.verizon.net> <3.0.5.32.20040828100709.0081d8c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040828100709.0081d8c0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00071.txt.bz2

On Aug 28 10:07, Pierre A. Humblet wrote:
> At 11:37 AM 8/28/2004 +0200, Corinna Vinschen wrote:
> >On Aug 27 21:42, Pierre A. Humblet wrote:
> >> 	* fhandler.cc (fhandler_base::write): In the lseek_bug case, set EOF
> >> 	before zero filling. Combine similar error handling statements. 
> >
> >the first part of the patch is ok, but somehow the new `goto' looks
> >somewhat weird to me.  What about this instead:
> 
> <snip>
> 
> Sure. Will you apply it?

Please apply it.  It's still your patch, basically.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
