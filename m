Return-Path: <cygwin-patches-return-6336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30440 invoked by alias); 9 Jun 2008 13:46:45 -0000
Received: (qmail 30417 invoked by uid 22791); 9 Jun 2008 13:46:44 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-123.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (71.248.179.123)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 09 Jun 2008 13:46:21 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id EB27111910F; Mon,  9 Jun 2008 09:46:19 -0400 (EDT)
Date: Mon, 09 Jun 2008 13:46:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: abort() bug
Message-ID: <20080609134619.GD23198@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20080606T161417-232@post.gmane.org> <20080606175426.GA31949@ednor.casa.cgf.cx> <484D1E09.8030301@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484D1E09.8030301@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00007.txt.bz2

On Mon, Jun 09, 2008 at 06:11:53AM -0600, Eric Blake wrote:
> 2008-06-09  Eric Blake  <ebb9@byu.net>
>
> 	* signal.cc (abort): Only flush streams after signal handler.

Applied.  Thank you!

cgf
