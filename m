Return-Path: <cygwin-patches-return-3530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22402 invoked by alias); 6 Feb 2003 18:24:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22388 invoked from network); 6 Feb 2003 18:24:15 -0000
Date: Thu, 06 Feb 2003 18:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends
Message-ID: <20030206182413.GL5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030206174750.GK5822@cygbert.vinschen.de> <Pine.GSO.4.44.0302061302440.16397-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0302061302440.16397-100000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00179.txt.bz2

On Thu, Feb 06, 2003 at 01:10:33PM -0500, Igor Pechtchanski wrote:
> No problem, I'll rewrite this (after actually looking at the code this
> time).  However, at least on my machine, most of the files, especially in
> /cygdrive/c, are owned by the Administrators group.  If it's not in
> /etc/passwd, most files show up with "????????" for the user, which is not
> very informative...

Sure but in this case the admins group is treated as a user since it's
in the user entry of the file's security descriptor.

I think we never get that right.  The problem is that the ls entries
only are 8 chars long, not enough to be really informative.  Whatever
you put in there ("unknown", "????????", "mkpasswd", "run mkpa",
"dumbass"), you will deterministically get confused users.

Which means, I appreciate that you're going to add a few words to the
users guide.  It's something we can point people to.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
