Return-Path: <cygwin-patches-return-5216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16175 invoked by alias); 16 Dec 2004 16:05:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15844 invoked from network); 16 Dec 2004 16:05:00 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Dec 2004 16:05:00 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 5907A1B401; Thu, 16 Dec 2004 11:06:07 -0500 (EST)
Date: Thu, 16 Dec 2004 16:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216160607.GH23488@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216160322.GC16474@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00217.txt.bz2

On Thu, Dec 16, 2004 at 05:03:22PM +0100, Corinna Vinschen wrote:
>On Dec 16 10:57, Christopher Faylor wrote:
>> On Thu, Dec 16, 2004 at 04:53:39PM +0100, Corinna Vinschen wrote:
>> >Since the mount code is called from path_conv anyway, wouldn't it be
>> >better to pass the information "managed mount or not" up to path_conv?
>> 
>> How about just doing the pathname munging in `conv_to_win32_path' if/when
>> it's needed?
>
>Erm... I'm not quite sure, but didn't the "remove trailing dots and spaces"
>code start there and has been moved to path_conv by Pierre to circumvent
>some problem?  I recall only very vaguely right now.

One problem that it would circumvent is that currently, if you do this:

ls /bin......................................

You'll get a listing of the bin directory.  If you move the code to
conv_to_win32_path that may not be as easy to get right.

cgf
