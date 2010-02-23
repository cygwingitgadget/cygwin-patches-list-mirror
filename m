Return-Path: <cygwin-patches-return-6974-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30397 invoked by alias); 23 Feb 2010 14:15:43 -0000
Received: (qmail 30375 invoked by uid 22791); 23 Feb 2010 14:15:41 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-48-46-17.bstnma.fios.verizon.net (HELO cgf.cx) (173.48.46.17)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 23 Feb 2010 14:15:37 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id B725913C0D0 	for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2010 09:15:35 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 6F43C2B352; Tue, 23 Feb 2010 09:15:35 -0500 (EST)
Date: Tue, 23 Feb 2010 14:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: terminfo [Re: console enhancements: mouse events etc]
Message-ID: <20100223141534.GA14481@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>  <20100126161036.GA31281@calimero.vinschen.de>  <4B718CB8.7070308@towo.net>  <4B72083C.2090205@cwilson.fastmail.fm>  <4B83A73C.1000208@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B83A73C.1000208@towo.net>
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
X-SW-Source: 2010-q1/txt/msg00090.txt.bz2

On Tue, Feb 23, 2010 at 11:00:28AM +0100, Thomas Wolff wrote:
>>
>> Thomas Wolff wrote:
>>    
>>> Actually, I just remember again that I though I should change the
>>> terminfo entry too. Just - where's the source to patch?
>>>      
>> http://mirrors.kernel.org/sources.redhat.com/cygwin/release/terminfo/terminfo-5.7_20091114-13-src.tar.bz2
>>
>> That -src package is basically just a wrapper around terminfo.src from
>> ncurses-5.7 (as of patch level 20091114).  So, the ultimate upstream
>> source is actually ncurses.  But I split it out specifically so that we
>> could do faster updates of terminfo (rebuilding all of ncurses simply to
>> change two characters in /usr/share/terminfo/[63|c]/cygwin is rather silly).
>>
>> So, send me patches against terminfo.src from that -src tarball, and
>> once we've got it figured out, I'll push it upstream to the ncurses
>> maintainer.
>>
>>    
>Sorry for the slightly late response. Attached is a small patch.

Wrong mailing list.

cgf
