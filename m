Return-Path: <cygwin-patches-return-5356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10364 invoked by alias); 22 Feb 2005 15:46:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10330 invoked from network); 22 Feb 2005 15:45:57 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.117.153)
  by sourceware.org with SMTP; 22 Feb 2005 15:45:57 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id CAEF357D77; Tue, 22 Feb 2005 16:45:55 +0100 (CET)
Date: Tue, 22 Feb 2005 15:46:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: RE: ssh problem on Windows XP]
Message-ID: <20050222154555.GE18314@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050121173426.GA16347@cygbert.vinschen.de> <20050122205845.A3967E54A@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122205845.A3967E54A@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00059.txt.bz2

On Jan 22 15:58, Bob Byrnes wrote:
> On Jan 21,  6:34pm, Corinna Vinschen wrote:
> -- Subject: [Fwd: RE: ssh problem on Windows XP]
> >
> > is there any chance that we get a fix in the next couple of weeks?
> 
> I remain absolutely committed to fixing the problems that have been
> reported, but I can't say that I'll have a fix in that timeframe,
> because I have some urgent deadlines for other projects.  Maybe
> early to mid-February?
> 
> > If we don't get a patch, I'm inclined to revert the pipe patch before
> > we release 1.5.13.
> 
> Instead of reverting the entire patch, if you want to restore the old
> behavior (select always returning true for writes on pipes), you could
> add a small piece of code to "short-circuit" the NtQueryInformationFile
> logic that I added.
> [...]

FYI, I've short-circuited the NtQueryInformationFile for now and set
pipes to always writable.  What convinced me even more that this
is temorarily the right thing to do is the fact that scp becomes at
least 3 times faster when short-circuiting NtQueryInformationFile.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
