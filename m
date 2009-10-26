Return-Path: <cygwin-patches-return-6805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23175 invoked by alias); 26 Oct 2009 14:43:15 -0000
Received: (qmail 22910 invoked by uid 22791); 26 Oct 2009 14:43:14 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 26 Oct 2009 14:43:11 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 474B13B0002 	for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2009 10:43:01 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 43DEE2B352; Mon, 26 Oct 2009 10:43:01 -0400 (EDT)
Date: Mon, 26 Oct 2009 14:43:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Sync pseudo-reloc.c, round #2
Message-ID: <20091026144301.GC15778@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AE4A701.3050206@cwilson.fastmail.fm>  <4AE4B419.1060502@cwilson.fastmail.fm>  <20091025211540.GA1658@ednor.casa.cgf.cx>  <4AE4E16F.6040700@cwilson.fastmail.fm>  <4AE5B44E.2070302@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AE5B44E.2070302@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00136.txt.bz2

On Mon, Oct 26, 2009 at 10:38:06AM -0400, Charles Wilson wrote:
>Charles Wilson wrote:
>> Thx. Committed. Now I've just got to get the mingw version committed,
>> and then take the 2-liner revision back to mingw64...
>
>Aaaargh.  While preparing the final synchronization patch for the
>mingw64 folks, I noticed a *second* error path that I had not yet tested
>-- and it had the same bug. The attached patch fixes that one (the
>synchronization patch I just sent to the mingw64 guys includes this change).
>
>2009-10-26  Charles Wilson  <...>
>
>        * lib/pseudo-reloc.c (__report_error) [CYGWIN]: Correct size bug
>        regarding error messages.
>
>Tested the affected error path, and the normal code path, with this change.
>
>OK? (and sorry for all the churn; hopefully this is the last of it)

Yes.

cgf
