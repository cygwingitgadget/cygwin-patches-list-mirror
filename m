Return-Path: <cygwin-patches-return-5979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23186 invoked by alias); 13 Sep 2006 15:32:51 -0000
Received: (qmail 23174 invoked by uid 22791); 13 Sep 2006 15:32:51 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 13 Sep 2006 15:32:46 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 3593E13C049; Wed, 13 Sep 2006 11:32:45 -0400 (EDT)
Date: Wed, 13 Sep 2006 15:32:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [ANNOUNCEMENT] Updated [experimental]: bash-3.1-7
Message-ID: <20060913153245.GA22278@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <091220061205.16953.4506A2720005FBDD0000423922135285730A050E040D0C079D0A@comcast.net> <20060912151512.GA19459@trixie.casa.cgf.cx> <4508002B.1010905@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4508002B.1010905@byu.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00074.txt.bz2

On Wed, Sep 13, 2006 at 06:57:15AM -0600, Eric Blake wrote:
>According to Christopher Faylor on 9/12/2006 9:15 AM:
>>> 2006-09-11  Eric Blake  <ebb9@byu.net>
>>>
>>> 	* cygcheck.cc (main): Restore POSIXLY_CORRECT before displaying
>>> 	user's environment.
>> 
>> Applied.
>
>Not quite.  The changelog changed, but cygcheck.cc is still pending :)
>http://cygwin.com/ml/cygwin-cvs/2006-q3/msg00158.html

Oops.  I got sidetracked with fixing the Makefile and forgot to actually
apply the patch.  Pretty stupid.

It is applied now.

cgf
