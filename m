Return-Path: <cygwin-patches-return-3098-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26545 invoked by alias); 1 Nov 2002 01:39:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26523 invoked from network); 1 Nov 2002 01:39:30 -0000
Date: Thu, 31 Oct 2002 17:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: open() not handling previously opened serial port gracefully?
Message-ID: <20021101014112.GA28476@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021031202037.00829440@mail.attbi.com> <3.0.5.32.20021031192006.00826c90@mail.attbi.com> <3.0.5.32.20021031192006.00826c90@mail.attbi.com> <3.0.5.32.20021031202037.00829440@mail.attbi.com> <3.0.5.32.20021031203203.00827790@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021031203203.00827790@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00049.txt.bz2

On Thu, Oct 31, 2002 at 08:32:03PM -0500, Pierre A. Humblet wrote:
>At 08:31 PM 10/31/2002 -0500, you wrote:
>
>>>- Do you expect a specially formatted string in the -m argument
>>>  of commit?
>>
>>Look at the cygwin-cvs mailing list archives.
>>
>That's what I had done. Looks like copies of the ChangeLog entries.
>Hence the question about automagic.

Convention is to check in the ChangeLog entry as the cvs log message.
If you look at the way Corinna does it versus the way that I do it
versus the way that Robert does it, you'll see subtle differences.
Commit messages are no big deal.

cgf
