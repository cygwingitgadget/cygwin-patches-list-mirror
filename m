Return-Path: <cygwin-patches-return-4908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28185 invoked by alias); 21 Aug 2004 15:37:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28175 invoked from network); 21 Aug 2004 15:37:30 -0000
Date: Sat, 21 Aug 2004 15:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler_disk_file::fchmod
Message-ID: <20040821153809.GC9939@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821094631.007dee80@incoming.verizon.net> <20040821135321.GB9451@trixie.casa.cgf.cx> <20040821150818.GD27978@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821150818.GD27978@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00060.txt.bz2

On Sat, Aug 21, 2004 at 05:08:18PM +0200, Corinna Vinschen wrote:
>On Aug 21 09:53, Christopher Faylor wrote:
>> On Sat, Aug 21, 2004 at 09:46:31AM -0400, Pierre A. Humblet wrote:
>> >This bug was found while investigating testsuite failures.  It occurs
>> >only on 9x, when ntsec is on.  An alternate (more general) solution
>> >would be to only set allow_ntsec (in environ.cc) on NT.  Why allow it
>> >on 9x?
>> 
>> That was my first reaction on looking at your patch before reading the
>> above comment.
>> 
>> Why don't we do that?  It seems like it would simplify things slightly
>> throughout cygwin.
>
>allow_ntsec is only set to true on NT by default.  The above problem can
>only occur if somebody explicitely sets CYGWIN=ntsec on a 9x system (sic).
>
>What about this:
>
>	* environ.cc (set_ntea): New function.
>	(set_ntsec): Ditto.
>	(set_smbntsec): Ditto.
>	(parse_thing): Change ntea, ntsec and smbntsec settings to call
>	appropriate functions.

Looks good.

cgf
