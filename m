Return-Path: <cygwin-patches-return-5355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28758 invoked by alias); 17 Feb 2005 09:10:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28682 invoked from network); 17 Feb 2005 09:09:56 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.114.179)
  by sourceware.org with SMTP; 17 Feb 2005 09:09:56 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 6691257D77; Thu, 17 Feb 2005 10:09:55 +0100 (CET)
Date: Thu, 17 Feb 2005 09:10:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050217090955.GB12133@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de> <loom.20050210T160326-68@post.gmane.org> <20050210155633.GB2597@cygbert.vinschen.de> <loom.20050211T000509-58@post.gmane.org> <20050211142028.GD2597@cygbert.vinschen.de> <loom.20050215T004351-284@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050215T004351-284@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00058.txt.bz2

On Feb 14 23:59, Eric Blake wrote:
> Corinna Vinschen <vinschen <at> redhat.com> writes:
> > 
> > I guess trying my approach isn't the worst one, though.  We should
> > use that as a start point for further experimenting, IMHO.  I'll check
> > that in.
> > 
> 
> Checking win32.has_acls() and using GENERIC_WRITE caused a regression in utimes
> ().  The new upstream automake-1.9.5 tarball contains a read-only file (mode 
> 0444).  Before the 20050211 snapshot, when utimes() is still using 
> FILE_WRITE_ATTRIBUTES, tar does just fine at adjusting the timestamp of that 
> file when unpacking to an NFS-mounted directory.  However, with the current 
> code, when I tried to unpack, tar is no longer able to touch the timestamps of 
> the read-only file because GENERIC_WRITE requires write access for at least one 
> of user, group, and other, even though touching the timestamp does not.

Too bad.  I'll change the code to try FILE_WRITE_ATTRIBUTES first and
GENERIC_WRITE only if that fails.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
