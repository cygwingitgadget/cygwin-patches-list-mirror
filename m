Return-Path: <cygwin-patches-return-4178-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15842 invoked by alias); 8 Sep 2003 20:53:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15831 invoked from network); 8 Sep 2003 20:53:13 -0000
Date: Mon, 08 Sep 2003 20:53:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getusershell, setusershell, endusershell
Message-ID: <20030908205312.GG27113@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030908202607.GM1859@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908202607.GM1859@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00194.txt.bz2

On Mon, Sep 08, 2003 at 10:26:07PM +0200, Corinna Vinschen wrote:
>FWIW, I've added these three functions to Cygwin.  But there's something
>which might need another tweak.  Getusershell returns shells from an
>internal list of default shells if /etc/shells isn't available.
>
>According to the Linux man pages, these are /bin/sh and /bin/csh.
>I've implemented this list accordingly, just adding /usr/bin paths:
>
>    /bin/sh			/usr/bin/sh
>    /bin/csh			/usr/bin/csh
>
>However, I had another look into the Solaris man pages.  According to
>these man pages, the list on Solaris 9 looks a bit more complete:
>
>    /bin/bash			/usr/bin/bash
>    /bin/csh			/usr/bin/csh
>    /bin/jsh			/usr/bin/jsh
>    /bin/ksh			/usr/bin/ksh
>    /bin/pfcsh			/usr/bin/pfcsh
>    /bin/pfksh			/usr/bin/pfksh
>    /bin/pfsh			/usr/bin/pfsh
>    /bin/sh			/usr/bin/sh
>    /bin/tcsh			/usr/bin/tcsh
>    /bin/zsh			/usr/bin/zsh
>    /sbin/jsh			/sbin/sh
>    /usr/xpg4/bin/sh
>
>Wow.  So the default shell list contains any shell which might be
>shipped with Solaris and perhaps some more.
>
>Should we do the same in Cygwin, adding all shells to the internal
>default shell list, which are part of the Cygwin distro?  This would
>bloat the list to something like
>
>    /bin/sh			/usr/bin/sh
>    /bin/bash			/usr/bin/bash
>    /bin/csh			/usr/bin/csh
>    /bin/tcsh			/usr/bin/tcsh
>    /bin/ksh			/usr/bin/ksh
>    /bin/pdksh			/usr/bin/pdksh
>    /bin/zsh			/usr/bin/zsh
>
>Or should we keep the short list as on Linux, knowing that our
>postinstall scripts add and manipulate /etc/shells as needed?

I'm for anything which keeps the size of the DLL down.  If we
don't need to have an internal table, then I think we should
rely on the postinstall scripts.

cgf
