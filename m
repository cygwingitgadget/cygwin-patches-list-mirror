Return-Path: <cygwin-patches-return-5310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14840 invoked by alias); 21 Jan 2005 17:34:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14346 invoked from network); 21 Jan 2005 17:34:28 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.115.92)
  by sourceware.org with SMTP; 21 Jan 2005 17:34:28 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id AAF7C5808F; Fri, 21 Jan 2005 18:34:26 +0100 (CET)
Date: Fri, 21 Jan 2005 17:34:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: Bob Byrnes <byrnes@curl.com>
Cc: cygwin-patches@cygwin.com
Subject: [Fwd: RE: ssh problem on Windows XP]
Message-ID: <20050121173426.GA16347@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Bob Byrnes <byrnes@curl.com>,
	cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00013.txt.bz2

Bob,

----- Forwarded message from "Waiss, Garrett" -----
> Date: Fri, 21 Jan 2005 06:51:59 -0800
> From: "Waiss, Garrett" 
> Subject: RE: ssh problem on Windows XP
> To: Cygwin List
> 
> Good luck. I gave up and "downgraded" to cygwin 1.5.10-3. If you are
> running any release after that on XP SP2, there is a piping issue that
> has not been addressed.
> 
> -----Original Message-----
> From: cygwin-owner@cygwin.com [mailto:cygwin-owner@cygwin.com] On Behalf
> Of Neven Luetic
> Sent: Friday, January 21, 2005 2:48 AM
> To: cygwin@cygwin.com
> Subject: ssh problem on Windows XP
> 
> 
> Hello,
> 
> I know, problems have been reported concerning the use of ssh on windows
> xp ("ssh hangs"). I would just like to confirm, if this is, what I'm
> dealing with. And perhaps somebody knows some workaround until there is
> a fix.
> [etc.]
----- End forwarded message -----

is there any chance that we get a fix in the next couple of weeks?
I'm really annoyed about all these reports of hanging processes over
ssh due to the pipe changes.  The only application which seems to
work better to date is apparently the Cygwin version of rsync.

If we don't get a patch, I'm inclined to revert the pipe patch before
we release 1.5.13.  IMHO it's not worth to have one application working
in favorite of tons of other applications.

Btw., didn't you announce more pipe patches yet to come?  Is it possible
that you already have a patch which will get that working again?  I'm
still hoping for something more satisfying than reverting...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
