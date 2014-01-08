Return-Path: <cygwin-patches-return-7943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18345 invoked by alias); 8 Jan 2014 18:18:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18329 invoked by uid 89); 8 Jan 2014 18:18:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 18:18:45 +0000
Received: from pool-108-49-99-58.bstnma.fios.verizon.net ([108.49.99.58] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W0xiF-000G7r-UY	for cygwin-patches@cygwin.com; Wed, 08 Jan 2014 18:18:43 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id CC0B7600D3	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2014 13:18:40 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Wed, 08 Jan 2014 13:18:40 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19D5RHatGOW/wXxbL9DWQbc
Date: Wed, 08 Jan 2014 18:18:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to optionally disable overlapped pipes
Message-ID: <20140108181840.GA6704@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <037b01cf00fc$11014c10$3303e430$@motionview3d.com> <20131225041237.GA6930@ednor.casa.cgf.cx> <07dc01cf0c9b$93dea560$bb9bf020$@motionview3d.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dc01cf0c9b$93dea560$bb9bf020$@motionview3d.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00016.txt.bz2

On Wed, Jan 08, 2014 at 06:00:54PM -0000, James Johnston wrote:
>The function I modified is fhandler_pipe::create(fhandler_pipe**, unsigned,
>int).  This function is a thin wrapper around a more specific
>fhandler_pipe::create(LPSECURITY_ATTRIBUTES, PHANDLE, PHANDLE, DWORD, const
>char*, DWORD open_mode) with default values for some of the parameters for
>that more specific function, and it passes FILE_FLAG_OVERLAPPED by default.
>My change involved optionally removing FILE_FLAG_OVERLAPPED from the
>default.
>
>Critically, my change does NOT affect any code that uses the
>fhandler_pipe::create overload that takes 6 parameters.

I'm the author of the code and I'm familiar with the implications of what
you did.  You modified the way pipes are commonly created.  I'm not
comfortable supporting code which has that option.

cgf
