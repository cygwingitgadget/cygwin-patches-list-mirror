Return-Path: <cygwin-patches-return-5415-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14581 invoked by alias); 20 Apr 2005 12:28:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14281 invoked from network); 20 Apr 2005 12:27:52 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.29.116)
  by sourceware.org with SMTP; 20 Apr 2005 12:27:52 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 433FE57DAC; Wed, 20 Apr 2005 14:27:50 +0200 (CEST)
Date: Wed, 20 Apr 2005 12:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygdrive and user/system documentation clarification
Message-ID: <20050420122750.GZ16098@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY10-F31320CAABACB6330AD865EE9290@phx.gbl> <426449CF.CD24BEB8@dessent.net> <wkd5sq1tgn.fsf@mx0.connact.com> <20050419193940.GF26832@trixie.casa.cgf.cx> <wkmzruzcbv.fsf@mx0.connact.com> <4265F5D6.2458C631@dessent.net> <20050420104114.GX16098@cygbert.vinschen.de> <42663D0B.D913AC34@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42663D0B.D913AC34@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00011.txt.bz2

On Apr 20 04:29, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Looks good to me.  However, please send patches to cygwin-patches and
> > add a ChangeLog entry.
> 
> As requested.  I include two patches and two ChangeLog entries since the
> two files are in different directories.  Is that the preferred way?

Definitely, since both directories have their own ChengeLog file.

> utils/
> 2005-04-20  Brian Dessent  <brian@dessent.net>
> 
> 	* utils.sgml (mount): Clarify setting cygdrive prefix for user
> 	and system-wide.
> 
> doc/
> 2005-04-20  Brian Dessent  <brian@dessent.net>
> 
> 	* pathnames.sgml (mount-table): Indicate that user-specific
> 	mounts override system-wide.

Thanks for the patches, applied.


Corinna

P.S.: Weren't you going to send a copyright assignment at one point?

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
