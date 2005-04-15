Return-Path: <cygwin-patches-return-5411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19828 invoked by alias); 15 Apr 2005 08:19:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19360 invoked from network); 15 Apr 2005 08:19:18 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.31.110)
  by sourceware.org with SMTP; 15 Apr 2005 08:19:18 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 571D357D95; Fri, 15 Apr 2005 10:19:16 +0200 (CEST)
Date: Fri, 15 Apr 2005 08:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Correct debugging output in seteuid32
Message-ID: <20050415081916.GA13816@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <uoeci3qdv.fsf@jaist.ac.jp> <3.0.5.32.20050414162424.00b6d018@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050414162424.00b6d018@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00007.txt.bz2

On Apr 14 16:24, Pierre A. Humblet wrote:
> I can see why would one think this is a bug, but it was meant
> to be that way. Having a "wrong" gid can make seteuid fail.
> Perhaps we could print the new and current uids and the current
> gid to cover all cases.

Yep, that's how I did it already locally.  I've applied it that way.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
