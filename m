Return-Path: <cygwin-patches-return-4472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3946 invoked by alias); 3 Dec 2003 11:23:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3937 invoked from network); 3 Dec 2003 11:23:13 -0000
Date: Wed, 03 Dec 2003 11:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031203112312.GL1640@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <3.0.5.32.20031203001035.0082a100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031203001035.0082a100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00191.txt.bz2

On Wed, Dec 03, 2003 at 12:10:35AM -0500, Pierre A. Humblet wrote:
> Hmm, the patch below might be a useful preliminary.

Urgh!  Thanks for catching this.

> Also, on WinME specifying a length of 0 (changed to 0xFFFFFFFF) doesn't 
> seem to work when the starting offset is greater than 1.
> No time to fully investigate. 
> Perhaps start + length must be <= 0x100000000 ???

Perhaps yes, to stay in the 32 bit arena or, well...

*dig, dig , dig*

You're right.  I've tested that on 98 and it fails if start+len
is > 0x100000000 and it works if start+len is == 0x100000000.
Weird.  I've checked in a fix to fhandler_disk_file::lock().
I think I'm playing sufficiently safe by using the value
0xffffffff - offset.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
