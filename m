Return-Path: <cygwin-patches-return-4975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25272 invoked by alias); 22 Sep 2004 14:04:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25259 invoked from network); 22 Sep 2004 14:04:48 -0000
Date: Wed, 22 Sep 2004 14:04:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
Message-ID: <20040922140648.GD26453@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net> <20040922134608.GA26453@trixie.casa.cgf.cx> <41518501.B3406DCF@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41518501.B3406DCF@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00127.txt.bz2

On Wed, Sep 22, 2004 at 09:58:25AM -0400, Pierre A. Humblet wrote:
>
>Christopher Faylor wrote:
>> 
>> On Tue, Sep 21, 2004 at 09:58:40PM -0400, Pierre A. Humblet wrote:
>> >It's a safe time to take care of a few nits...
>> >
>> >2004-09-22  Pierre Humblet <pierre.humblet@ieee.org>
>> >
>> >       * path.cc (normalize_win32_path): Only look for : in second position.
>> >       Avoid infinite loop with names starting in double dots.
>> >       (mount_info::conv_to_win32_path): Do not worry about a trailing dot.
>> 
>> Why not worry about a trailing dot?  Is it handled somewhere else?  The
>> intent is to make the inode of /foo/.  == /foo .
>
>Yes, that's handled in the appropriate normalize_xx_path function,
>together with xx/./yy , xx/../yy, and friends.

I'm just dotting i's but I notice that dir.cc calls hash_path_name with
an argument of ".".  That still works?

cgf
