Return-Path: <cygwin-patches-return-4874-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13500 invoked by alias); 22 Jul 2004 15:15:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13357 invoked from network); 22 Jul 2004 15:15:15 -0000
Date: Thu, 22 Jul 2004 15:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040722151433.GD3457@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40FE87D6.3C89AE1F@phumblet.no-ip.org> <40FE87D6.3C89AE1F@phumblet.no-ip.org> <3.0.5.32.20040721232519.00810350@incoming.verizon.net> <20040722041721.GA29883@trixie.casa.cgf.cx> <Pine.GSO.4.58.0407221043180.29040@slinky.cs.nyu.edu> <40FFD5F8.86AEBBAA@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFD5F8.86AEBBAA@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00026.txt.bz2

On Thu, Jul 22, 2004 at 10:58:00AM -0400, Pierre A. Humblet wrote:
>Igor Pechtchanski wrote:
>> On Thu, 22 Jul 2004, Christopher Faylor wrote:
>>>On Wed, Jul 21, 2004 at 11:25:19PM -0400, Pierre A.  Humblet wrote:
>>>>Is it worth to delay 1.5.11 until those issues are sorted out?
>>>
>>>No, I don't think so.
>>>
>>>We do have people reporting problems with MapViewOfFileEx and with
>>>threads in perl, now, though.  So, 1.5.11 is not quite cooked.
>>
>>Unfortunately, the problems with MapViewOfFileEx are elusive and hard
>>to reproduce, even for some of those people reporting them (i.e., me
>>:-}).  Since they aren't critical for me (I can just re-run the command
>>if I get one of those), I personally don't mind if 1.5.11 is released
>>without a fix (unless there's something I can do to help track them
>>down sooner).  I don't speak for Volker, though.
>
>I share Igor's opinion.  1.5.11 as it is solves a fair number of
>annoying issues.  Regarding /dev/dsp, I would apply Gert's latest
>patches.  It's progress, and not an impediment to making more progress
>later.

Sorry but I disagree on both counts.  1) I don't want to release cygwin
with a known regression and 2) I don't want to apply a patch that I
don't entirely agree with in the hopes that someone will "do it the
right way" at some nebulous point in the future.

I could possibly be convinced about 1 but I'm rather adamant about 2.
