Return-Path: <cygwin-patches-return-3910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11180 invoked by alias); 26 May 2003 17:13:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11089 invoked from network); 26 May 2003 17:13:07 -0000
Date: Mon, 26 May 2003 17:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Proposed change for Win9x file permissions...
Message-ID: <20030526171305.GA15973@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com> <20030524202421.GE19367@cygbert.vinschen.de> <00d501c322f9$ad228e70$6400a8c0@FoxtrotTech0001> <20030526080817.GA5976@cygbert.vinschen.de> <008f01c3239c$63fc3810$c800a8c0@docbill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008f01c3239c$63fc3810$c800a8c0@docbill>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00137.txt.bz2

On Mon, May 26, 2003 at 11:34:46AM -0400, Bill C Riemers wrote:
> I'm not saying there won't be problems if someone using this patch does something like:
>     umask 777
> 
> I'm just saying it is a recoverable mistake.  The umask local to the current process at it's children only.  Executables should
> still execute, but scripts probably won't.  However, just changing the umask back to something more reasonable recovers the file
> permissions.  So even the person who edits the change into their .profile or /etc/profile will be able to restore the previous
> value.

Ok, we should just try it, I guess.  Chris?  Ok to check in?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
