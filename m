Return-Path: <cygwin-patches-return-3983-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6922 invoked by alias); 30 Jun 2003 22:54:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6766 invoked from network); 30 Jun 2003 22:54:10 -0000
Date: Mon, 30 Jun 2003 22:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: EIO error on background tty reads
Message-ID: <20030630225407.GA6384@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Law9-OE66lmpcQABZTW0000d939@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law9-OE66lmpcQABZTW0000d939@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00210.txt.bz2

On Mon, Jun 30, 2003 at 05:39:37PM -0400, Rafael Kitover wrote:
>cgf wrote:
>>>What I don't understand is if a background write to a terminal without
>>>sending a
>>>SIGTTOU which it explicitly ignores is allowed, why not a background read?
>>
>>Because that's the way it works.  Have you tried this with linux?  I wrote
>>a test case yesterday.  linux raises an EIO when a background read is
>>attempted, SIGTTIN is ignored, and the process is not a member of the
>>terminal's process group.  Test case below.
>
>Thank you for the test case! The problem with screen may have had more
>to do with the process group than with the read itself, I will do more
>testing on cygwin and linux and fix the appropriate sources, in which case
>I'm sorry for having wasted your time.

No apologies necessary!  I've reworked this section of code many many times
trying to get the arcane UNIX practices correct.  I'm willing to believe
that I've gotten something wrong.  I just need you to tell me what that is,
I guess.  :-)

cgf
