Return-Path: <cygwin-patches-return-3446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15463 invoked by alias); 21 Jan 2003 21:28:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15452 invoked from network); 21 Jan 2003 21:28:18 -0000
Date: Tue, 21 Jan 2003 21:28:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: nanosleep() patch
In-reply-to: <20030121211649.GA2060@tishler.net>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030121213341.GA952@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_rnNvx50GqQRhbWY3GVrMaA)"
User-Agent: Mutt/1.4i
References: <20030117192853.GA1164@tishler.net>
 <20030121155842.GS29236@cygbert.vinschen.de>
 <20030121160201.GA13579@redhat.com>
 <20030121161706.GU29236@cygbert.vinschen.de>
 <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com>
 <20030121211649.GA2060@tishler.net>
X-SW-Source: 2003-q1/txt/msg00095.txt.bz2


--Boundary_(ID_rnNvx50GqQRhbWY3GVrMaA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 844

On Tue, Jan 21, 2003 at 04:16:49PM -0500, Jason Tishler wrote:
> On Tue, Jan 21, 2003 at 01:05:25PM -0500, Christopher Faylor wrote:
> > I think usleep's implementation was incorrect, actually.
> 
> See attached for my next version which addresses the above too.

> 2003-01-21  Jason Tishler  <jason@tishler.net>
> 
>   * cygwin.din: Export nanosleep().
>   * signal.cc (nanosleep): New function.
>   (sleep): Move old functionality to nanosleep().  Call nanosleep().
>   (usleep): Remove old functionality.  Call nanosleep().
>   * include/cygwin/version.h: Bump DLL minor number.
                                     ^^^
                                     ***

Oops, typo.

See attached.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_rnNvx50GqQRhbWY3GVrMaA)
Content-type: text/plain; charset=us-ascii; NAME=nanosleep2.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nanosleep2.ChangeLog
Content-length: 299

2003-01-21  Jason Tishler  <jason@tishler.net>

	* cygwin.din: Export nanosleep().
	* signal.cc (nanosleep): New function.
	(sleep): Move old functionality to nanosleep().  Call nanosleep().
	(usleep): Remove old functionality.  Call nanosleep().
	* include/cygwin/version.h: Bump API minor number.

--Boundary_(ID_rnNvx50GqQRhbWY3GVrMaA)--
