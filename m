Return-Path: <cygwin-patches-return-6082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9405 invoked by alias); 15 May 2007 01:24:22 -0000
Received: (qmail 9378 invoked by uid 22791); 15 May 2007 01:24:14 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-68.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 15 May 2007 01:24:12 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2F4462B353; Mon, 14 May 2007 21:24:10 -0400 (EDT)
Date: Tue, 15 May 2007 01:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: export a few newlib functions
Message-ID: <20070515012410.GA12008@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46490414.7020505@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46490414.7020505@byu.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00028.txt.bz2

On Mon, May 14, 2007 at 06:51:32PM -0600, Eric Blake wrote:
>As discussed this morning:
>
>2007-05-14  Eric Blake  <ebb9@byu.net>
>
>	* cygwin.din (asnprintf, dprint, _Exit, vasnprintf, vdprintf):
>	Export.
>	* include/cygwin/version.h: Bump API minor number.

Applied.  Thanks.

cgf

(Doh.  I could have just asked you to apply it, couldn't I?)
