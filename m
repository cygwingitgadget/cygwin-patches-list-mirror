Return-Path: <cygwin-patches-return-3466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18972 invoked by alias); 25 Jan 2003 10:38:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18958 invoked from network); 25 Jan 2003 10:38:00 -0000
Date: Sat, 25 Jan 2003 10:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95
Message-ID: <20030125103757.GA2117@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030124232917.007f1ae0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030124232917.007f1ae0@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00115.txt.bz2

On Fri, Jan 24, 2003 at 11:29:17PM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> This patch brings seteuid on Win95 up to Posix and fixes
> a handle leak on NT.

Applied.

> During testing (WinME) I noticed that "id" has stopped reporting
> the supplementary groups present in /etc/group. Thus it is likely
> that the suppl. groups are broken in is_grp_member() on NT.

Looks like somthing broke getgroups() in the last few days.

Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
