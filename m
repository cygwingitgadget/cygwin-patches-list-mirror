Return-Path: <cygwin-patches-return-5301-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11462 invoked by alias); 8 Jan 2005 09:54:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11414 invoked from network); 8 Jan 2005 09:54:53 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.98.98)
  by sourceware.org with SMTP; 8 Jan 2005 09:54:53 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 3E9FA5808D; Sat,  8 Jan 2005 10:54:52 +0100 (CET)
Date: Sat, 08 Jan 2005 09:54:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: seteuid
Message-ID: <20050108095452.GA30857@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050107235918.00827de0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050107235918.00827de0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00004.txt.bz2

On Jan  7 23:59, Pierre A. Humblet wrote:
> 	* syscalls.cc (seteuid32): Only change the default dacl when
> 	seteuid succeeds. Do not close HKCU.

Thanks, please apply.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
