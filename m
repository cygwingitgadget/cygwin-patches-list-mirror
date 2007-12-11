Return-Path: <cygwin-patches-return-6180-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14630 invoked by alias); 11 Dec 2007 14:19:01 -0000
Received: (qmail 14620 invoked by uid 22791); 11 Dec 2007 14:19:00 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 14:18:54 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 85FD42B352; Tue, 11 Dec 2007 09:18:52 -0500 (EST)
Date: Tue, 11 Dec 2007 14:19:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: Cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: Cygheap page boundary allocation bug.
Message-ID: <20071211141852.GA3619@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin patches <cygwin-patches@cygwin.com>
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00032.txt.bz2

On Tue, Dec 11, 2007 at 12:18:17PM -0000, Dave Korn wrote:
>2007-12-11  Dave Korn  <dave.korn@artimi.com>
>
>	* cygheap.cc (_csbrk):  Don't request zero bytes from VirtualAlloc,
>	as windows treats that as an invalid parameter and returns an error.

Ok.

cgf
