Return-Path: <cygwin-patches-return-5524-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32584 invoked by alias); 6 Jun 2005 21:15:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32568 invoked by uid 22791); 6 Jun 2005 21:15:14 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 21:15:14 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3AB9913C28E; Mon,  6 Jun 2005 17:15:13 -0400 (EDT)
Date: Mon, 06 Jun 2005 21:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
Message-ID: <20050606211513.GA16960@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050606193232.GA12606@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061536381.15703@slinky.cs.nyu.edu> <20050606195234.GA13442@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061556260.15703@slinky.cs.nyu.edu> <20050606204230.GA14555@trixie.casa.cgf.cx> <20050606205259.GB14555@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061710450.15703@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0506061710450.15703@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00120.txt.bz2

On Mon, Jun 06, 2005 at 05:12:02PM -0400, Igor Pechtchanski wrote:
>On Mon, 6 Jun 2005, Christopher Faylor wrote:
>
>> On Mon, Jun 06, 2005 at 04:42:30PM -0400, Christopher Faylor wrote:
>> >On Mon, Jun 06, 2005 at 04:09:13PM -0400, Igor Pechtchanski wrote:
>> >I guess you could do it that way.  It would look more transparent to the
>> >end user if you did.  You'd still have to make it clear that this has to
>> >happen first thing in the main() function or you could suffer problems
>> >with automatic initialization or constructors.
>>
>> Actually, if you do it that way, there's no reason to pass in main()
>> since the DLL already knows how to find it.
>
>True, provided you're not doing this from a console application which uses
>WinMain (but then the arguments will all be different as well).

Actually, nevermind.  Cygwin only knows the address of main() in true cygwin
routines.

cgf
