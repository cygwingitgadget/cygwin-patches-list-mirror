Return-Path: <cygwin-patches-return-3569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18228 invoked by alias); 14 Feb 2003 21:16:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18191 invoked from network); 14 Feb 2003 21:16:02 -0000
Date: Fri, 14 Feb 2003 21:16:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: mprotect() missing break patch
Message-ID: <20030214211600.GA10012@cygbert.vinschen.de>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@cygwin.com>
References: <20030214193417.GA2608@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214193417.GA2608@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00218.txt.bz2

On Fri, Feb 14, 2003 at 02:34:17PM -0500, Jason Tishler wrote:
> Corinna,
> 
> The attach patch adds a missing break statement that causes the
> following under Windows 2000:

Oops.

> 2003-02-14  Jason Tishler  <jason@tishler.net>
> 
> 	* mmap.cc (mprotect): Add missing break.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
