Return-Path: <cygwin-patches-return-2880-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18587 invoked by alias); 28 Aug 2002 15:52:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18573 invoked from network); 28 Aug 2002 15:52:41 -0000
Date: Wed, 28 Aug 2002 08:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: export getc_unlocked, getchar_unlocked, putc_unlocked, putchar_unlocked
Message-ID: <20020828155236.GH4346@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D6BBC26.2060408@netscape.net> <20020828125231.C10870@cygbert.vinschen.de> <3D6CAECC.8070403@netscape.net> <20020828133044.G5475@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020828133044.G5475@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00328.txt.bz2

On Wed, Aug 28, 2002 at 01:30:44PM +0200, Corinna Vinschen wrote:
>On Wed, Aug 28, 2002 at 07:06:52AM -0400, Nicholas Wourms wrote:
>> Corinna Vinschen wrote:
>> 
>> >On Tue, Aug 27, 2002 at 01:51:34PM -0400, Nicholas Wourms wrote:
>> >
>> >>   * cygwin.din: Export getc_unlocked, getchar_unlocked,
>> >>   putc_unlocked, putchar_unlocked functions.
>> >>   * include/cygwin/version.h: Bump api minor.
>> >>
>> >
>> >Applied.  Thanks, but you forgot the ChangeLog for the doc dir.
>> >
>> >Tsk, tsk, tsk, ;-)
>> >
>> Corinna,
>> 
>> Chris had told me not to do changelogs for documentation.  If you want 
>> them, then in future changes I will do so.
>
>Hmm, I didn't know that.  I forgot Chris' motivation somehow...

It's an FSF policy for ChangeLogs.  I don't modify the ChangeLog when
the docs are in a source directory.

However, there *is* a ChangeLog in the doc directory, however, and you
can see that I've updated it.  I think that a directory which is
primarily documentation can have the documentation updated, even if that
seems a tad inconsistent.

cgf
