Return-Path: <cygwin-patches-return-3448-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18012 invoked by alias); 21 Jan 2003 22:35:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18003 invoked from network); 21 Jan 2003 22:35:41 -0000
Date: Tue, 21 Jan 2003 22:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
Message-ID: <20030121223702.GA20862@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org> <20030121161115.GA13536@redhat.com> <3E2D79A7.DCC9AF74@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2D79A7.DCC9AF74@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00097.txt.bz2

On Tue, Jan 21, 2003 at 11:47:35AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>>You'd need a per-thread buffer to accomplish that.  I assume that is
>>what you had in mind.
>
>If you look at them, most internal_get{pw,gr} calls from outside of
>passwd.cc and grp.cc only want the {u,g}id, the sid or the name, but
>never the other fields.  I wanted to avoid copying the entire line, at
>least in the first two cases.

Btw, Pierre, can you explain the rationale behind the "check" parameter
that some of the internal_* functions take?  Why would you not want to
check for an up-to-date /etc/passwd or /etc/group?  If not for this, it
seems like we could get rid of the initialization check entirely and
just let fn_changed return true when fn[etc_ix] is uninitialized,
forcing an initial read/parse of the appropriate file.

cgf
