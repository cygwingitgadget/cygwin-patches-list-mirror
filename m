Return-Path: <cygwin-patches-return-4909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4816 invoked by alias); 21 Aug 2004 15:52:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4806 invoked from network); 21 Aug 2004 15:52:04 -0000
Date: Sat, 21 Aug 2004 15:52:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler_disk_file::fchmod
Message-ID: <20040821155230.GA11401@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821094631.007dee80@incoming.verizon.net> <20040821135321.GB9451@trixie.casa.cgf.cx> <20040821150818.GD27978@cygbert.vinschen.de> <20040821153809.GC9939@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821153809.GC9939@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00061.txt.bz2

On Aug 21 11:38, Christopher Faylor wrote:
> On Sat, Aug 21, 2004 at 05:08:18PM +0200, Corinna Vinschen wrote:
> >	* environ.cc (set_ntea): New function.
> >	(set_ntsec): Ditto.
> >	(set_smbntsec): Ditto.
> >	(parse_thing): Change ntea, ntsec and smbntsec settings to call
> >	appropriate functions.
> 
> Looks good.

Thanks.  Checked in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
