Return-Path: <cygwin-patches-return-2716-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32692 invoked by alias); 25 Jul 2002 16:01:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32677 invoked from network); 25 Jul 2002 16:01:03 -0000
Date: Thu, 25 Jul 2002 09:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: time(time_t*) problem
Message-ID: <20020725160113.GG10541@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020724053334.GA2665@redhat.com> <20020725090142.A1935@SmartSC.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725090142.A1935@SmartSC.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00164.txt.bz2

On Thu, Jul 25, 2002 at 09:01:42AM -0700, David MacMahon wrote:
>On Wed, Jul 24, 2002 at 01:33:34AM -0400, Christopher Faylor wrote:
>>On Tue, Jul 23, 2002 at 10:34:02PM -0700, David MacMahon wrote:
>>>(sorry, I didn't do a Changelog >entry).
>> 
>> Why?
>
>I was a little bit rushed (OK, lazy) at the time.  Below is a better
>submission.  Do you prefer these to be inline (as below) or as
>attachments (or both)?

Inline is fine as long as there are no whitespace problems.  This was
perfect.  The ChangeLog was perfect, too.

Thanks for the patch and for the rationalization of why it was
necessary.  Until I read your message, I thought that cygwin was working
correctly.  Now I can see that it obviously wasn't.

I also love patches that remove code and make cygwin faster, too.  :-)

The patch has been committed.

cgf

>2002-07-24  David MacMahon  <davidm@smartsc.com>
>
>	* times.cc (to_time_t): Always round time_t down to nearest second.
