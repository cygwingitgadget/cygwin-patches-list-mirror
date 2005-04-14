Return-Path: <cygwin-patches-return-5409-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26797 invoked by alias); 14 Apr 2005 10:05:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26745 invoked from network); 14 Apr 2005 10:05:32 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.30.117)
  by sourceware.org with SMTP; 14 Apr 2005 10:05:32 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id B7B8257D95; Thu, 14 Apr 2005 12:05:30 +0200 (CEST)
Date: Thu, 14 Apr 2005 10:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Correct debugging output in seteuid32
Message-ID: <20050414100530.GS22241@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <uoeci3qdv.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uoeci3qdv.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00005.txt.bz2

Hi Kazuhiro, welcome back :-)

On Apr 14 13:59, Kazuhiro Fujieda wrote:
> I'd submit a trivial patch after a long time.
> 
> 2005-04-14  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* syscalls.cc (setuid32): Correct debugging output.

Thanks for the patch.  I'll apply it at one point, but right now I'm
debugging at this very point, so this will take some time.  Stay tuned.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
