Return-Path: <cygwin-patches-return-3934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24940 invoked by alias); 9 Jun 2003 15:13:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24779 invoked from network); 9 Jun 2003 15:13:46 -0000
Date: Mon, 09 Jun 2003 15:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609151344.GO18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <20030609150339.GA25784@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609150339.GA25784@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00161.txt.bz2

On Mon, Jun 09, 2003 at 05:03:39PM +0200, Corinna Vinschen wrote:
> On Mon, Jun 09, 2003 at 04:51:19PM +0200, Corinna Vinschen wrote:
> > Oh boy :-(  So I have to upload another version of login which drops the
> > call to setegid() entirely.  Switching back to uid 18 the just reverts
> > to self and the last call to setgid/setuid uses the logon token.
> 
> Or better, call setegid() twice.  This makes the chdir result more
> reliable, I guess.

Nope, that doesn't work.  I've uploaded a new login which only
setuids forth and back.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
