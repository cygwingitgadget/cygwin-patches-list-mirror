Return-Path: <cygwin-patches-return-4938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23776 invoked by alias); 9 Sep 2004 20:12:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23721 invoked from network); 9 Sep 2004 20:11:59 -0000
Date: Thu, 09 Sep 2004 20:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] implementation of nonblocking writes on pipes
Message-ID: <20040909201317.GE28438@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040909140656.GE27325@trixie.casa.cgf.cx> <20040909181407.ECB49E598@wildcard.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909181407.ECB49E598@wildcard.curl.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00090.txt.bz2

On Thu, Sep 09, 2004 at 02:14:07PM -0400, Bob Byrnes wrote:
>On Sep 9, 10:06am, cgf-no-personal-reply-please@cygwin.com (Christopher Faylor) wrote:
>-- Subject: Re: [Patch] implementation of nonblocking writes on pipes
>>
>> Before we start adding more patches which are based on your previous work,
>> could you reply to some of the problems raised in the cygwin mailing list?
>
>Sure, I'll do that now (I've fallen a few days behind reading that list).
>
>> There was one problem with Windows 95 which Corinna fixed but now there
>> is another problem with using rsync, which I thought was one of the
>> impetuses for your patch.
>>
>-- End of excerpt from Christopher Faylor
>
>The win95 problem was unfortunate ... I don't have a win95 system here
>to test.  I'll look more closely at the patch, but I think it is correct.
>
>The rsync problem (I assume you are talking about "rsync + xp sp2 failing")
>appears to be unrelated to my patch, because I think the failure is reported
>for file desriptors from a socketpair, not a pipe.  I'll try to confirm that.

Ok, thanks.  I didn't look at the error too closely, so you're probably
corect.

cgf
