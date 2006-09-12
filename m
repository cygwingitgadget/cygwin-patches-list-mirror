Return-Path: <cygwin-patches-return-5977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9815 invoked by alias); 12 Sep 2006 15:15:19 -0000
Received: (qmail 9804 invoked by uid 22791); 12 Sep 2006 15:15:18 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 12 Sep 2006 15:15:14 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id A068913C049; Tue, 12 Sep 2006 11:15:12 -0400 (EDT)
Date: Tue, 12 Sep 2006 15:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, Eric Blake <ericblake@comcast.net>
Subject: Re: [ANNOUNCEMENT] Updated [experimental]: bash-3.1-7
Message-ID: <20060912151512.GA19459@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, 	Eric Blake <ericblake@comcast.net>
References: <091220061205.16953.4506A2720005FBDD0000423922135285730A050E040D0C079D0A@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <091220061205.16953.4506A2720005FBDD0000423922135285730A050E040D0C079D0A@comcast.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00072.txt.bz2

On Tue, Sep 12, 2006 at 12:05:06PM +0000, Eric Blake wrote:
>> > That is being set by cygcheck, just before invoking external programs.  It 
>> > probably had something to do with forcing external programs to not rearrange 
>> > option arguments (for example, "ls foo --all" treats --all as an option, 
>> > but "POSIXLY_CORRECT=1 ls foo --all" treats --all as a filename).  But I think 
>> > it is possible to get along without doing it (repeating the example, "ls -- 
>> > foo --all" treats --all as a filename), and I personally think that cygcheck 
>> > should be patched to QUIT setting POSIXLY_CORRECT, so that we can tell the 
>> > masochists apart from normal users.
>> 
>> Ah, ok, so seeing it in cygcheck is a false positive. Didn't think that 
>> cygcheck would tinker with my environment (maybe it should know it is 
>> doing so and preserve the invocation value and print that?), so I didn't 
>> think to actually 'echo $POSIXLY_CORRECT'. :-)
>> 
>
>2006-09-11  Eric Blake  <ebb9@byu.net>
>
>	* cygcheck.cc (main): Restore POSIXLY_CORRECT before displaying
>	user's environment.

Applied.

Thanks, Eric.

cgf
