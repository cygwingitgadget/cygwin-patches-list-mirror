Return-Path: <cygwin-patches-return-3935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25491 invoked by alias); 9 Jun 2003 15:27:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25481 invoked from network); 9 Jun 2003 15:27:34 -0000
Message-ID: <3EE4A7DD.E804213F@ieee.org>
Date: Mon, 09 Jun 2003 15:27:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: exec after seteuid
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net> <20030609121132.GJ18350@cygbert.vinschen.de> <3EE48CF9.536E06B5@ieee.org> <20030609145119.GN18350@cygbert.vinschen.de> <20030609150339.GA25784@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00162.txt.bz2

Corinna Vinschen wrote:
> 
> On Mon, Jun 09, 2003 at 04:51:19PM +0200, Corinna Vinschen wrote:
> > Oh boy :-(  So I have to upload another version of login which drops the
> > call to setegid() entirely.  Switching back to uid 18 the just reverts
> > to self and the last call to setgid/setuid uses the logon token.
> 
> Or better, call setegid() twice.  

Make that "three times", or 2 x setegid() + 1 x setgid()
That looks more Unix-like, but as you said it's mostly fake.

That's what the login.c I sent yesterday was doing, btw.

Pierre
