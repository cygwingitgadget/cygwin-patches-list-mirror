Return-Path: <cygwin-patches-return-5027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17796 invoked by alias); 6 Oct 2004 15:46:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17785 invoked from network); 6 Oct 2004 15:46:41 -0000
Date: Wed, 06 Oct 2004 15:46:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about trailing (back)slash on mount entries
Message-ID: <20041006154644.GE29973@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag> <20041006145931.GC29289@trixie.casa.cgf.cx> <41640F89.9AEEFD2A@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41640F89.9AEEFD2A@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00028.txt.bz2

On Wed, Oct 06, 2004 at 11:30:17AM -0400, Pierre A. Humblet wrote:
>
>Christopher Faylor wrote:
>> 
>> On Wed, Oct 06, 2004 at 03:12:45PM +0200, Bas van Gompel wrote:
>> >Another (hopefully trivial) patch, to help in trouble-shooting.
>> 
>> Wasn't there another problem where "foo\/bar" type of entries were
>> showing up?  Could you add a check for that, too?
>
>I while ago I have modified Cygwin to accept this kind of syntax.
>Is there a remaining problem in the current release?
>Otherwise I don't see the need to alarm the user.

It's just a warning.  This really shouldn't be in the mount table
and it really should be corrected.

cgf
