Return-Path: <cygwin-patches-return-5233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4208 invoked by alias); 17 Dec 2004 06:16:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4163 invoked from network); 17 Dec 2004 06:16:32 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 06:16:32 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 6A8321B401; Fri, 17 Dec 2004 01:17:41 -0500 (EST)
Date: Fri, 17 Dec 2004 06:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041217061741.GG26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041217032627.GF26712@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041216224347.0082d210@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00234.txt.bz2

On Thu, Dec 16, 2004 at 10:43:47PM -0500, Pierre A. Humblet wrote:
>At 10:27 PM 12/16/2004 -0500, Christopher Faylor wrote:
>>On Thu, Dec 16, 2004 at 10:26:27PM -0500, Christopher Faylor wrote:
>>>I don't see how it could be correct for the slash checking code not to
>>>be "in the loop".  Won't this cause a problem if you've done
>>
>>Ah, nevermind.  I see that your patch handles that.
>>
>OK.
>
>The key point in my patch is that it's the output Win32 path
>that must be checked, not the input path.

How can that be?  As I mentioned previously, if you don't perform the
fixups prior to inspecting the mount table then "ls /bin.........."
won't work.

cgf
