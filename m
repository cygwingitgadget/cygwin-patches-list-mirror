Return-Path: <cygwin-patches-return-3695-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18390 invoked by alias); 11 Mar 2003 23:54:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18376 invoked from network); 11 Mar 2003 23:54:56 -0000
Date: Tue, 11 Mar 2003 23:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030311235503.GA725@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <20030311152028.GF13544@cygbert.vinschen.de> <20030311204438.GA9700@redhat.com> <20030311224927.GI13544@cygbert.vinschen.de> <20030311231915.GA32553@redhat.com> <20030311233801.GK13544@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311233801.GK13544@cygbert.vinschen.de>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00344.txt.bz2

On Wed, Mar 12, 2003 at 12:38:01AM +0100, Corinna Vinschen wrote:
>On Tue, Mar 11, 2003 at 06:19:15PM -0500, Christopher Faylor wrote:
>>On Tue, Mar 11, 2003 at 11:49:27PM +0100, Corinna Vinschen wrote:
>>>On Tue, Mar 11, 2003 at 03:44:38PM -0500, Christopher Faylor wrote:
>>>>Should I put this in 1.3.21?  It's not too late.
>>>
>>>Yes, please, that would be probably helpful.
>>
>>- Fix problem with socket duplication.  (Corinna Vinschen, Pierre
>>Humblet)
>>
>>I probably need something better than this ^^^ right?
>
>What about "Fix permission problems on duplicated sockets after user
>context switch"?
>
>Does anybody read this?  ;-)

Probably not.  Well, I sometimes read them when I want to figure out when
something was fixed.

However, it sometimes seems as if people don't read cygwin-announce at all
or, even, the [ANNOUNCEMENT] messages that show up in the cygwin mailing list.

Witness, the number of times a discussion has raged on (does bash
support /dev/stderr????) beyond the point where a new package has been
released which fixes a problem.

cgf
