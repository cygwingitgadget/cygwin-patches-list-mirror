Return-Path: <cygwin-patches-return-6843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8991 invoked by alias); 18 Nov 2009 20:48:20 -0000
Received: (qmail 8908 invoked by uid 22791); 18 Nov 2009 20:48:13 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Nov 2009 20:47:20 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id DB1733B0002 	for <cygwin-patches@cygwin.com>; Wed, 18 Nov 2009 15:47:09 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 8CA5E2B352; Wed, 18 Nov 2009 15:47:09 -0500 (EST)
Date: Wed, 18 Nov 2009 20:48:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
Message-ID: <20091118204709.GA3461@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B045581.4040301@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B045581.4040301@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00174.txt.bz2

On Wed, Nov 18, 2009 at 01:13:53PM -0700, Eric Blake wrote:
>2009-11-18  Eric Blake  <ebb9@byu.net>
>
>	* signal.cc (nanosleep): Support 'infinite' sleep times.
>	(sleep): Avoid uninitialized memory.

Sorry but, while I agree with the basic idea, this seems like
unnecessary use of recursion.  It seems like you could accomplish the
same thing by just putting the cancelable_wait in a for loop.  I think
adding recursion here obfuscates the function unnecesarily.

cgf
