Return-Path: <cygwin-patches-return-5012-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26739 invoked by alias); 5 Oct 2004 08:15:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26714 invoked from network); 5 Oct 2004 08:15:24 -0000
Date: Tue, 05 Oct 2004 08:15:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041005081629.GI6702@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00013.txt.bz2

On Oct  5 07:15, Bas van Gompel wrote:
> Hi,
> 
> This little patch makes cygcheck warn about empty path-components
> (leading/trailing/double ':'/';' in $PATH).
> 
> 
> ChangeLog-entry:
> 
> 2004-10-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
> 
> 	* cygcheck.cc (dump_sysinfo): Warn about empty path-components.

This looks ok, but it doesn't make much sense when started from a
Cygwin shell.  The reason is that empty paths are converted to "."
or ".\" respectively when converting between posix and win32 paths.

Chris, I might be missing something but that looks like a bug in
conv_path_list to me.  Why is conv_fn called with "." for empty
strings instead of ignoring the empty path?

Is an empty path component a windowzism I don't know about?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
