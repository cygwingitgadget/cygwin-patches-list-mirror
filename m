Return-Path: <cygwin-patches-return-3414-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7893 invoked by alias); 17 Jan 2003 05:28:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7883 invoked from network); 17 Jan 2003 05:28:01 -0000
Date: Fri, 17 Jan 2003 05:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group.
Message-ID: <20030117052905.GA3796@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030116015721.007ee100@mail.attbi.com> <20030116190718.GA27321@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030116190718.GA27321@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00063.txt.bz2

On Thu, Jan 16, 2003 at 02:07:18PM -0500, Christopher Faylor wrote:
>On Thu, Jan 16, 2003 at 01:57:21AM -0500, Pierre A. Humblet wrote:
>>Here is the code as it stands. It compiles & runs, and passes
>>fork tests correctly. Feel free to takeover or at least
>>have a look. I will continue testing tomorrow evening.
>>
>>I include only the 5 files that are related to etc_changed,
>>the 5 others (setuid on Win9X) can wait.
>
>Hmm.  I have a slightly less intrusive idea for how to handle this.  I'll
>check it in shortly.

Maybe not so "less intrusive" after all.  I broke out the etc handling
stuff into a separate class and moved even more functionality into
pwdgrp than you did.  I hope Corinna approves.

I also hope that I got all of your changes that didn't conflict with my
work in.  I'm generating a new snapshot now.  I guess we should ask
people to test it for a couple of days before I release 1.3.19.  Sigh.

Oh, and I just removed the warning when FindFirstChangeNotification
fails.  This should make the Novell users happy even though the
performance will be less than wonderful.

Thanks for your patch and your insight, Pierre.

cgf
