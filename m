Return-Path: <cygwin-patches-return-2689-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26518 invoked by alias); 23 Jul 2002 15:07:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26502 invoked from network); 23 Jul 2002 15:07:34 -0000
Date: Tue, 23 Jul 2002 08:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
Message-ID: <20020723170732.F13588@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com> <20020719102328.E6932@cygbert.vinschen.de> <3D382572.5BEF1C2C@ieee.org> <20020719170639.R6932@cygbert.vinschen.de> <20020723145510.C13588@cygbert.vinschen.de> <3D3D5FBE.EE322E22@ieee.org> <20020723161843.D13588@cygbert.vinschen.de> <3D3D6DFB.AA7F472E@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3D6DFB.AA7F472E@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00137.txt.bz2

On Tue, Jul 23, 2002 at 10:53:47AM -0400, Pierre A. Humblet wrote:
> True, there is a way...
> I found the mail thread. It's weird that apparently he can get
> mkpasswd to work. NetUserEnum in mkpasswd SHOULD fail for the same reason
> that NetUserGetGroups is failing in get_user_groups.
> Ah, but with -d -u mkpasswd uses NetUserGetInfo, not NetUserEnum. 
> Still, it SHOULD fail too.

But it's not the same situation.  When calling mkpasswd he's
logged in as authenticated user.  When NetUserGetGroups() is called,
it's called from an account which is unknown to the domain (SYSTEM)
and so is treated as anonymous... at least it's as I understand the
situation.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
