Return-Path: <cygwin-patches-return-3890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29916 invoked by alias); 24 May 2003 20:24:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29820 invoked from network); 24 May 2003 20:24:22 -0000
Date: Sat, 24 May 2003 20:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Proposed change for Win9x file permissions...
Message-ID: <20030524202421.GE19367@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030524175530.GB5604@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00117.txt.bz2

On Sat, May 24, 2003 at 01:55:30PM -0400, Christopher Faylor wrote:
> I like the idea but I'm wondering if it is too general.  Corinna, what do
> you think?

I like the idea as well but wouldn't that eventually cause problems if
the umask disables the user bits?  I'm a bit concerned about the new
arriving questions on the cygwin ML due to applications checking these
bits in combination with clueless users.  It would be better, IMHO, if
the umask couldn't mask the user bits at all, just the group and other
bits. 

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
