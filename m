Return-Path: <cygwin-patches-return-3411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22137 invoked by alias); 16 Jan 2003 14:11:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22120 invoked from network); 16 Jan 2003 14:11:37 -0000
Date: Thu, 16 Jan 2003 14:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: NT 4.0 fixup_mmaps_after_fork() patch
Message-ID: <20030116141135.GC1373@cygbert.vinschen.de>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@cygwin.com>
References: <20030115191918.GA1016@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115191918.GA1016@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00060.txt.bz2

On Wed, Jan 15, 2003 at 02:19:19PM -0500, Jason Tishler wrote:
> It appears that ReadProcessMemory() can fail with ERROR_NOACCESS under
> NT 4.0.  See attached patch.

Applied.  Thanks!

> BTW, my mmap-test test case works under NT 4.0 without this patch.
> However, vsFTPd does not.  Go figure!

Details?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
